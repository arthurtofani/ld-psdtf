function aa = run_kl_nmf(name, iterations)
% name = '01', '02'...
%iterations = 200
pkg load signal;
method_folder = 'kl_nmf';
M = 512;
N = 1440;
K = 3;
timestart = clock;
logfile = fopen(strcat('./sources/', method_folder, '/', name ,'.txt'),'a');
fprintf(logfile, strcat(datestr(now, 'dd mm yyyy HH:MM:SS.FFF'), '\t\t', 'start iterations', '\n'));

[x, s, fs, bits] = kl_nmf_bss(strcat('./new_samples/16000/', name ,'_mix.wav'), M, N, K, iterations);
for k = 1 : K
  wavwrite(s(:, k), fs, bits, ['./sources/kl_nmf/' name '_' ['1', '2', '3'](k) '.wav']);
end
fprintf(logfile, strcat(datestr(now, 'dd mm yyyy HH:MM:SS.FFF'), '\t\t', 'end iterations', '\n'));
fprintf(logfile, 'TOTAL: %f', etime(clock, timestart));
fprintf(logfile, '\n');

%% read groundtruth
fprintf(logfile, strcat(datestr(now, 'dd mm yyyy HH:MM:SS.FFF'), '\t\t', 'reading groundtruth', '\n'));

g = zeros(length(x), K);
g(:, 1) = wavread(strcat('./new_samples/16000/', name, '_c.wav'));
g(:, 2) = wavread(strcat('./new_samples/16000/', name, '_e.wav'));
g(:, 3) = wavread(strcat('./new_samples/16000/', name, '_g.wav'));


%% evaluate performance
%% read groundtruth
fprintf(logfile, strcat(datestr(now, 'dd mm yyyy HH:MM:SS.FFF'), '\t\t', 'evaluating performance', '\n'));

[SDR, SIR, SAR, perm] = bss_eval_sources(s', g');
fprintf(logfile, 'AverageSDR = %f [dB]\n', mean(SDR));
fprintf(logfile, 'AverageSIR = %f [dB]\n', mean(SIR));
fprintf(logfile, 'AverageSAR = %f [dB]\n', mean(SAR));

%% finish
fprintf(logfile, 'Sample 01 - END - %s \n', datestr(now, 'dd mm yyyy HH:MM:SS.FFF'));
fprintf('\n');

fprintf(logfile, '************************************************************');
fprintf('\n');
fprintf('\n');


fclose(logfile)
