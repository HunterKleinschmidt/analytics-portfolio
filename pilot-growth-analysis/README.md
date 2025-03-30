# Pilot Growth Analysis

## Reflections on Bias and Ethics

This project pushed me to grapple with bias and ethics in data analysis. Working with data from our fitness app’s pilot campaign, I faced a key challenge: how to tell a truthful story with modest data without overreaching? Early attempts showed a weak LTV/CAC trend (R² = 0.09) due to recent, incomplete campaigns. By rescoping to the pilot phase (Aug 2023 - Mar 2024) and uncovering cohort stickiness by first payment month, I refined the analysis ethically—balancing data integrity with insight. This work secured $30,000 in funding, proving its impact, and honed my analytical skills for real-world challenges.

## Overview

This analysis explored Lifetime Value to Customer Acquisition Cost (LTV/CAC) trends and cohort retention using pilot data from our fitness app (August 2023 to March 2024), contributing to a $30,000 funding win. Built in R, Version 2 of the project analyzes the post-launch period, revealing how stickiness in early cohorts (Aug, Sep, Oct 2023) drove a drop in CAC and sustained LTV. The output—a dual-axis LTV/CAC plot with regression trendline (R² = 0.65)—was enhanced by cohort retention analysis using subscription data from our [Klein Data Pipeline](https://github.com/HunterKleinschmidt/analytics-portfolio/tree/main/data-processing). This work showcases my expertise in financial modeling, data visualization, retention analysis, and strategic growth planning.

## Skills Demonstrated

- **Financial Analysis**: Projected LTV/CAC ratios (R² = 0.65) and linked trends to cohort retention.
- **R Programming**: Used `ggplot2`, `tidyr`, and `scales` for visualization; `dplyr` and `lubridate` for cohort analysis.
- **Data Visualization**: Crafted a dual-axis plot and cohort retention graph with custom labels.
- **Ethical Data Handling**: Hardcoded data for team use while protecting financials; rescoped for transparency.
- **Cohort Analysis**: Quantified retention by first payment month to explain CAC and LTV patterns.
- **Strategic Growth Planning**: Identified scaling opportunities to achieve "escape velocity" for revenue growth.

## Project Structure

The analysis combines two R scripts with data from the Klein Data Pipeline:

1. **LTV/CAC Analysis**:
   - Hardcoded monthly LTV and CAC values (Aug 2023 - Mar 2024) for the pilot phase.
   - Computed LTV/CAC ratios and ran regression to quantify trends (R² = 0.65).
   - Visualized results in a dual-axis plot.

2. **Cohort Retention Analysis**:
   - Used subscription data (`subscriptions.csv`) to split cohorts by first payment month (Aug, Sep, Oct 2023).
   - Measured retention duration to explain CAC drop and LTV stability.
   - Visualized retention in a cohort plot with custom labels.

## Key Features

- **Business Impact**: Secured $30,000 in funding through data-backed insights.
- **Cohort Insight**: Showed stickiness in Aug, Sep, and Oct 2023 cohorts, driving CAC reduction and LTV stability.
- **Scoped Precision**: Focused on the pilot phase for mature data.
- **Practical Approach**: Hardcoded data for usability and confidentiality.
- **Low Overhead**: Maintained impressively low overhead costs, enabling efficient scaling potential.

## Technologies Used

- **R**: Core language for analysis and visualization.
- **Libraries**:
  - `ggplot2`, `tidyr`, `scales`: Plotting and data reshaping.
  - `dplyr`, `lubridate`: Cohort analysis and date handling.
- **Data**: Hardcoded LTV/CAC; subscription CSV from Klein Data Pipeline.
- **Output**: JPEG plots for reporting.
- **Git/GitHub**: Version control and hosting.

## How to View the Code and Outputs

Scripts and outputs are hosted in the [`pilot-growth-analysis`](https://github.com/HunterKleinschmidt/analytics-portfolio/tree/main/pilot-growth-analysis) directory:
- [`ltv_cac_analysis.R`](https://github.com/HunterKleinschmidt/analytics-portfolio/blob/main/pilot-growth-analysis/scripts/ltv_cac_analysis.R): LTV/CAC trends and visualization (pilot phase).
- [`cohort_retention_by_join_month.R`](https://github.com/HunterKleinschmidt/analytics-portfolio/blob/main/pilot-growth-analysis/scripts/cohort_retention_by_join_month.R): Retention analysis by first payment month (Aug, Sep, Oct 2023).
- **Plots**:
  - [LTV/CAC Plot](https://github.com/HunterKleinschmidt/analytics-portfolio/blob/main/pilot-growth-analysis/graphs/LTV_CAC_Graph_Pilot.jpeg): Dual-axis plot of LTV, CAC, and ratio.
  - [Cohort Retention Plot](https://github.com/HunterKleinschmidt/analytics-portfolio/blob/main/pilot-growth-analysis/graphs/cohort_retention_by_join_month.jpeg): Retention by join month cohort.

*Data source*: Subscription data from the [Klein Data Pipeline](https://github.com/HunterKleinschmidt/analytics-portfolio/tree/main/data-processing) (not uploaded).

## How It Works

1. **Data Setup**: Hardcoded 8 months of LTV and CAC data (Aug 2023 - Mar 2024); used `subscriptions.csv` for cohort splits.
2. **LTV/CAC Analysis**: Calculated LTV/CAC ratios, ran regression for trends (R² = 0.65), and visualized in a dual-axis plot.
3. **Cohort Retention**: Split users by first payment month (Aug, Sep, Oct 2023), measured retention, and visualized in a cohort plot.
4. **Output**: Generated `LTV_CAC_Graph_Pilot.jpeg` and `cohort_retention_by_join_month.jpeg`, used to secure funding.

## Why the $30,000 Funding? Achieving Escape Velocity

Despite the pilot’s success—low overhead, a strong LTV/CAC ratio (R² = 0.65), and cohort stickiness driving efficiency—the scale of our marketing campaigns was too small to achieve significant revenue growth. The pilot operated on a limited scope, reaching only a niche audience. While our overhead costs remained impressively low, the marketing efforts lacked the scale to "get out of orbit" and reach a broader market. The final "Get Out of Orbit" graph presented to investors illustrated this concept, formally known as **scaling for escape velocity**. This term describes the point where a business achieves sufficient growth momentum to break free from initial constraints (e.g., small market reach) and attain exponential revenue growth. The $30,000 funding is crucial to scale marketing efforts, allowing us to expand our reach while maintaining low overhead, thus achieving the "escape velocity" needed for sustainable, orbit-breaking growth.

## Challenges and Solutions

- **Bias vs. Insight**: 
  - *Challenge*: Initial LTV/CAC trend was weak (R² = 0.09) due to recent campaigns.
  - *Solution*: Rescoped to the pilot phase, improving trend clarity (R² = 0.65) and integrity.
- **Explaining Trends**: 
  - *Challenge*: Understanding CAC drop after two months with steady LTV.
  - *Solution*: Analyzed retention by first payment month, showing early cohort stickiness drove efficiency.
- **Team Constraints**: 
  - *Challenge*: Enabling interns without exposing raw financials.
  - *Solution*: Hardcoded summarized data for ease and security.

## Future Improvements

- Integrate campaign metadata for precise cohort tracking.
- Expand with metrics like churn rate or cohort-specific LTV.
- Automate cohort visualization into a reporting workflow.

## Contact

Reach out via my [website](https://hunterkleinschmidt.github.io/) or email at [hunter@kleinstrength.com](mailto:hunter@kleinstrength.com) to discuss this project further.
