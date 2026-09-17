# 🏛️ The Coca-Cola Company: Corporate FP&A Command Center
**Multi-Period Performance Analysis, Revenue Variance Drivers & FY2026 Baseline Forecast**

An institutional-grade Financial Planning & Analysis (FP&A) repository analyzing The Coca-Cola Company across FY2023–FY2025, supported by an end-to-end analytical pipeline: **SEC 10-K Data → Excel Modeling → SQL Validation → Power BI Dashboard → Executive Briefing**.

---

## ⚡ Executive Summary (1-Minute Briefing)

* **The Problem:** Evaluate post-inflationary revenue resilience, pricing elasticity, and profitability sustainability across global operations and the EMEA segment.
* **The Data:** 3-year audited financial datasets covering consolidated P&L statements, segment reporting (EMEA), and growth driver attributions (Price/Mix, Volume, FX, Divestitures).
* **The Tools:** Microsoft Excel (Financial Modeling), SQL (Integrity Audits & Aggregations), Power BI (Executive BI Architecture), Microsoft Word (C-Suite Summary).
* **The Findings:** Net Revenue increased from $45.75bn to $47.94bn (~2.36% CAGR). FY2025 operating margin expanded to 28.71% led by price execution.
* **The 2026 Forecast Scenario:** Baseline analytical projection yields **$49.70bn in Revenue** and **$14.27bn in Operating Income** based on historical benchmarks.

---

## 📈 Core Financial Scorecard (2023–2026P)

| Indicator | FY2023 | FY2024 | FY2025 | FY2026 (Baseline Projection) |
| :--- | :--- | :--- | :--- | :--- |
| **Net Operating Revenue** | $45,754M | $47,061M | $47,941M | **$49,699M (~$49.70bn)** |
| **Gross Profit Margin** | 59.52% | 60.00% | 61.63% | — |
| **Operating Income** | $11,311M | $9,992M | $13,762M | **$14,270M (~$14.27bn)** |
| **Operating Margin** | 24.72% | 21.23% | 28.71% | **28.71% (Exit-Rate Assumption)** |
| **EMEA Revenue Contribution**| 16.20% | 15.80% | 22.60% | — |

---

## 🔬 Analytical & Forecasting Methodology

1. **Revenue Growth Modeling:**
   * Calculated historical multi-period revenue growth rates across FY2023–FY2025, arriving at a 3-year historical average of **3.67%**.
   * Applied this benchmark to FY2025 consolidated revenue:
     $$\text{Forecast Revenue}_{2026} = \$47,941\text{M} \times (1 + 3.67\%) = \$49,698.84\text{M} \approx \mathbf{\$49.70bn}$$

2. **Operating Income Baseline Scenario:**
   * Utilized the **FY2025 Exit-Rate Margin (28.71%)** as the baseline retention assumption, capturing the latest historical operating margin level rather than diluting performance with earlier multi-period averages:
     $$\text{Forecast Operating Income}_{2026} = \$49,698.84\text{M} \times 28.71\% = \$14,268.54\text{M} \approx \mathbf{\$14.27bn}$$

---

## 📁 Repository Structure

```text
coca-cola-fpa-command-center/
│
├── README.md                 # Executive portfolio documentation
├── data/                     # Source financial datasets (Excel / CSV)
├── excel/                    # Financial modeling schedules & variance sheets
├── sql/                      # Validation queries & multi-period aggregations
├── powerbi/                  # Production .pbix file & export PDF report
├── screenshots/              # High-resolution dashboard page visuals
├── forecasting/              # 2026 forecast scenario schedules & calculations
├── financial_model/          # Methodology notes & P&L bridge structure
└── executive_summary/        # 2-page C-suite briefing document (.docx & .pdf)
