# Explicitly Load Packages
library(ggplot2)
library(tidyr)
library(scales)

# Create a Data Frame Manually (Pilot Phase: Aug-23 to Mar-24)
data <- data.frame(
  Month = factor(c("Aug-23", "Sep-23", "Oct-23", "Nov-23", "Dec-23", "Jan-24", "Feb-24", "Mar-24"),
                 levels = c("Aug-23", "Sep-23", "Oct-23", "Nov-23", "Dec-23", "Jan-24", "Feb-24", "Mar-24")),
  LTV = c(11, 21, 27, 36, 36, 37, 36, 37),
  CAC = c(37, 9, 13, 12, 11, 10, 12, 12)
)

# Verify Data Creation
print("Preview of the data frame:")
print(head(data))
print("Summary of the data:")
print(summary(data))

# Calculate LTV/CAC Ratio
data$Ratio <- data$LTV / data$CAC

# Reshape for Plotting
data_long <- gather(data, key = "Metric", value = "Value", -Month, -Ratio)
print("Reshaped data (long format):")
print(head(data_long))

# Linear Regression on Scaled Ratio
lm_model <- lm((Ratio * 10) ~ as.numeric(Month), data = data)
print("Linear Regression Model Summary:")
print(summary(lm_model))
r_squared <- round(summary(lm_model)$r.squared, 2)
annotation_text <- paste("Trendline R² =", r_squared)

# Create the Plot
plot <- ggplot() +
  geom_bar(data = data_long, aes(x = Month, y = Value, fill = Metric),
           stat = "identity", position = position_dodge(), size = 0.5) +
  geom_line(data = data, aes(x = Month, y = Ratio * 10, group = 1,
                             linetype = "LTV/CAC Ratio"),
            size = 2, color = "black") +
  geom_smooth(data = data, aes(x = Month, y = Ratio * 10, group = 1,
                               linetype = "Trendline for LTV/CAC Ratio"),
              method = "lm", se = FALSE, size = 2, color = "black") +
  scale_y_continuous(
    name = "US Dollars",
    sec.axis = sec_axis(~./10, name = "LTV/CAC Ratio")
  ) +
  labs(
    title = "LTV and CAC Over Time (Pilot Phase: Aug 2023 - Mar 2024)",
    x = "Months Since Launch",
    fill = "Metric",
    linetype = "Metric"
  ) +
  scale_fill_manual(values = c("LTV" = "steelblue", "CAC" = "salmon")) +
  scale_linetype_manual(values = c("LTV/CAC Ratio" = "solid", "Trendline for LTV/CAC Ratio" = "dotted")) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title.y.left = element_text(color = "black", size = 12),
    axis.title.y.right = element_text(color = "black", size = 12),
    axis.text = element_text(size = 10),
    legend.position = "right",
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  ) +
  annotate("text", x = "Mar-24", y = max(data$LTV) + 3, label = annotation_text,
           hjust = 1, size = 4, color = "black")

# Display the Plot
print(plot)

# Save the Plot
ggsave("H:/Desktop/LTV_CAC_Graph_Pilot.jpeg", plot = plot, width = 12, height = 8, dpi = 300, device = "jpeg")
ggsave("H:/Desktop/LTV_CAC_Graph_Pilot.pdf", plot = plot, width = 12, height = 8, device = "pdf")
