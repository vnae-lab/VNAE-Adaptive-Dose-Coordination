# VNAE Asymmetric Protocol Coordination

## Overview

This repository presents an abstract coordination model inspired by biological
and medical systems, interpreted through the VNAE framework.

The focus is not biological realism, but the structural role of asymmetry in
producing stable global behavior.

---

## Model

We consider a network of N interacting protocols, each represented by a scalar
state variable xᵢ(t).

The dynamics are given by:

    dx/dt = − L x − Θ x

where:

- x ∈ ℝⁿ is the vector of protocol intensities  
- L is the graph Laplacian encoding coordination constraints  
- Θ = diag(θ₁, …, θₙ) is a diagonal matrix of asymmetric dissipation parameters  
- θᵢ > 0 represents protocol-specific rigidity or conservatism  

---

## Interpretation

- The Laplacian term enforces coordination between interacting protocols.
- The asymmetric dissipation term introduces heterogeneous contraction rates.
- No optimization, symmetry, or equilibrium matching is assumed.

Global convergence follows from the **geometry of dissipation**, rather than
parameter tuning.

---

## VNAE Stability

Within the VNAE framework:

- Heterogeneity induces an effective **positive curvature (K > 0)** in state space.
- Positive curvature guarantees **global structural stability**, even when local
  dynamics differ across agents.
- Stability is geometric, not numerical.

This model provides a concrete operational example of VNAE stability in practice.

---

## Scope and Limitations

Below, we can see some positive insights:

✔️ Conceptual and theoretical model  
✔️ Suitable for biological and medical abstraction  
✔️ No empirical or clinical claims  
✔️ Parameter transparency and full reproducibility  
✔️ Applicable as a foundation for extended or hybrid models  

The following limitations are explicit and deliberate:

❌ Not a physiological model  
❌ No patient data  
❌ No dosage recommendations  
❌ No pharmacokinetic or pharmacodynamic modeling  
❌ No validation against experimental or clinical benchmarks  

---

## Implementation

The simulation is implemented in **R, Julia, Python,and Matlab **, with all asymmetry parameters and initial
conditions explicitly defined to emphasize interpretability and reproducibility.

---

## Reference

Pereira, D. H. (2025). Riemannian Manifolds of Asymmetric Equilibria: The Victoria-Nash Geometry.

---

## License

MIT License


