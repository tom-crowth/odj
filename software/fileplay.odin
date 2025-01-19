package odj_sound

import "core:fmt"
import "core:os"
import "core:strings"
import ma "vendor:miniaudio"
// use no spatialization flag in future if needed
// MA_SOUND_FLAG_NO_SPATIALIZATION

FILE :: "/home/tom/Downloads/ak_veela_discomfort.wav"

file_play_callback :: proc "c" (pDevice: ^ma.device, pOutput, pInput: rawptr, frame_count: u32) {
	pDecoder: ^ma.decoder = cast(^ma.decoder)pDevice.pUserData
	if pDecoder == nil {
		return
	}

	ma.decoder_read_pcm_frames(pDecoder, pOutput, cast(u64)frame_count, nil)
	_ = pInput

}

load_song :: proc(file: string, decoder: ^ma.decoder) {
	cstr_file: cstring = strings.clone_to_cstring(file)
	if ma.decoder_init_file(cstr_file, nil, decoder) != ma.result.SUCCESS {
		fmt.panicf("Could not load file: %s\n", file)
	}
	// proc is not finished yet

}


main :: proc() {
	fmt.println("Open DJ Audio playing test code")
	result: ma.result
	decoder: ma.decoder
	device_config: ma.device_config
	device: ma.device

	if ma.decoder_init_file(FILE, nil, &decoder) != ma.result.SUCCESS {
		fmt.panicf("Could not load file: %s\n", FILE)
	}
	defer ma.decoder_uninit(&decoder)

	device_config = ma.device_config_init(ma.device_type.playback)
	device_config.playback.format = decoder.outputFormat
	device_config.playback.channels = decoder.outputChannels
	device_config.sampleRate = decoder.outputSampleRate
	device_config.dataCallback = file_play_callback
	device_config.pUserData = &decoder


	if ma.device_init(nil, &device_config, &device) != ma.result.SUCCESS {
		fmt.panicf("Failed to open playback device.\n")
	}
	defer ma.device_uninit(&device)

	fmt.printfln("Device ID: %w", device.playback.id)
	fmt.printfln("Device SR: %d", device.sampleRate)
	fmt.printfln("Device Name: %s", device.playback.name)

	if ma.device_start(&device) != ma.result.SUCCESS {
		fmt.println("Failed to start playback device.")
		return
	}

	fmt.println("Press Enter to quit...")
	buf: [256]byte
	os.read(os.stdin, buf[:])

}
