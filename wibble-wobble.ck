SinOsc lfo => blackhole;
SinOsc s => NRev n => dac;
0.03 => n.mix;
440 => float pitch;
0.0 => float slide;
 Envelope e => blackhole;
    3::second => dur t => e.duration;

fun void wibble() { 
    while (20::ms => now)
    e.value() * 1000 + 100=> slide ;
}

spork ~ wibble();

// set the frequency of the lfo
5 => lfo.freq;

fun void wobble() {while (20::ms => now){
    ( lfo.last() * 10 ) + pitch + slide => s.freq;
}}

spork ~ wobble();

1::second => now;
<<<s.freq()>>>;
e.keyOn();
400 => pitch;
1::second => now;
300 => pitch;
4 => lfo.freq;
2::second => now;
0 => slide;
3::second => now;



//This class implements a simple envelope
//generator which is capable of ramping to
//a target value by a specified \e rate.
//I/t also responds to simple \e keyOn and
//\e keyOff messages, ramping to 1.0 on
//keyOn and to 0.0 on keyOff.
//by Perry R. Cook and Gary P. Scavone, 1995 - 2002.
//[ctrl param]
// .keyOn (int, WRITE only) ramp to 1.0
// .keyOff (int, WRITE only) ramp to 0.0
// .target (float, READ/WRITE) ramp to arbitrary value
// .time (float, READ/WRITE) time to reach target (in second)
// .duration (dur, READ/WRITE) time to reach target
// .rate (float, READ/WRITE) rate of change
// .value (float, READ/WRITE) set immediate value
