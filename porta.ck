class ModSin extends Chubgraph
{
	SinOsc m => SinOsc c => outlet;
	2 => c.sync;
	//defaults
	440 => float cf => c.freq;
	5   => float mf => m.freq;
	5   => float mg => m.gain;

	fun float getfreq()
		{ return c.freq(); }
	fun void freq(float f)
		{ f => cf => c.freq; }

	fun void modfreq(float f)
		{ f => mf => m.freq; }

	fun void modwidth(float f)
		{ f => mg => m.gain; }
}

ModSin s => NRev n => dac;
ModSin t => n;

0.03 => n.mix; //verb mix

// define porta 
fun void porta ( float target, ModSin in ){
     (target - in.getfreq() )/50 =>  float delta;
     for (int i; i < 50; i++){
      (in.getfreq() + delta) => in.freq;
        20::ms => now;
            }
}

300 => s.freq;
500 => t.freq;

t.modwidth(1);
3::second=>now;
spork ~ porta( 600, s);
spork ~ porta( 700, t);
t.modwidth(15);
3::second=>now;
spork ~ porta( 800,s );
spork ~ porta( 900,t );
3::second => now;


    

 
