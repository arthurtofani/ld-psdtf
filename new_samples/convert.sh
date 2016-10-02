sox -v 0.9 ./44100/01_c.wav -q ./16000/01_c.wav rate 16000
sox -v 0.9 ./44100/01_e.wav -q ./16000/01_e.wav rate 16000
sox -v 0.9 ./44100/01_g.wav -q ./16000/01_g.wav rate 16000
sox -v 0.9 ./44100/02_c.wav -q ./16000/02_c.wav rate 16000
sox -v 0.9 ./44100/02_e.wav -q ./16000/02_e.wav rate 16000
sox -v 0.9 ./44100/02_g.wav -q ./16000/02_g.wav rate 16000
sox -v 0.9 ./44100/03_c.wav -q ./16000/03_c.wav rate 16000
sox -v 0.9 ./44100/03_e.wav -q ./16000/03_e.wav rate 16000
sox -v 0.9 ./44100/03_g.wav -q ./16000/03_g.wav rate 16000
sox -v 0.9 ./44100/04_c.wav -q ./16000/04_c.wav rate 16000
sox -v 0.9 ./44100/04_e.wav -q ./16000/04_e.wav rate 16000
sox -v 0.9 ./44100/04_g.wav -q ./16000/04_g.wav rate 16000
sox -v 0.9 ./44100/05_c.wav -q ./16000/05_c.wav rate 16000
sox -v 0.9 ./44100/05_e.wav -q ./16000/05_e.wav rate 16000
sox -v 0.9 ./44100/05_g.wav -q ./16000/05_g.wav rate 16000
sox -v 0.9 ./44100/06_c.wav -q ./16000/06_c.wav rate 16000
sox -v 0.9 ./44100/06_e.wav -q ./16000/06_e.wav rate 16000
sox -v 0.9 ./44100/06_g.wav -q ./16000/06_g.wav rate 16000

sox -m ./16000/01_c.wav ./16000/01_e.wav ./16000/01_g.wav ./16000/01_mix.wav
sox -m ./16000/02_c.wav ./16000/02_e.wav ./16000/02_g.wav ./16000/02_mix.wav
sox -m ./16000/03_c.wav ./16000/03_e.wav ./16000/03_g.wav ./16000/03_mix.wav
sox -m ./16000/04_c.wav ./16000/04_e.wav ./16000/04_g.wav ./16000/04_mix.wav
sox -m ./16000/05_c.wav ./16000/05_e.wav ./16000/05_g.wav ./16000/05_mix.wav
sox -m ./16000/06_c.wav ./16000/06_e.wav ./16000/06_g.wav ./16000/06_mix.wav
