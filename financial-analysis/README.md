# Financial Projections for Investor Pitch

## Reflections on Bias and Ethics

This project stretched my understanding of bias and ethics in data analysis and presentation. Tasked with creating financial projections to secure $30,000 from investors after our fitness app’s pilot campaign, we faced a critical question: where’s the line between letting the data tell our story and using it to craft a narrative? We’re not Facebook with skyrocketing numbers, but there *is* promise in our results. The challenge was to showcase that potential—doing justice to our pilot data—without crossing into bias. Early attempts showed a weak LTV/CAC trend (R² = 0.09) due to recent, immature campaigns. By rescoping to the pilot phase (Aug 2023 - Mar 2024), we clarified the story ethically, balancing transparency with persuasion—a lesson I carry into all my analytical work.

## Overview

This financial analysis supported a successful pitch to raise $30,000 from investors following our fitness app’s pilot campaign. It focuses on projecting the Lifetime Value to Customer Acquisition Cost (LTV/CAC) ratio—a key metric for investors—using data from the initial pilot phase (August 2023 to March 2024). Built in R, Version 2 of the analysis examines trends post-August 2023 marketing push, visualizes LTV and CAC over time, and includes a trendline to highlight growth potential. The output, a dual-axis plot, was used in our investor deck to demonstrate scalability and promise, showcasing my skills in financial modeling, data visualization, and ethical storytelling.

## Skills Demonstrated

- **Financial Analysis**: Calculated and projected LTV/CAC ratios to assess business viability.
- **R Programming**: Used `ggplot2`, `tidyr`, and `scales` for data manipulation and visualization.
- **Data Visualization**: Designed a dual-axis plot with trendline and R² annotation for clear communication.
- **Ethical Data Handling**: Hardcoded summarized metrics to protect sensitive financial data while enabling team collaboration; rescoped analysis for transparency.
- **Statistical Modeling**: Applied linear regression to quantify trends in LTV/CAC growth.

## Project Structure

The analysis is driven by a single R script, refined in Version 2:

1. **Data Input**:
   - Hardcoded a data frame with monthly LTV and CAC values from August 2023 to March 2024, reflecting the pilot phase post-August marketing campaign.
   - Hardcoding simplified use for interns and safeguarded core financials.

2. **Processing**:
   - Calculated the LTV/CAC ratio for each month.
   - Performed linear regression on the scaled ratio to assess trend strength (R²).

3. **Visualization**:
   - Created a dual-axis plot with:
     - Bars for LTV and CAC (in USD).
     - A line for the LTV/CAC ratio (scaled by 10) with a dotted trendline.
     - R² annotation to quantify trend reliability.
   - Saved as JPEG and PDF for the investor pitch deck.

## Key Features

- **Investor Focus**: Emphasized LTV/CAC, the top metric requested by investors.
- **Scoped Clarity**: Limited to pilot phase (Aug 2023 - Mar 2024) to reflect mature data, excluding recent campaigns with incomplete LTV.
- **Practical Design**: Hardcoded data for accessibility and confidentiality.
- **Visual Insight**: Dual-axis plot with statistical trendline balances metrics and growth potential.

## Technologies Used

- **R**: Core language for analysis and visualization.
- **Libraries**:
  - `ggplot2`: Plot creation and customization.
  - `tidyr`: Data reshaping for plotting.
  - `scales`: Axis formatting.
- **Output**: JPEG and PDF files for pitch deck integration.
- **Git/GitHub**: Version control and hosting.

## How to View the Code

The script is hosted in the [`financial-analysis`](https://github.com/HunterKleinschmidt/analytics-portfolio/tree/main/financial-analysis) directory:
- [`ltv_cac_analysis.R`](https://github.com/HunterKleinschmidt/analytics-portfolio/blob/main/financial-analysis/scripts/ltv_cac_analysis.R): Version 2 of the script for LTV/CAC calculation, regression, and visualization (pilot phase).

## How It Works

1. **Data Setup**: A manual data frame holds 8 months of LTV and CAC data (Aug 2023 - Mar 2024), hardcoded for simplicity and security.
2. **Analysis**: Computes the LTV/CAC ratio and runs a linear regression on the scaled ratio to measure trend strength.
3. **Visualization**: Plots LTV and CAC as bars, overlays the LTV/CAC ratio as a line with a trendline, and annotates R².
4. **Output**: Exports the plot as `LTV_CAC_Graph_Pilot.jpeg` and `LTV_CAC_Graph_Pilot.pdf` for investor use.

## Challenges and Solutions

- **Bias vs. Promise**: 
  - *Challenge*: Initial analysis showed a weak LTV/CAC trend (R² = 0.09) due to recent, immature campaigns (April/May 2024).
  - *Solution*: Rescoped to the pilot phase (Aug 2023 - Mar 2024), excluding recent data with incomplete LTV, and used a trendline with improved R² to ground optimism in evidence.
- **Limited Data Access**: 
  - *Challenge*: Protecting sensitive financials from interns unfamiliar with R.
  - *Solution*: Hardcoded summarized metrics, simplifying the process while maintaining confidentiality.
- **Small Sample Size**: 
  - *Challenge*: Limited to 8 months of mature data after rescoping.
  - *Solution*: Focused on the proven "trickle" effect from the August 2023 campaign, emphasizing trend over absolute forecasts.

## Future Improvements

- Integrate live data from a secure database instead of hardcoding.
- Expand to include additional metrics (e.g., churn rate, revenue growth).
- Automate plot generation and integration into a reporting pipeline.

## Contact

Reach out via my [website](https://hunterkleinschmidt.github.io/) or email at [hunter@kleinstrength.com](mailto:hunter@kleinstrength.com) to discuss this project further.
