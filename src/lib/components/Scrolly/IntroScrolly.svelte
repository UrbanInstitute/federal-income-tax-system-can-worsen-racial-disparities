<script>
  import { getContext } from "svelte";
  import { fade } from "svelte/transition";
  import { transitionIn, transitionOut } from "./transitions.js";

  import FullImage from "./FullImage.svelte";
  import Timeline from "$components/Timeline/Timeline.svelte";
  import StackedBarChart from "$components/StackedBar/StackedBarChart.svelte";
  import ColumnChart from "$components/ColumnChart/ColumnChart.svelte";

  import tax_expenditures_data from "$data/tax_ependitures_total.csv";

  import poverty_rates_data from "$data/poverty_rates.csv";

  const { index } = getContext("scrolly");

  const introImageAlt = "Photo of a father reading a book to his toddler at home.";

  const expendituresChartInfo = {
    title: "Tax Breaks for Capital Gains and Homeownership Disproportionately Benefit White Families",
    subtitle: "Value of tax expenditures by race and ethnicity, fiscal year 2023",
    source:
      "Cronin, Julie-Anne, Portia DeFilippes, and Robin Fisher. 2023. “Tax Expenditures by Race and Hispanic Ethnicity: An Application of the U.S. Treasury Department’s Race and Hispanic Ethnicity Imputation.” Working Paper 122. Washington, DC: US Department of the Treasury.",
    notes:
      "Estimates for tax credits include outlays, or the refundable credit amounts a taxpayer receives that is in excess of their individual income tax liability.",
    label: "A stacked bar chart that shows the cost of four tax breaks and the share of families, by race, that benefit from a given tax break. The federal government is spending tens of billions of dollars on tax breaks, such as preferential rates for capital gains and the deductibility of mortgage interest, that disproportionately benefit White families."
  };
  const povertyChartInfo = {
    title: "Structural Barriers Contribute to High Rates of Poverty among Families of Color",
    description: "Poverty rates by race and ethnicity, 2022",
    source:
      "Shrider, Emily A., and John Creamer. 2023. Poverty in the United States: 2022. Current Population Reports, P60-280. Washington, DC: U.S. Census Bureau.",
    notes:
      "Poverty rates estimated using the Supplemental Poverty Measure, which extends the official poverty measure by including several government programs that are designed to assist low-income families. It also accounts for geographic variation in housing expenses when calculating the poverty thresholds and includes federal and state taxes, work expenses, and medical expenses.",
    label: "Column chart of poverty rates by race that shows Native American, Latine, and Black families are significantly more likely to live in poverty compared with White families."
  };
</script>

{#if $index === 0}
  <div in:fade={transitionIn} out:fade={transitionOut} class="slide-wrap">
    <FullImage
      src="img/scrolly-intro-hero-img"
      alt={introImageAlt}
      overlay="#000000"
      overlayOpacity={0.45}
    />
  </div>
{:else if $index === 1}
  <div in:fade={transitionIn} out:fade={transitionOut} class="slide-wrap">
    <FullImage
      src="img/scrolly-intro-hero-img"
      alt={introImageAlt}
      overlay="#000000"
      overlayOpacity={0.45}
    />
  </div>
{:else if $index === 2 || $index === 3}
  <div in:fade={transitionIn} out:fade={transitionOut} class="slide-wrap">
    <Timeline />
    <FullImage src="img/scrolly-intro-hero-img" alt={introImageAlt} overlay="#F0573E" />
  </div>
{:else if $index === 4 || $index === 5 || $index === 6}
  <div in:fade={transitionIn} out:fade={transitionOut} class="slide-wrap">
    <FullImage src="img/scrolly-intro-hero-img" alt={introImageAlt} overlay="#BCBEC0" />
    <div class="chart-container">
      <ColumnChart
        data={poverty_rates_data}
        yKey="poverty_rate"
        xKey="group"
        {...povertyChartInfo}
      />
    </div>
  </div>
{:else if $index === 7 || $index === 8}
  <div in:fade={transitionIn} out:fade={transitionOut} class="slide-wrap">
    <FullImage src="img/scrolly-intro-hero-img" alt={introImageAlt} overlay="#000000" overlayOpacity={0.45} />
  </div>
{:else if $index >= 9 && $index <= 12}
  <div in:fade={transitionIn} out:fade={transitionOut} class="slide-wrap">
    <FullImage src="img/scrolly-intro-hero-img" alt={introImageAlt} overlay="#B0D0DB" />
    <div class="chart-container">
      <StackedBarChart data={tax_expenditures_data} yKey="measure" {...expendituresChartInfo} />
    </div>
  </div>
{:else}
  <div in:fade={transitionIn} out:fade={transitionOut} class="slide-wrap">
    <FullImage
      src="img/scrolly-intro-hero-img"
      alt={introImageAlt}
      overlay="#000000"
      overlayOpacity={0.45}
    />
  </div>
{/if}

<style>
  .slide-wrap {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
  }
  .chart-container {
    width: 100%;
    max-width: 800px;
    /* margin: 4rem auto; */
    margin-top: 2rem;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }
</style>
