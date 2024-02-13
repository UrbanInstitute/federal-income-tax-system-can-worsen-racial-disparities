<script>
  import { LayerCake, Svg } from "layercake";
  import { tpcColors } from "@urbaninstitute/dataviz-components/utils";
  // import BarLabels from "./BarLabels.svelte";
  import ChartKey from "$components/ChartKey/ChartKey.svelte";

  import { scaleBand, scaleOrdinal } from "d3-scale";
  import { max } from "d3-array";
  import { format } from "d3-format";

  import Columns from "./Columns.svelte";
  import AxisX from "$components/Axes/AxisX.svelte";
  import AxisY from "$components/Axes/AxisY.svelte";

  /**@type {Array<Record<any, any>>} [data] - The data to visualize in a flat array. */
  export let data = [];

  /**@type {string | null} */
  export let title = null;

  /**@type {string | null} */
  export let description = null;

  /**@type {string | null} */
  export let notes = null;

  /**@type {string | null} */
  export let source = null;

  /**@type {string} */
  export let yKey;

  /**@type {string} */
  export let xKey;

  /**@type {string} */
  export let tickFormat = ".0f";

  /**@type {string} */
  export let label;

  const formatTickY = d => `${format(tickFormat)(d)}%`;

  $: data.forEach((d) => {
    d[yKey] = +d[yKey];
  });
</script>

<div class="chart-wrapper">
  {#if title}
    <h4 class="chart-title">{title}</h4>
  {/if}
  {#if description}
    <p class="chart-description">{description}</p>
  {/if}
  <!-- <ChartKey data={keyData} /> -->
  <div class="chart-container">
    <LayerCake
      padding={{ top: 20, bottom: 20, left: 12, right: 0 }}
      x={xKey}
      y={yKey}
      xDomain={data.map(d => d[xKey])}
      xScale={scaleBand().padding(0.25).round(true)}
      yDomain={[0, 28]}
      {data}
    >
      <Svg {label}>
        <AxisX gridlines={false} baseline={false} />
        <AxisY tickLabels={true} gridlineColor="#bcbec0" formatTick={formatTickY}/>
        <Columns fill={tpcColors.blue_dark}/>
      </Svg>
    </LayerCake>
  </div>
  {#if notes || source}
    <div class="chart-footer">
      {#if source}
        <p><strong>Source:</strong> {source}</p>
      {/if}
      {#if notes}
        <p><strong>Notes:</strong> {notes}</p>
      {/if}
    </div>
  {/if}
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
    width: 90%;
    max-width: 800px;
    margin: 0 auto;
  }

  @media screen and (max-height: 780px) {
    .chart-container {
      height: 350px;
    }
  }
  @media screen and (max-height: 728px) {
    .chart-container {
      height: 250px;
    }
  }
  @media screen and (max-height: 540px) {
    .chart-container {
      height: 200px;
    }
  }
  @media screen and (max-width: 540px) {
    .chart-container {
      height: 200px;
    }
  }
</style>
