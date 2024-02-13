library("tidyverse")
library("here")
library("urbnthemes")

set_urbn_defaults(style = "print")

# full paths to the input and output dirs
output_dir <- here("data/output")
source_dir <- here("data/source")
plot_dir <- here(output_dir, "plots")

# make sure that output dir exists
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}
if (!dir.exists(plot_dir)) {
  dir.create(plot_dir)
}

poverty_rate_groups <- c("Asian", "Black", "Hispanic", "American Indian and Alaska Native", "White non-hispanic")
# load the supplemental poverty rates by race/ethnicity
supplemental_poverty_rates_22 <- read_csv(here(source_dir, "suplemental_poverty_measure_race_eth_2022.csv")) %>%
  filter(
    group %in% poverty_rate_groups
  )

poverty_rates_for_chart <- supplemental_poverty_rates_22 %>%
  rename(poverty_rate = supplemental_poverty_measure_22) %>%
  mutate(
    group = case_when(
      group == "American Indian and Alaska Native" ~ "Native American",
      group == "Hispanic" ~ "Latine",
      group == "White non-hispanic" ~ "White",
      .default = group
  )) %>%
  arrange(desc(poverty_rate))


# output poverty rate data for chart
poverty_rates_for_chart %>%
  write_csv(here("src/data", "poverty_rates.csv"))

# set factor levels for plot ordering
supplemental_poverty_rates_22$group <- factor(supplemental_poverty_rates_22$group, levels = supplemental_poverty_rates_22 %>% arrange(desc(supplemental_poverty_measure_22)) %>% pull(group))

# plot as column chart
poverty_rate_plot <- ggplot(data = supplemental_poverty_rates_22) +
  geom_col(aes(group, supplemental_poverty_measure_22)) +
  guides(fill = "none") +
  labs(title = "Suplemental Poverty Rates by Race and Ethnicity 2022", y = "supplemental poverty rate", x = "Racial or ethnic group")

poverty_rate_plot
ggsave(here(plot_dir, "poverty_rate.png"), plot = poverty_rate_plot, width = 2400, height = 1600, units = "px")


# load tax expenditures data
tax_expenditures <- read_csv(here(source_dir, "tax_expenditures.csv")) %>%
  mutate(
    group = factor(group, levels = c("White", "Hispanic", "Black", "Other"))
  )

tax_expenditures_total_data <- tax_expenditures %>%
  filter(
    type == "total",
    group != "All",
    measure != "Total Number of Families"
  )

tax_expenditures_perfamily_data <- tax_expenditures %>%
	filter(
		type == "per_family",
		group != "All",
		measure != "Total Number of Families"
	)

expenditures_to_keep <- c("Preferential rates for capital gains and dividends", "Child Tax Credit", "Earned Income Tax Credit", "Deductibility of mortgage interest")

# format tax expenditures total
tax_expenditures_total_for_chart <- tax_expenditures_total_data %>%
  select(-type) %>%
  mutate(
    value = value * 1000000000
  ) %>%
  pivot_wider(
    names_from = group,
    values_from = value
  ) %>%
  rename(
    Latine = Hispanic
  ) %>%
  mutate(
    measure = case_when(
      measure == "Preferential rates capital gains and dividends" ~ "Preferential rates for capital gains and dividends",
      measure == "Child credit (including outlay)" ~ "Child Tax Credit",
      measure == "Earned income tax credit (including outlay)" ~ "Earned Income Tax Credit",
      .default = measure
    )
  ) %>%
  filter(
    measure %in% expenditures_to_keep
  )
# format tax expenditures per family
tax_expenditures_perfamily_for_chart <- tax_expenditures_perfamily_data %>%
  select(-type) %>%
  pivot_wider(
    names_from = group,
    values_from = value
  ) %>%
  rename(
    Latine = Hispanic
  ) %>%
  mutate(
    measure = case_when(
      measure == "Preferential rates capital gains and dividends" ~ "Preferential rates for capital gains and dividends",
      measure == "Child credit (including outlay)" ~ "Child Tax Credit",
      measure == "Earned income tax credit (including outlay)" ~ "Earned Income Tax Credit",
      .default = measure
    )
  ) %>%
  filter(
    measure %in% expenditures_to_keep
  )

## output total data
tax_expenditures_total_for_chart %>%
  write_csv(here("src/data", "tax_ependitures_total.csv"))

## output per family data
tax_expenditures_perfamily_for_chart %>%
  write_csv(here("src/data", "tax_ependitures_perfamily.csv"))

tax_expenditures_total_plot <- tax_expenditures_total_data %>%
  mutate(
    measure = factor(measure, levels = group_by(., measure) %>% summarize(total = sum(value)) %>% arrange(total) %>% pull(measure))
  ) %>%
  ggplot() +
  geom_bar(aes(measure, value, fill = group), stat = "identity") +
  labs(title = "Total Tax Expenditures by Program and Race and Ethnicity", y = "Total expenditures (millions of dollars)", x = "Tax Policy Expenditure") +
  coord_flip()

tax_expenditures_total_plot

ggsave(here(plot_dir, "tax_expenditures_total.png"), plot = tax_expenditures_total_plot, width = 2400, height = 1600, units = "px")

tax_expenditures_perfam_plot <- tax_expenditures %>%
  filter(
    type == "per_family" & group != "All"
  ) %>%
  arrange(desc(value)) %>%
  mutate(
    measure = factor(measure, levels = group_by(., measure) %>% summarize(total = sum(value)) %>% arrange(total) %>% pull(measure))
  ) %>%
  ggplot() +
  geom_bar(aes(measure, value, fill = group), stat = "identity") +
  labs(title = "Tax Expenditures per family by Race and Ethnicity", y = "Expenditures per family", x = "Expenditure program") +
  coord_flip()

tax_expenditures_perfam_plot

ggsave(here(plot_dir, "tax_expenditures_perfam.png"), plot = tax_expenditures_perfam_plot, width = 2400, height = 1600, units = "px")

tax_expenditures_share_plot <- tax_expenditures %>%
  filter(
    type == "share" & group != "All"
  ) %>%
  arrange(value) %>%
  mutate(
    measure = factor(measure, levels = group_by(., measure) %>% summarize(total = sum(value)) %>% arrange(desc(total)) %>% pull(measure))
  ) %>%
  ggplot() +
  geom_bar(aes(measure, value, fill = group), stat = "identity") +
  labs(title = "Share of Tax Expenditures by Race and Ethnicity", y = "Share of expenditures", x = "Racial or ethnic group") +
  coord_flip()

tax_expenditures_share_plot

ggsave(here(plot_dir, "tax_expenditures_share.png"), plot = tax_expenditures_share_plot, width = 2400, height = 1600, units = "px")


#################################
# Ok now let's look at the EITC and CTC data
#################################


eitc_ctc_data <- read_csv(here(source_dir, "eitc_ctc.csv")) %>%
  select(earnings = Earnings, EITC, CTC) %>%
  mutate(
    earnings = parse_number(earnings),
    EITC = parse_number(EITC),
    CTC = parse_number(CTC),
  )
pivot_longer(EITC:SUM,
  values_to = "amount",
  names_to = "program"
)

options(scipen = 999)
eitc_ctc_data %>%
  ggplot(aes(earnings, amount, color = program)) +
  geom_step(size = 1) +
  labs(title = "Earned Income Tax Credit and Child Tax Credit", y = "Credit amount ($)", x = "Income ($)")

eitc_ctc_data %>%
  ggplot(aes(earnings, amount, fill = program)) +
  geom_area() +
  labs(title = "Earned Income Tax Credit and Child Tax Credit", y = "Credit amount ($)", x = "Income ($)")

eitc_ctc_data %>%
	write_csv(here("src/data/eitc_ctc.csv"))
