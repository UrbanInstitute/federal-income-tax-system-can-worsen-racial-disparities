library("tidyverse")
library("here")

#############################################
# Setup and folder paths
#############################################

# full paths to the input and output dirs
output_dir <- here("data/output")
source_dir <- here("data/source")
front_end_dir <- here("src/data")

# make sure that output dir exists
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}
if (!dir.exists(plot_dir)) {
  dir.create(plot_dir)
}
if (!dir.exists(front_end_dir)) {
  dir.create(front_end_dir)
}

#############################################
# Poverty rates data
#############################################

# load the supplemental poverty rates by race/ethnicity
supplemental_poverty_rates_22 <- read_csv(here(source_dir, "suplemental_poverty_measure_race_eth_2022.csv")) %>%
  filter(
    group %in% poverty_rate_groups
  )

# groups to use from the poverty rates data
poverty_rate_groups <- c("Asian", "Black", "Hispanic", "American Indian and Alaska Native", "White non-hispanic")


# format poverty rates data for charting
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
  write_csv(here(front_end_dir, "poverty_rates.csv"))


#############################################
# Tax expenditures data
#############################################

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


#############################################
# EITC and CTC data
#############################################


# Load and format source data
eitc_ctc_data <- read_csv(here(source_dir, "eitc_ctc.csv")) %>%
  select(earnings = Earnings, EITC, CTC) %>%
  mutate(
    earnings = parse_number(earnings),
    EITC = parse_number(EITC),
    CTC = parse_number(CTC),
  )

eitc_ctc_data %>%
	write_csv(here("src/data/eitc_ctc.csv"))
