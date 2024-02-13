<script>
  import Linechart from "$components/Linechart/Linechart.svelte";
  import StackedAreaChart from "$components/AreaStacked/StackedAreaChart.svelte";
  import eitc_ctc_data from "$data/eitc_ctc.csv";
  import { getContext } from "svelte";

  const { index, slideHeight } = getContext("scrolly");

  const mobileBreakpoint = 600;
  let winWidth = 0;
  $: isMobile = winWidth <= mobileBreakpoint;

  $: steps = [
    {
      component: Linechart,
      props: {
        label: "A line chart that shows the earned income tax credit phases in and out as income rises.",
        showFPL: false,
        data: eitc_ctc_data,
        xLimit: 80000,
        lines: ['EITC'],
        labels: [
          { x: 36000, y: 5700, text: "EITC", color: "#174a7c", bold: true },
        ],
      },
    },
    {
      component: Linechart,
      props: {
        label: "A line chart with shading that highlights how the family must make between $16,510 and $28,120 to receive the maximum earned income tax credit amount.",
        showFPL: false,
        data: eitc_ctc_data,
        xLimit: 80000,
        lines: ['EITC'],
        highlightRange: [16510, 28120],
        labels: [
          { x: 36000, y: 5700, text: "EITC", color: "#174a7c", bold: true },
        ],
      },
    },
    {
      component: Linechart,
      props: {
        label: "A line chart with shading that highlights how the family must make between $16,510 and $28,120 to receive the maximum earned income tax credit amount.",
        showFPL: false,
        data: eitc_ctc_data,
        xLimit: 80000,
        lines: ['EITC'],
        highlightRange: [16510, 28120],
        labels: [
          { x: 36000, y: 5700, text: "EITC", color: "#174a7c", bold: true },
        ],
      },
    },
    {
      component: Linechart,
      props: {
        label: "A line chart that shows the child tax credit phases in and out based on income. A shaded area shows that the family must make between $35,700 and $400,000 to claim the maximum child tax credit.",
        showFPL: false,
        data: eitc_ctc_data,
        xLimit: 480000,
        lines: ['CTC'],
        highlightRange: [35700, 400000],
        labels: [
          { x: 50000, y: 4500, text: "CTC", color: "#008bb0", bold: true },
        ],
      },
    },
    {
      component: Linechart,
      props: {
        label: "A line chart that shows the child tax credit phases in and out based on income. A shaded area shows that the family must make between $35,700 and $400,000 to claim the maximum child tax credit.",
        showFPL: false,
        data: eitc_ctc_data,
        xLimit: 480000,
        lines: ['CTC'],
        highlightRange: [35700, 400000],
        labels: [
          { x: 50000, y: 4500, text: "CTC", color: "#008bb0", bold: true },
        ],
      },
    },
    {
      component: StackedAreaChart,
      props: {
        label: "An area chart showing the combined value of the earned income tax credit and the child tax credit. If the family makes just under $30,000, the family could receive up to $9,846 in tax credits.",
        showFPL: true,
        data: eitc_ctc_data.map(({ EITC, CTC, earnings }) => ({ EITC, CTC, earnings })),
        xLimit: 480000,
        labels: [
          { x: 55000, y: 5700, text: "EITC", color: "#174a7c", bold: true },
          { x: 50000, y: 2500, text: "CTC", color: "#FFFFFF", bold: true },
        ],
        arrows: []
      },
    },
    {
      component: StackedAreaChart,
      props: {
        label: "An area chart showing the combined value of the earned income tax credit and the child tax credit. If the family makes just under $30,000, the family could receive up to $9,846 in tax credits.",
        showFPL: true,
        data: eitc_ctc_data.map(({ EITC, CTC, earnings }) => ({ EITC, CTC, earnings })),
        xLimit: 480000,
        labels: [
          { x: 55000, y: 5700, text: "EITC", color: "#174a7c", bold: true },
          { x: 50000, y: 2500, text: "CTC", color: "#FFFFFF", bold: true },
        ],
        arrows: []
      },
    },
    {
      component: StackedAreaChart,
      props: {
        label: "An area chart showing the combined value of the earned income tax credit and the child tax credit. If the family makes just under $30,000, the family could receive up to $9,846 in tax credits.",
        showFPL: true,
        data: eitc_ctc_data.map(({ EITC, CTC, earnings }) => ({ EITC, CTC, earnings })),
        xLimit: 70000,
        labels: [
          { x: 55000, y: 5700, text: "EITC", color: "#174a7c", bold: true },
          { x: 50000, y: 3300, text: "CTC", color: "#FFFFFF", bold: true },
          // { x: 10000, y: 2500, text: "The couple does not qualify for any credits if its income is $0.", color: "#FFFFFF", bold: true, fontSize: isMobile ? 14 : 18 },
        ],
        arrows: [
          // {
          //   target: { x: 0, y: 0 },
          //   labelIndex: 2,
          //   source: { x: 9500, y: 2300 },
          //   clockwise: false,
          // },
        ],
      },
    },
    {
      component: StackedAreaChart,
      props: {
        label: "An area chart that highlights how the family must have earned at least $1 in income in 2023 to qualify for EITC benefits. ",
        showFPL: false,
        data: eitc_ctc_data.map(({ EITC, CTC, earnings }) => ({ EITC, CTC, earnings })),
        xLimit: 70000,
        highlightRange: [1, 16510],
        labels: [
          { x: 55000, y: 5700, text: "EITC", color: "#174a7c", bold: true },
          { x: 50000, y: 3300, text: "CTC", color: "#FFFFFF", bold: true },
          // { x: 10000, y: 2500, text: "The couple does not qualify for any credits if its income is $0.", color: "#FFFFFF", bold: true, fontSize: isMobile ? 14 : 18 },
        ],
        arrows: [
          // {
          //   target: { x: 0, y: 0 },
          //   labelIndex: 2,
          //   source: { x: 9500, y: 2300 },
          //   clockwise: false,
          // },
        ],
      },
    },
    {
      component: StackedAreaChart,
      props: {
        label: "An area chart that highlights how the family must have made at least $2,500 to claim any child tax credit benefits",
        showFPL: false,
        data: eitc_ctc_data.map(({ EITC, CTC, earnings }) => ({ EITC, CTC, earnings })),
        xLimit: 70000,
        highlightRange: [2500, 35700],
        labels: [
          { x: 55000, y: 5700, text: "EITC", color: "#174a7c", bold: true },
          { x: 50000, y: 3300, text: "CTC", color: "#FFFFFF", bold: true },
        ],
        arrows: []
      },
    },
    {
      component: StackedAreaChart,
      props: {
        label: "An area chart demonstrating how both credits are designed in such a way that the family cannot receive full benefits if it has a very low income or no income, including if it makes below the federal poverty line.",
        showFPL: true,
        data: eitc_ctc_data.map(({ EITC, CTC, earnings }) => ({ EITC, CTC, earnings })),
        xLimit: 480000,
        labels: [
          { x: 55000, y: 5700, text: "EITC", color: "#174a7c", bold: true },
          { x: 50000, y: 3300, text: "CTC", color: "#FFFFFF", bold: true },
        ],
        arrows: []
      },
    },
    {
      component: StackedAreaChart,
      props: {
        label: "An area chart demonstrating how both credits are designed in such a way that the family cannot receive full benefits if it has a very low income or no income, including if it makes below the federal poverty line.",
        showFPL: true,
        data: eitc_ctc_data.map(({ EITC, CTC, earnings }) => ({ EITC, CTC, earnings })),
        xLimit: 480000,
        labels: [
          { x: 55000, y: 5700, text: "EITC", color: "#174a7c", bold: true },
          { x: 50000, y: 3300, text: "CTC", color: "#FFFFFF", bold: true },
        ],
        arrows: []
      },
    },
  ];

  $: currentStep = steps[$index];
</script>

<svelte:window bind:innerWidth={winWidth} />
{#if currentStep}
  <div class="chart-slide-wrapper" style:height="{$slideHeight}px">
    <div class="chart"> <svelte:component this={currentStep.component} {...currentStep.props} />
    </div>
  </div>
{/if}

<style>
  .chart-slide-wrapper {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    position: relative;
    margin: 0 var(--spacing-4);
  }
  .chart {
    width: 100%;
    max-width: 760px;
    position: relative;
  }
  @media screen and (min-width: 792px) {
    .chart-slide-wrapper {
      margin: 0 auto;
    }
  }
</style>
