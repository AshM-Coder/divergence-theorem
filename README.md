# Divergence Theorem: Symbolic and Numerical Verification

MATLAB scripts that verify the divergence theorem for a unit sphere sitting inside a 3D vector field, using three complementary approaches: visualisation, exact symbolic computation, and discrete numerical approximation.

## Overview

The divergence theorem states that the volume integral of a vector field's divergence over a closed region equals the surface integral of the field across the boundary of that region:

```
∭ᵥ div(F) dV = ∯ₛ F · n̂ dS
```

Here, the region is a unit sphere and the field is F = [x·z², x·y, y·z]. The theorem is confirmed two independent ways — once exactly, using symbolic math, and once approximately, using discrete summation — and the two results are compared.

## Files

- **`vector_field_visualization.m`** — plots the unit sphere, its outward surface normal vectors, and the vector field itself on a single 3D figure, to build intuition for the geometry before the calculation.
- **`symbolic_verification.m`** — uses the MATLAB Symbolic Math Toolbox to compute both sides of the theorem exactly: the volume integral of the divergence (via a change of variables to spherical coordinates, using the Jacobian of the transformation) and the surface integral of the field's normal component, then checks that the two match.
- **`numerical_verification.m`** — computes both sides of the theorem numerically instead: discretises the enclosing cube into a fine grid and sums the divergence over all grid points inside the sphere for the volume integral, and sums the field's normal component over a discretised spherical surface for the surface integral. No symbolic toolbox required.

## Method notes

- The symbolic script performs the coordinate transformation manually (Cartesian → spherical) rather than using MATLAB's built-in `cart2sph`, so the Jacobian and substitutions are done explicitly.
- Comparing symbolic expressions for exact equality can be fragile in general, since two mathematically equivalent expressions don't always simplify to an identical form — worth keeping in mind if adapting this to a different vector field.
- The numerical script uses MATLAB's built-in `divergence` function for the volume integral, and an explicit dot-product summation over surface normals for the surface integral.
- Expect a small discrepancy between the symbolic and numerical results — this comes from the finite grid resolution in the numerical approximation, not from an error in either method.

## Running it

Requires MATLAB. `symbolic_verification.m` requires the **Symbolic Math Toolbox**; the other two scripts use only base MATLAB.

```matlab
vector_field_visualization
symbolic_verification
numerical_verification
```

## License

MIT — see `LICENSE`.
