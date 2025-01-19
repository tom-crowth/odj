package odj_sound

import "core:fmt"
import "core:os"
import ma "vendor:miniaudio"
// use no spatialization flag in future if needed
// MA_SOUND_FLAG_NO_SPATIALIZATION

// DEVICE_CHANNELS :: 2
// DEVICE_SAMPLE_RATE :: 48_000
DEVICE_CHANNELS :: 0
DEVICE_SAMPLE_RATE :: 0


sine_play_callback :: proc "c" (pDevice: ^ma.device, pOutput, pInput: rawptr, frame_count: u32) {
	pSinewave: ^ma.waveform = cast(^ma.waveform)pDevice.pUserData
	if pSinewave == nil {
		return
	}

	// is this a bug in the vendor lib? frame_count is u32 in device_data_proc but u64 in the below proc
	ma.waveform_read_pcm_frames(pSinewave, pOutput, cast(u64)frame_count, nil)
	_ = pInput
	// pInput is unused
}


other_main :: proc() {
	fmt.println("Open DJ Audio playing test code")
	sinewave: ma.waveform
	device_config: ma.device_config
	device: ma.device
	sinewave_config: ma.waveform_config

	device_config = ma.device_config_init(ma.device_type.playback)
	device_config.playback.format = ma.format.f32
	device_config.playback.channels = DEVICE_CHANNELS
	device_config.sampleRate = DEVICE_SAMPLE_RATE
	device_config.dataCallback = sine_play_callback
	device_config.pUserData = &sinewave

	if ma.device_init(nil, &device_config, &device) != ma.result.SUCCESS {
		fmt.panicf("Failed to open playback device.")
	}
	defer ma.device_uninit(&device)

	fmt.printfln("Device ID: %w", device.playback.id)
	fmt.printfln("Device SR: %d", device.sampleRate)
	fmt.printfln("Device Name: %s", device.playback.name)

	sinewave_config = ma.waveform_config_init(
		device.playback.playback_format,
		device.playback.channels,
		device.sampleRate,
		ma.waveform_type.sine,
		1,
		1000,
	)

	if ma.waveform_init(&sinewave_config, &sinewave) != ma.result.SUCCESS {
		fmt.panicf("Failed to initialise waveform.\n")
	}
	defer ma.waveform_uninit(&sinewave)

	if ma.device_start(&device) != ma.result.SUCCESS {
		fmt.panicf("Failed to start playback device.")
	}

	fmt.println("Press Enter to quit...")
	buf: [256]byte
	os.read(os.stdin, buf[:])

}
