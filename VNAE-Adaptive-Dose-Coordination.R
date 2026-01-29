# ------------------------------------------------------------
# VNAE Adaptive Dose Coordination
# Fully Parametric Example (N = 20)
# ------------------------------------------------------------
# Abstract model illustrating asymmetric coordination
# via heterogeneous dissipation parameters.
# No clinical interpretation is implied.
# ------------------------------------------------------------

rm(list = ls())

# ------------------------------------------------------------
# USER-DEFINED PARAMETERS
# ------------------------------------------------------------

# Number of agents / protocols
N <- 20

# Asymmetric dissipation parameters (theta_i)
# Higher theta = more rigid / conservative protocol
theta <- c(
  0.30, 0.45, 0.80, 0.55, 0.70,
  0.90, 0.60, 0.40, 1.10, 0.65,
  0.50, 0.75, 0.35, 0.95, 0.85,
  0.60, 0.40, 0.70, 1.00, 0.55
)

# Initial protocol intensities (abstract states)
x0 <- c(
  -1.5, -0.8,  0.4,  1.2, -0.6,
   0.9, -1.1,  0.7, -0.3,  1.5,
  -0.9,  0.2, -1.3,  1.0,  0.6,
  -0.4,  0.8, -0.7,  1.3, -0.2
)

# Time discretization
dt <- 0.01
T  <- 15
time <- seq(0, T, by = dt)

# ------------------------------------------------------------
# COORDINATION STRUCTURE (GRAPH LAPLACIAN)
# ------------------------------------------------------------

# Ring topology
L <- matrix(0, N, N)
for (i in 1:N) {
  L[i, i] <- 2
  L[i, (i %% N) + 1] <- -1
  L[i, ((i - 2 + N) %% N) + 1] <- -1
}

# ------------------------------------------------------------
# STORAGE
# ------------------------------------------------------------

X <- matrix(0, length(time), N)
X[1, ] <- x0

# ------------------------------------------------------------
# VNAE DYNAMICS
# dx/dt = -L x - Theta x
# ------------------------------------------------------------

for (t in 2:length(time)) {
  x  <- X[t - 1, ]
  dx <- -L %*% x - theta * x
  X[t, ] <- x + dt * dx
}

# ------------------------------------------------------------
# VISUALIZATION
# ------------------------------------------------------------

matplot(time, X, type = "l", lwd = 2,
        xlab = "Time",
        ylab = "Protocol intensity (abstract)",
        main = "Asymmetric Coordination under VNAE (N = 20)")
grid()

# ------------------------------------------------------------
# GLOBAL CONVERGENCE DIAGNOSTIC
# ------------------------------------------------------------

state_norm <- apply(X, 1, function(v) sqrt(sum(v^2)))

plot(time, state_norm, type = "l", lwd = 2,
     xlab = "Time",
     ylab = "Global state norm",
     main = "Structural Convergence Induced by Asymmetry")
grid()


