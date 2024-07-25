# odj - Open DJ Deck

This project documents an entirely open source DJ deck similar in functionality to the Pioneer CDJ/XDJ units.
Refer to the ODJ website for further information and updates on development (likely to be updated more frequently than this README)

## Summary
While the cost of electonic components has significantly gone down over the years, these items have seen no similar decrease in price, and only minimal increase in functionality for the high pricepoint.
This project seeks to rectify that fact by providing all information to assemble one yourself, with the use of:
- 3D printed components wherever possible, using parts designed with parameterization, allowing customization
- Commonly available and affordable off-the-shelf hardware components where necessary, with multiple options provided to account for regional sourcing differences
- Custom PCB design availble for sending to local manufacturers and again able to be edited for customization
- PCB design chosen based on the use of affordable and readily available components
- Open source firmware written to run the device also a part of this repository

This project is an ongoing and currently only early days so please bear with me as I slowly make progress with everythin that needs doing.
It's also a reasonably large undertaking so if you have advice, suggestions, or ideas, I am very much open and welcome any feedback or criticism. I want this to end up with a high quality product so if I'm making a poor decision anywhere please let me know.

## Current status
My current focus is on the mechanical jogwheel design as it's an important part to get right.
The first rough version was printed some time ago and I'm working on a list of changes to make based on the results.
I've also been working on parameterising the design *much* better in order to make it more versatile for variable scaling of different parts.

## Future plans
In no specific order, the next lot of things I'll be working on are:
- Begin development on an RPi (platform for test dev only) of audio output including tempo and pitch bending, etc.
- Mock up a set of inputs (buttons, sliding and rotary pots, etc.) to hook up to the RPi to test physical inputs
- Continue with iterating the jogwheel design as required

## Longer term
There's a fair bit of work to do in the above, so longer term tasks will be a while coming. 
They will include:
- Select a hardware platform (microcontroller or similar) suitable for the performance requirements of the developed code 
- Begin design of first PCB iteration based on mocked-up circuitry and selected mcu
- Solidify jogwheel design and proceed onto the rest of the chassis with mounting points for the button/pot inputs

## Conclusions
As always with a project like this, the details above may change as development proceeds. Things may progress differently to how I imagine right now, and they might also progress much *slower* than some people might like.
But I only have so much time for extracurricular activities, so it'll have to do.

Please get in touch if you have any comments, questions, advice, etc.

And thanks for your interest!

Tom
