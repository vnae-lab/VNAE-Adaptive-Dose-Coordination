using Plots
using LinearAlgebra

# ------------------------------------------------------------
# VNAE Adaptive Dose Coordination - Fully Parametric (N = 20)
# ------------------------------------------------------------

# Number of agents / protocols
N = 20

# Asymmetric dissipation parameters (theta_i)
# Higher theta = more rigid / conservative protocol
theta = [
    0.30, 0.45, 0.80, 0.55, 0.70,
    0.90, 0.60, 0.40, 1.10, 0.65,
    0.50, 0.75, 0.35, 0.95, 0.85,
    0.60, 0.40, 0.70, 1.00, 0.55
]

# Initial protocol intensities (abstract states)
x0 = [
    -1.5, -0.8,  0.4,  1.2, -0.6,
     0.9, -1.1,  0.7, -0.3,  1.5,
    -0.9,  0.2, -1.3,  1.0,  0.6,
    -0.4,  0.8, -0.7,  1.3, -0.2
]

# Time discretization
dt = 0.01
T_max = 15.0
time_seq = 0:dt:T_max
n_steps = length(time_seq)

# Coordination Structure (Graph Laplacian - Ring Topology)
L = zeros(N, N)
for i in 1:N
    L[i, i] = 2
    L[i, (i % N) + 1] = -1
    L[i, ((i - 2 + N) % N) + 1] = -1
end

# Storage
X = zeros(n_steps, N)
X[1, :] = x0

# VNAE Dynamics: dx/dt = -L x - Theta x
for t in 2:n_steps
    x = X[t-1, :]
    # theta .* x applies the unique asymmetry of each protocol
    dx = -L * x - (theta .* x)
    X[t, :] = x + dt * dx
end

# Global Convergence Diagnostic (Euclidean Norm)
state_norm = [norm(X[t, :]) for t in 1:n_steps]

# Visualization 1: Trajectories
p1 = plot(time_seq, X, lw=1.5, legend=false,
          title="Asymmetric Coordination under VNAE (N = 20)",
          xlabel="Time", ylabel="Protocol intensity")

# Visualization 2: Global State Norm
p2 = plot(time_seq, state_norm, lw=2, color=:black,
          title="Structural Convergence (Global Norm)",
          xlabel="Time", ylabel="||X||", fill=(0, 0.2, :black))

# Display both side by side or stacked
plot(p1, p2, layout=(2, 1), size=(800, 700))
