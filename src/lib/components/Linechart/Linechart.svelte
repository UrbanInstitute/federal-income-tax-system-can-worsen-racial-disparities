<script>
  import { LayerCake, Svg, Html, groupLonger, flatten } from "layercake";
  import { fade } from "svelte/transition";
  import { scaleOrdinal } from "d3-scale";
  import { format } from "d3-format";
  import RangeHighlight from "./RangeHighlight.svelte";
  import Mask from "$components/Mask/Mask.svg.svelte";
  import FPL from "$components/FPL.svelte";
  import LineLabels from "./LineLabels.svelte";
  import Line from "$components/Linechart/Line.svelte";
  import AxisX from "$components/Axes/AxisX.svelte";
  import AxisY from "$components/Axes/AxisY.svelte";
  import { tweened } from "svelte/motion";
  import * as eases from "svelte/easing";

  /** @type {Array<Record<any, any>>} [croppedData] - The data, cropped to the xLimit. */
  export let data = [];

  export let xKey = "earnings";
  export let yKey = "amount";
  export let zKey = "program";
  export let showFPL = false;
  /** @type import("./LineLabels.svelte").LabelItem[] */

  /** @type {string[]} */
  export let lines = [];
  export let labels = [];
  /** @type {String} */
  export let label;

  /** @type {Number | null} [xLimit] - The maximum value for the x axis. */
  export let xLimit = null;
  /** @type {Number[] | null} [highlightRange] - The maximum value for the x axis. */
  export let highlightRange = null;

  const seriesNames = ["CTC", "EITC"];
  $: seriesColors = ["#008bb0", "#174a7c"];

  data.forEach((d) => {
    for (const n of seriesNames) {
      d[n] = +d[n];
    }
    d[xKey] = +d[xKey];
  });

  /** @type {Array<Record<any, any>>} [croppedData] - The data, cropped to the xLimit. */
  let croppedData;

  $: {
    if (!xLimit) {
      croppedData = data;
    } else {
      croppedData = data;
    }
  }

  $: groupedData = groupLonger(croppedData, seriesNames, {
    groupTo: zKey,
    valueTo: yKey,
  }).filter((d) => lines.includes(d[zKey]));

  const xMax = tweened(xLimit, {
    duration: 500,
    easing: eases.cubicOut,
  });

  $: xMax.set(xLimit);

  let chartWidth = 600;
</script>

<div class="chart-wrapper" transition:fade>
  <div class="chart-header">
    <h4 class="chart-title">Credit Amount by Income</h4>
    <p class="chart-description">For a married couple with two children, 2023</p>
  </div>
  <div class="chart-container" bind:clientWidth={chartWidth}>
    <LayerCake
      padding={{ top: 30, right: 45, bottom: 20, left: 50 }}
      x={xKey}
      y={yKey}
      z={zKey}
      zDomain={seriesNames}
      zScale={scaleOrdinal()}
      zRange={seriesColors}
      yNice={4}
      yDomain={[0, 10000]}
      xDomain={[0, $xMax]}
      flatData={flatten(groupedData, "values")}
      data={groupedData}
    >
      <Svg {label}>
        <defs>
          <Mask id="line-mask" />
        </defs>
        <AxisX
          axisLabel="Income"
          gridlines={false}
          ticks={chartWidth < 600 ? 4 : 6}
          formatTick={format("$,.0f")}
        />
        <AxisY
          axisLabel="Credit amount"
          ticks={chartWidth < 600 ? 4 : 6}
          formatTick={format("$,.0f")}
        />
        {#if highlightRange}
          <RangeHighlight xStart={highlightRange[0]} xEnd={highlightRange[1]} />
        {/if}
        <Line />
        <!-- <Area/> -->
        {#if showFPL}
          <FPL />
        {/if}
      </Svg>
      <Html label="Chart annotations">
        <LineLabels {labels} />
      </Html>
    </LayerCake>
  </div>
  <div class="chart-footer">
    <p class="chart-source">
      <strong>Source:</strong> Tax Policy Center calculations.
    </p>
    <p class="chart-source">
      <strong>Notes:</strong> CTC = Child tax credit; EITC = Earned income tax credit. Figure assumes
      all income is from earnings and that the couple files jointly. Calculations are shown for a family
      with two children under age 17. Federal poverty level is shown for a four-person family in 2023.
    </p>
  </div>
</div>

<style>
  /*
    The wrapper div needs to have an explicit width and height in CSS.
    It can also be a flexbox child or CSS grid element.
    The point being it needs dimensions since the <LayerCake> element will
    expand to fill it.
  */
  .chart-container {
    width: 100%;
    height: 450px;
  }
  .chart-wrapper {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
  }
  .chart-footer {
    max-width: 100%;
  }
</style>
