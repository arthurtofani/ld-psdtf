pkg load signal;

M = 512;
N = 1440;
K = 3;
iterations = 20;
logfile = fopen('./sources/is_nmf/01.txt','w');

[x, s, fs, bits] = is_nmf_bss('./new_samples/16000/01_mix.wav', M, N, K, iterations);
for k = 1 : K
  wavwrite(s(:, k), fs, bits, ['./sources/is_nmf/01_' ['c', 'e', 'g'](k) '.wav']);
end

fprintf(1, 'Sample 01 - Run IS-NMF - %s \n', datestr(now, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');


%% read groundtruth
fprintf(1, 'Sample 01 - Read Groundtruth - %s \n', datestr(now, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');

g = zeros(length(x), K);
g(:, 1) = wavread('./new_samples/16000/01_c.wav');
g(:, 2) = wavread('./new_samples/16000/01_e.wav');
g(:, 3) = wavread('./new_samples/16000/01_g.wav');



%% evaluate performance
fprintf(1, 'Sample 01 - Evaluate - %s \n', datestr(now, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');

[SDR, SIR, SAR, perm] = bss_eval_sources(s', g');
fprintf(1, 'AverageSDR = %f [dB]\n', mean(SDR));
fprintf(1, 'AverageSIR = %f [dB]\n', mean(SIR));
fprintf(1, 'AverageSAR = %f [dB]\n', mean(SAR));

%% finish
fprintf(1, 'Sample 01 - END - %s \n', datestr(now, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');
