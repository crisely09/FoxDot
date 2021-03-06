SynthDef.new(\pads,
{|amp=1, sus=1, pan=0, freq=0, vib=0, fmod=0, rate=0, bus=0|
var osc, env;
freq = In.kr(bus, 1);
freq = [freq, freq+fmod];
amp=(amp * 1.5);
freq=(freq + [0, 1]);
osc=(SinOsc.ar(freq, mul: amp) + Pulse.ar(freq, width: LFTri.kr((sus / 16)), iphase: 0.5, mul: (amp / 20)));
osc=HPF.ar(osc, 1000);
env=EnvGen.ar(Env.perc(attackTime: 0.01,releaseTime: sus,level: amp,curve: 0), doneAction: 0);
osc=(osc * env);
osc = Mix(osc) * 0.5;
osc = Pan2.ar(osc, pan);
	ReplaceOut.ar(bus, osc)}).add;
