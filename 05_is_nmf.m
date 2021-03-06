pkg load signal;

M = 512;
N = 1440;
K = 3;
iterations = 200;
% iterations = 10;
dstart = now

fprintf(1, 'Sample 05 - Run IS-NMF - %s \n', datestr(now, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');

[x, s, fs, bits] = is_nmf_bss('./new_samples/16000/05_mix.wav', M, N, K, iterations);
for k = 1 : K
  wavwrite(s(:, k), fs, bits, ['./sources/is_nmf/05_' ['c', 'e', 'g'](k) '.wav']);
end

fprintf(1, 'Sample 05 - Run IS-NMF - %s \n', datestr(dstart, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');


%% read groundtruth
fprintf(1, 'Sample 05 - Read Groundtruth - %s \n', datestr(now, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');

g = zeros(length(x), K);
g(:, 1) = wavread('./new_samples/16000/05_c.wav');
g(:, 2) = wavread('./new_samples/16000/05_e.wav');
g(:, 3) = wavread('./new_samples/16000/05_g.wav');

%% evaluate performance
fprintf(1, 'Sample 05 - Evaluate - %s \n', datestr(now, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');

[SDR, SIR, SAR, perm] = bss_eval_sources(s', g');
fprintf(1, 'AverageSDR = %f [dB]\n', mean(SDR));
fprintf(1, 'AverageSIR = %f [dB]\n', mean(SIR));
fprintf(1, 'AverageSAR = %f [dB]\n', mean(SAR));

%% finish
fprintf(1, 'Sample 05 - END - %s \n', datestr(now, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');
