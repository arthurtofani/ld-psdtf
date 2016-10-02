pkg load signal;

M = 512;
N = 1440;
K = 3;
iterations = 200;
dstart = now


[x, s, fs, bits] = is_nmf_bss('./new_samples/16000/03_mix.wav', M, N, K, iterations);
for k = 1 : K
  wavwrite(s(:, k), fs, bits, ['./sources/is_nmf/03_' ['c', 'e', 'g'](k) '.wav']);
end
%% read groundtruth
fprintf(1, 'Sample 03 - Read Groundtruth - %s \n', datestr(now, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');

g = zeros(length(x), K);
g(:, 1) = wavread('./new_samples/16000/03_c.wav');
g(:, 2) = wavread('./new_samples/16000/03_e.wav');
g(:, 3) = wavread('./new_samples/16000/03_g.wav');

fprintf(1, 'Sample 03 - Run IS-NMF - %s \n', datestr(dstart, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');


%% evaluate performance
fprintf(1, 'Sample 03 - Evaluate - %s \n', datestr(now, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');

[SDR, SIR, SAR, perm] = bss_eval_sources(s', g');
fprintf(1, 'AverageSDR = %f [dB]\n', mean(SDR));
fprintf(1, 'AverageSIR = %f [dB]\n', mean(SIR));
fprintf(1, 'AverageSAR = %f [dB]\n', mean(SAR));

%% finish
fprintf(1, 'Sample 03 - END - %s \n', datestr(now, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');
