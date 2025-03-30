# Load Packages
library(dplyr)
library(lubridate)
library(ggplot2)

# Ensure the graphs directory exists
graphs_dir <- "H:/Desktop/Kleindatapipeline/graphs"
if (!dir.exists(graphs_dir)) {
  dir.create(graphs_dir)
}

# Read the CSV
subscriptions <- read.csv("H:/Desktop/Kleindatapipeline/data/processed/subscriptions.csv")

# Convert Unix timestamps (ms) to dates
subscriptions <- subscriptions %>%
  mutate(
    purchase_date = as_datetime(purchase_date / 1000),
    expiration_date = as_datetime(expiration_date / 1000),
    original_purchase_date = as_datetime(original_purchase_date / 1000)
  )

# Define cohorts by original purchase month (Aug, Sep, Oct 2023)
subscriptions <- subscriptions %>%
  mutate(cohort = floor_date(original_purchase_date, "month")) %>%
  filter(cohort %in% as_datetime(c("2023-08-01", "2023-09-01", "2023-10-01")))

# Create a sequence of months from Aug 2023 to Mar 2024 (0 to 8 months)
month_seq <- seq(as_datetime("2023-08-01"), as_datetime("2024-03-01"), by = "month")

# For each user, check if they were active in each month
active_by_month <- subscriptions %>%
  group_by(user_id, cohort) %>%
  summarise(
    first_join = min(original_purchase_date),
    .groups = "drop"
  ) %>%
  crossing(month = month_seq) %>%
  left_join(
    subscriptions %>% select(user_id, purchase_date, expiration_date),
    by = "user_id",
    relationship = "many-to-many"  # Silence the many-to-many warning
  ) %>%
  filter(
    month >= floor_date(first_join, "month"),
    month <= as_datetime("2024-03-01")  # Limit to 8 months (Aug 2023 to Mar 2024)
  ) %>%
  mutate(
    is_active = (month >= floor_date(purchase_date, "month") & month <= floor_date(expiration_date, "month")),
    months_active = round(interval(first_join, month) / months(1))
  ) %>%
  filter(months_active >= 0, months_active <= 8)  # Limit to 8 months

# Summarize retention by cohort and months active
cohort_summary <- active_by_month %>%
  group_by(cohort, months_active) %>%
  summarise(
    active_users = n_distinct(user_id[is_active == TRUE]),
    .groups = "drop"
  ) %>%
  group_by(cohort) %>%
  mutate(
    total_users = max(active_users[months_active == 0], na.rm = TRUE),
    retention_rate = active_users / total_users
  ) %>%
  ungroup()

# Ensure all months 0 to 8 are present for each cohort
cohort_summary <- cohort_summary %>%
  complete(cohort, months_active = 0:8, fill = list(active_users = 0, total_users = NA, retention_rate = 0)) %>%
  group_by(cohort) %>%
  fill(total_users, .direction = "downup") %>%
  ungroup() %>%
  mutate(
    retention_rate = active_users / total_users,
    cohort_label = format(cohort, "%b %Y"),  # Define cohort_label earlier
    cohort_label = factor(cohort_label, levels = c("Aug 2023", "Sep 2023", "Oct 2023"))
  )

# Prepare the data for geom_text with precomputed vjust and nudge_y
label_data <- cohort_summary %>%
  filter(
    (cohort_label == "Aug 2023" & months_active == 2) |
      (cohort_label == "Oct 2023" & months_active == 4) |
      (cohort_label == "Sep 2023" & months_active == 5)
  ) %>%
  mutate(
    vjust = case_when(
      cohort_label == "Oct 2023" ~ -1,  # Move Oct 2023 label above
      TRUE ~ 0.5  # Center the others vertically
    ),
    nudge_y = case_when(
      cohort_label == "Oct 2023" ~ 0.0245,  # Reduced nudge_y for Oct 2023 (from 0.035 to 0.0245)
      TRUE ~ 0
    )
  )

# Plot retention by cohort with direct labels at specified months
plot <- ggplot(cohort_summary, aes(x = months_active, y = retention_rate, color = cohort_label, group = cohort_label)) +
  geom_line(size = 1) +
  # Add labels at specified months
  geom_text(
    data = label_data,
    aes(label = cohort_label, x = months_active, y = retention_rate, color = cohort_label),
    hjust = -0.1,
    size = 4,
    vjust = label_data$vjust,  # Use precomputed vjust
    nudge_x = 0.2,
    nudge_y = label_data$nudge_y,  # Use precomputed nudge_y
    show.legend = FALSE
  ) +
  labs(
    title = "Customer Retention by Join Month Cohort",
    x = "Months Since First Payment",
    y = "Retention Rate"
  ) +
  scale_x_continuous(breaks = 0:8, limits = c(0, 8.5)) +
  scale_y_continuous(labels = scales::percent, limits = c(0, 1)) +
  scale_color_manual(values = c("Aug 2023" = "blue", "Sep 2023" = "green", "Oct 2023" = "red")) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold")
  )

# Display plot
print(plot)

# Save plot to the graphs directory
ggsave("H:/Desktop/Kleindatapipeline/graphs/cohort_retention_by_join_month.jpeg", 
       width = 10, height = 6, dpi = 300)
