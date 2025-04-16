

# Extra code that I didn't want to just delete

## Code for a bar grapgh with percentages
par_w1 %>%
  count(demo001_1) %>%
  mutate(percentage = n / sum(n) * 100) %>%
  ggplot(aes(x = reorder(demo001_1, -percentage), y = percentage)) +
  geom_bar(stat = "identity", fill = "#4682B4") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            vjust = -0.5, size = 4) +
  labs(title = "Distribution of demo001_1",
       x = NULL, y = "Percentage") +
  theme_minimal()

## Code for a pie chart
dw1 %>%
  count(demo001_1)

# Step 1: Recode values with labels
dw1 <- dw1 %>%
  mutate(demo001_1_label = case_when(
    demo001_1 == 1 ~ "Female",
    demo001_1 == 2 ~ "Male",
    demo001_1 == 99 ~ "No response",
    TRUE ~ "Missing"
  ))

# Step 2: Count and calculate percentages
demo_counts <- dw1 %>%
  count(demo001_1_label) %>%
  mutate(percent = round(100 * n / sum(n), 1),
         label = paste0(demo001_1_label, " (", percent, "%)"))

# Step 3: Create pie chart with percentages
ggplot(demo_counts, aes(x = "", y = n, fill = demo001_1_label)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar(theta = "y") +
  geom_text(aes(label = paste0(percent, "%")),
            position = position_stack(vjust = 0.5),
            color = "white", size = 4.5) +
  theme_void() +
  labs(title = "Gender Distribution",
       fill = "Gender") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        legend.title = element_text(face = "bold"))