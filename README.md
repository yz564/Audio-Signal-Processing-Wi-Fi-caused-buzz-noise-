# Audio-Signal-Processing-Wi-Fi-caused-buzz-noise-
Including the (inverse) Fourier transform, amplitude modulation, filters. The model description can be found in the paper (WIFI caused buzz noise modeling.pdf)

This is my first project. I am proud on it as I found a correct model to describe the long standing problem: how the RF signals (for example 5 GHz WiFi) be captured by the microphone and finally become audible to human.

A very interesting application: use my model inversely (take the square root and add some filters) on audio data (say somthing like "Hey xxx, play some music."), modulate it to a WiFi band (using signal generators and a mixer), transmit it on the air with an antenna. You definitely cannot hear anything because it's RF, but a buzz noise vulnerable device may hear the "hidden" voice, and play a music "by it self".

Sounds cool, right? Do you want to have a try with your mobile phone or tablet? 
