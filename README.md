# Lab 2 — 2D Convolution & FIR Filters (Blur, Sharpen, Edges)

**Course:** Mathematical Algorithms (DSP) — Image Processing Labs  
**Submission:** Include screenshots and short explanations for each section. Submit only the GitHub URL.

---

## What this lab shows

- **Kernels as FIR impulse responses** (h[m,n])  
- **Low-pass filters:** Box vs Gaussian (and why Gaussian is preferred)  
- **Separable filters:** Two 1D passes instead of one 2D pass  
- **Sharpening:** Unsharp masking (blur → high-freq mask → add back)  
- **Edges:** Sobel gradients & Laplacian  
- **Correlation vs Convolution:** Kernel flipping matters  
- **Boundary handling:** replicate, symmetric, circular

---

## How to run

1. Save `lab2_conv_fir.m` in a folder with MATLAB access.  
2. (Optional) Place `peppers.png` in the same folder; otherwise it will use `cameraman.tif`.  
3. Run in MATLAB:
   ```matlab
   lab2_conv_fir
   ```
4. Screenshots will automatically save to the `figures/` folder.

---

## Sections & What to screenshot

### 1) Delta image & impulse response
- **Figure:** Impulse response of a 3×3 average filter.  
- **Note:** Convolution of a delta with `h` visualizes the filter’s shape.

### 2) Low-pass: box vs Gaussian, separability
- **Figure:** Montage showing `Original | Box 3x3 | Box 7x7 | Gaussian`.  
- **Note:** Gaussian gives smoother blur and fewer ripples than box filter.

### 3) Unsharp masking (sharpen)
- **Figure:** `Original | Blur | High-freq mask | Sharpened`.  
- **Note:** Enhances edges by adding high-frequency content back.

### 4) Edges: Sobel & Laplacian
- **Figure:** `Sobel Gx | Sobel Gy | Gradient magnitude | Laplacian`.  
- **Note:** Sobel detects edges via gradient; Laplacian enhances outlines.

### 5) Correlation vs convolution
- **Console Output:** Compare `conv2` vs `imfilter` results.  
- **Note:** Convolution flips the kernel; correlation does not.

### 6) Boundary handling
- **Figure:** `replicate | symmetric | circular`.  
- **Note:** Boundary handling affects blur near edges and corners.

---

## Short reflections

1. **Why prefer Gaussian over a large box LP?**  
   Gaussian has smoother frequency response and fewer ripples, giving more natural blur.

2. **What does separability do for computational cost?**  
   Converts a 2D N×N convolution into two 1D passes (O(N²) → O(2N)), saving time.

3. **How do boundary modes change corners/edges?**  
   They define how pixels beyond image borders are handled—affecting visual continuity.

---

## Output Folder
All generated figures are automatically saved in the `figures/` directory.
