(
~bpm = 70;

SynthDef(\strong, {
	arg freq=1000, cut=2000;
	var sig;
	sig = Saw.ar(freq);
	sig = LPF.ar(sig, cut);
	sig = sig * Env.perc(0.01, 0.15).kr(2);
	Out.ar(0, sig!2);
}).load;

SynthDef(\weak, {
	arg freq=500, cut=500;
	var sig;
	sig = Saw.ar(freq);
	sig = LPF.ar(sig, cut);
	sig = sig * Env.perc(0.01, 0.15).kr(2);
	Out.ar(0, sig!2);
}).load;

p = Pdef(\metro, Pbind(
	\dur, 60/1/~bpm,
	\instrument, Pseq([\strong] ++ (\weak!3), inf);
));

OSCdef(\m, {
	arg msg, time, addr, port;
	[msg, time, addr, port].postln;
	if (msg[1] == 0) {Synth(\strong)} {Synth(\weak)};
}, \metro);
)