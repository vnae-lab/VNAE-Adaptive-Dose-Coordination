% ------------------------------------------------------------
% VNAE Adaptive Dose Coordination - Fully Parametric (N = 20)
% ------------------------------------------------------------
clear; clc;

% Number of agents / protocols
N = 20;

% Asymmetric dissipation parameters (theta_i)
% Higher theta = more rigid / conservative protocol
theta = [0.30, 0.45, 0.80, 0.55, 0.70, ...
         0.90, 0.60, 0.40, 1.10, 0.65, ...
         0.50, 0.75, 0.35, 0.95, 0.85, ...
         0.60, 0.40, 0.70, 1.00, 0.55];

% Initial protocol intensities (abstract states)
x0 = [-1.5, -0.8,  0.4,  1.2, -0.6, ...
       0.9, -1.1,  0.7, -0.3,  1.5, ...
      -0.9,  0.2, -1.3,  1.0,  0.6, ...
      -0.4,  0.8, -0.7,  1.3, -0.2]';

% Time discretization
dt = 0.01;
T_max = 15;
time_seq = 0:dt:T_max;
n_steps = length(time_seq);

% Coordination Structure (Graph Laplacian - Ring Topology)
L = zeros(N, N);
for i = 1:N
    L(i, i) = 2;
    L(i, mod(i, N) + 1) = -1;
    L(i, mod(i - 2 + N, N) + 1) = -1;
end

% Storage
X = zeros(N, n_steps);
X(:, 1) = x0;

% VNAE Dynamics: dx/dt = -L x - Theta x
for t = 2:n_steps
    x_prev = X(:, t-1);
    % Matrix multiplication and element-wise scaling
    dx = -L*x_prev - (theta' .* x_prev);
    X(:, t) = x_prev + dt * dx;
end

% Global Convergence Diagnostic (Euclidean Norm)
state_norm = zeros(1, n_steps);
for t = 1:n_steps
    state_norm(t) = norm(X(:, t));
end

% Visualization
figure('Color', 'w', 'Position', [100, 100, 800, 600]);

% Subplot 1: Trajectories
subplot(2, 1, 1);
plot(time_seq, X, 'LineWidth', 1.5);
title('Asymmetric Coordination under VNAE (N = 20)');
ylabel('Protocol intensity');
grid on;

% Subplot 2: Global State Norm
subplot(2, 1, 2);
area(time_seq, state_norm, 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', 'k');
title('Structural Convergence Induced by Asymmetry');
xlabel('Time (s)');
ylabel('||X(t)||');
grid on;
