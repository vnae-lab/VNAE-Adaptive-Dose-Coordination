import numpy as np
import matplotlib.pyplot as plt

# ------------------------------------------------------------
# VNAE Adaptive Dose Coordination - Fully Parametric (N = 20)
# ------------------------------------------------------------

# Number of agents / protocols
N = 20

# Asymmetric dissipation parameters (theta_i)
# Higher theta = more rigid / conservative protocol
theta = np.array([
    0.30, 0.45, 0.80, 0.55, 0.70,
    0.90, 0.60, 0.40, 1.10, 0.65,
    0.50, 0.75, 0.35, 0.95, 0.85,
    0.60, 0.40, 0.70, 1.00, 0.55
])

# Initial protocol intensities (abstract states)
x0 = np.array([
    -1.5, -0.8,  0.4,  1.2, -0.6,
     0.9, -1.1,  0.7, -0.3,  1.5,
    -0.9,  0.2, -1.3,  1.0,  0.6,
    -0.4,  0.8, -0.7,  1.3, -0.2
])

# Time discretization
dt = 0.01
T_max = 15
time_seq = np.arange(0, T_max + dt, dt)
n_steps = len(time_seq)

# Coordination Structure (Graph Laplacian - Ring Topology)
L = np.zeros((N, N))
for i in range(N):
    L[i, i] = 2
    # Next neighbor (ring)
    L[i, (i + 1) % N] = -1
    # Previous neighbor (ring)
    L[i, (i - 1 + N) % N] = -1

# Storage
X = np.zeros((n_steps, N))
X[0, :] = x0

# VNAE Dynamics: dx/dt = -L x - Theta x
for t in range(1, n_steps):
    x_prev = X[t-1, :]
    # Matrix multiplication with .dot() and element-wise with *
    dx = -L.dot(x_prev) - (theta * x_prev)
    X[t, :] = x_prev + dt * dx

# Global Convergence Diagnostic (Euclidean Norm)
state_norm = np.linalg.norm(X, axis=1)

# Visualization
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 10))

# Plot 1: Trajectories
for i in range(N):
    ax1.plot(time_seq, X[:, i], alpha=0.7, linewidth=1.5)
ax1.set_title("Asymmetric Coordination under VNAE (N = 20)")
ax1.set_xlabel("Time")
ax1.set_ylabel("Protocol intensity")
ax1.grid(True, linestyle='--', alpha=0.6)

# Plot 2: Global State Norm (Convergence Diagnostic)
ax2.fill_between(time_seq, state_norm, color="black", alpha=0.2)
ax2.plot(time_seq, state_norm, color="black", linewidth=2)
ax2.set_title("Structural Convergence (Global State Norm)")
ax2.set_xlabel("Time")
ax2.set_ylabel("||X||")
ax2.grid(True, linestyle='--', alpha=0.6)

plt.tight_layout()
plt.show()
