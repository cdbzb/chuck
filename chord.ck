NRev n => dac;
n.mix(0.03); //verb mix

ModSin m[4];

for(int i; i<4; i++){
	m[i] => n;
	0.01 => m[i].gain;
	5+i*0.1 => m[i].modfreq;
}

	[
	[ 300.0,400.0,500.0,600.0],
	[ 350.0 , 450.0 , 575.0 , 900.0],
	[ 300.0,400.0,500.0,1200.0],
	[ 250.0, 400.0 , 550.0 ,1050.0],
	[ 250.0,400.0,500.0,600.0]
	]
 @=> float notes[][]  ;

fun void porta ( float target, ModSin in ){
     (target - in.getfreq() )/50 =>  float delta;
     for (int i; i < 50; i++){
      (in.getfreq() + delta) => in.freq;
        20::ms => now;
            }
}

fun void playem (){
for(int c; c<notes.cap();c++){
	for(int i; i<notes[c].cap(); i++){
	spork ~ porta (notes[c][i],m[i]);
	}
	3::second => now;
}
}

while(1)
playem();
