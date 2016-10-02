function [x, s, fs, bits] = ld_psdtf_bss(audio_file, M, N, K, iterations)

%% pre-processing %%

% read audio file (monaural, fs = 16000, bits = 16)
[x, fs, bits]  = wavread(audio_file);

% make window function (stddev = M / 3)
w = gausswin(M, 3.0);

% make DFT matrix
F = dftmtx(M) / sqrt(M);

% define shifting interval (10 [ms])
interval = length(x) / N;

% calculate covariance matrices
X = zeros(M, M, N);

x0 = [zeros(M / 2, 1); x; zeros(M / 2 - interval, 1)];

for n = 1 : N
  x_n = x0(1 + interval * (n - 1) : M + interval * (n - 1)) .* w;
  X(:, :, n) = x_n * x_n';
end

%% LD-PSDTF %%

% initialize random number generator
rand('twister', sum(100 * clock));

% initialize parameters
[cost, W, H, Y, XiY] = ld_psdtf_init(X, K, 1);
fprintf(1, 'cost[%d] = %f\n', length(cost), cost(length(cost)));

% update parameters
for it = 1 : iterations
  [cost, W, H, Y, XiY] = ld_psdtf_train(cost, W, H, Y, XiY, X, 1);
  fprintf(1, 'cost[%d] = %f\n', length(cost), cost(length(cost)));
end

%% post-processing %%

% execute Wiener filtering
s = zeros(length(x) + M - interval, K);

for n = 1 : N
  for k = 1 : K
    range = 1 + interval * (n - 1) : M + interval * (n - 1);
    s(range, k) = s(range, k) + (H(n, k) * W(:, :, k)) / Y(:, :, n) * (x0(range) .* w);
  end
end

s = s(M / 2 + 1 : M / 2 + interval * N, :);

% display bases & activations
for k = 1 : K
  subplot(2, K, k); imagesc(W(:, :, k));
  title(['Basis matrix W' num2str(k)])
  set(gca,'XTick',[0:M/8:M])
  set(gca,'YTick',[0:M/8:M])
  xlim([0 M])
  
  subplot(2, K, K + k); plot(H(:, k));
  title(['Activation vector h' num2str(k)])
  xlim([0 N])
end
