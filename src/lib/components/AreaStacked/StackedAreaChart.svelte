<script>
  import { LayerCake, Svg, Html, flatten, stack } from "layercake";
  import RangeHighlight from "$components/Linechart/RangeHighlight.svelte";
  import { fade } from "svelte/transition";

  import { scaleOrdinal } from "d3-scale";
  import { format } from "d3-format";
  import { max } from "d3-array";

  import AxisX from "$components/Axes/AxisX.svelte";
  import AxisY from "$components/Axes/AxisY.svelte";
  import Arrows from "$components/Arrows/Arrows.svelte";
  import ArrowheadMarker from "$components/Arrows/ArrowheadMarker.svelte";
  import FPL from "$components/FPL.svelte";
  import Mask from "$components/Mask/Mask.svg.svelte";
  import AreaStacked from "$components/AreaStacked/AreaStacked.svelte";
  import LineLabels from "$components/Linechart/LineLabels.svelte";
  import Line from "./Line.svelte";
  import { cropData } from "$lib/utils";
  import { tweened } from "svelte/motion";
  import * as eases from "svelte/easing";

  export let data = [];

  /** @type {Number | null} [xLimit] - The maximum value for the x axis. */
  export let xLimit = null;

  export let xKey = "earnings";

  export let showFPL = false;

  const yKey = [0, 1];
  export let zKey = "key";

  /** @type import("../Linechart/LineLabels.svelte").LabelItem[] */
  export let labels = [];

  /** @type {String} */
  export let label;

  export let arrows = [];

  /** @type {Number[] | null} [highlightRange] - The maximum value for the x axis. */
  export let highlightRange = null;

  const seriesNames = Object.keys(data[0])
    .filter((d) => d !== xKey)
    .reverse();
  const seriesColors = ["#008bb0", "#174a7c"];

  const formatTickX = format("$,.0f");
  const formatTickY = format("$,.0f");

  let chartWidth = 600;

  /* --------------------------------------------
   * Cast data
   */
  data.forEach((d) => {
    d[xKey] = +d[xKey];

    seriesNames.forEach((name) => {
      d[name] = +d[name];
    });
  });
  $: stackedData = stack(data, seriesNames);
  $: maxVal = xLimit ? xLimit : max(data, (d) => d[xKey]);

  const xMax = tweened(maxVal, {
    duration: 500,
    easing: eases.cubicOut,
  });

  $: xMax.set(maxVal);
</script>

<div class="chart-wrapper" transition:fade>
  <div class="chart-header">
    <h4 class="chart-title">Credit Amount by Income</h4>
    <p class="chart-description">For a married couple with two children, 2023</p>
  </div>
  <div class="chart-container" bind:clientWidth={chartWidth}>
    <LayerCake
      padding={{ top: 30, right: 45, bottom: 20, left: 50 }}
      x={(d) => d.data[xKey]}
      y={yKey}
      z={zKey}
      zScale={scaleOrdinal()}
      zDomain={seriesNames}
      zRange={seriesColors}
      xDomain={[0, $xMax]}
      yDomain={[0, 10000]}
      flatData={flatten(stackedData)}
      data={stackedData}
    >
      <Svg {label}>
        <defs>
          <Mask />
        </defs>
        <AxisX axisLabel="Income" ticks={chartWidth < 600 ? 4 : 6} formatTick={formatTickX} gridlines={false} />
        <AxisY axisLabel="Credit amount" formatTick={formatTickY} />
        <AreaStacked />
        <Line />
        {#if highlightRange}
          <RangeHighlight xStart={highlightRange[0]} xEnd={highlightRange[1]} />
        {/if}
        {#if showFPL}
          <FPL />
        {/if}
      </Svg>
      <Html>
        <LineLabels {labels} />
      </Html>
      <Svg>
        <svelte:fragment slot="defs">
          <ArrowheadMarker />
        </svelte:fragment>
        <Arrows {arrows} />
      </Svg>
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
  .chart-container :global(svg) {
    overflow: hidden;
  }
  .chart-wrapper {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
  }
</style>
