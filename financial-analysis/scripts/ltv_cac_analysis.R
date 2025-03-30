# -------------------------------
# Install and Load Required Packages
# -------------------------------
packages <- c("ggplot2", "tidyr", "scales")
for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

# -------------------------------
# Create a Data Frame Manually
# -------------------------------
data <- data.frame(
  # 'Month' is a factor to maintain the desired order in plots.
  Month = factor(c("Aug-23", "Sep-23", "Oct-23", "Nov-23", "Dec-23", "Jan-24", "Feb-24", "Mar-24", "Apr-24", "May-24"),
                 levels = c("Aug-23", "Sep-23", "Oct-23", "Nov-23", "Dec-23", "Jan-24", "Feb-24", "Mar-24", "Apr-24", "May-24")),
  LTV = c(11, 21, 27, 36, 36, 37, 36, 37, 38, 41),   # Customer Lifetime Value
  CAC = c(37, 9, 13, 12, 11, 10, 12, 12, 21, 22)      # Customer Acquisition Cost
)

# Display the data to verify its structure
print("Preview of the data frame:")
print(head(data))
print("Summary of the data:")
print(summary(data))

# -------------------------------
# Calculate Additional Variables
# -------------------------------
# Calculate the LTV/CAC ratio
data$Ratio <- data$LTV / data$CAC

# -------------------------------
# Reshape the Data for Plotting
# -------------------------------
# Convert data from wide to long format for ggplot2 plotting
data_long <- gather(data, key = "Metric", value = "Value", -Month, -Ratio)
print("Reshaped data (long format):")
print(head(data_long))

# -------------------------------
# Additional Statistical Analysis
# -------------------------------
# Run a linear regression on the scaled LTV/CAC ratio (scaled by 10 for plotting)
lm_model <- lm((Ratio * 10) ~ as.numeric(Month), data = data)
print("Linear Regression Model Summary:")
print(summary(lm_model))
# Calculate R-squared for annotation
r_squared <- round(summary(lm_model)$r.squared, 2)
annotation_text <- paste("Trendline R² =", r_squared)

# -------------------------------
# Create the Plot Using ggplot2 with a Minimal Theme
# -------------------------------
# 'theme_minimal()' provides a clean baseline. As a UI designer, you appreciate having a blank canvas to fine-tune aesthetics.
plot <- ggplot() +
  # Bar plot for LTV and CAC
  geom_bar(data = data_long, aes(x = Month, y = Value, fill = Metric),
           stat = "identity", position = position_dodge(), size = 0.5) +
  # Line plot for the scaled LTV/CAC Ratio
  geom_line(data = data, aes(x = Month, y = Ratio * 10, group = 1,
                             linetype = "LTV/CAC Ratio"),
            size = 2, color = "black") +
  # Dotted trendline for the ratio using a linear model
  geom_smooth(data = data, aes(x = Month, y = Ratio * 10, group = 1,
                               linetype = "Trendline for LTV/CAC Ratio"),
              method = "lm", se = FALSE, size = 2, color = "black") +
  # Define the primary y-axis (US Dollars) and secondary y-axis (LTV/CAC Ratio)
  scale_y_continuous(
    name = "US Dollars",
    sec.axis = sec_axis(~./10, name = "LTV/CAC Ratio")
  ) +
  # Add plot titles and labels
  labs(
    title = "Customer Lifetime Value (LTV) and Customer Acquisition Cost (CAC) Over Time",
    x = "Months Since Launch",
    fill = "Metric",
    linetype = "Metric"
  ) +
  # Customize colors and line types
  scale_fill_manual(values = c("LTV" = "steelblue", "CAC" = "salmon")) +
  scale_linetype_manual(values = c("LTV/CAC Ratio" = "solid", "Trendline for LTV/CAC Ratio" = "dotted")) +
  theme_minimal() +  # Use minimal theme as a clean canvas for further customization.
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title.y.left = element_text(color = "black", size = 12),
    axis.title.y.right = element_text(color = "black", size = 12),
    axis.text = element_text(size = 10),
    legend.position = "right",
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  ) +
  # Annotate the plot with the minimal calculation result (R-squared)
  annotate("text", x = "May-24", y = max(data$LTV) + 3, label = annotation_text,
           hjust = 1, size = 4, color = "black")

# Display the plot
print(plot)

# -------------------------------
# Save the Plot to Files
# -------------------------------
# Adjust the file path if necessary.
ggsave("H:/Desktop/LTV_CAC_Graph.jpeg", plot = plot, width = 12, height = 8, dpi = 300, device = "jpeg")
ggsave("H:/Desktop/LTV_CAC_Graph.pdf", plot = plot, width = 12, height = 8, device = "pdf")

# -------------------------------
# End of Script
# -------------------------------
# Uncomment the next line if you want to quit the R session automatically.
# q()
