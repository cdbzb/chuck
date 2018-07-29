<<<"loading">>>;

public class ModSin extends Chubgraph
{
	SinOsc m => SinOsc c => outlet;
	2 => c.sync;
	//defaults
	440 => float cf => c.freq;
	5   => float mf => m.freq;
	5   => float mg => m.gain;

	fun void freq(float f)
    {
        f => cf => c.freq;
    }
    
    fun void modfreq(float f)
    {
        f => mf => m.freq;
    }
    
    fun void modwidth(float f)
    {
        f => mg => m.gain;
    }

}


