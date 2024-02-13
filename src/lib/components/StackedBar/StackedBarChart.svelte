<script>
  import { LayerCake, Svg, flatten, stack } from "layercake";
  import BarLabels from "./BarLabels.svelte";
  import ChartKey from "$components/ChartKey/ChartKey.svelte";

  import { scaleBand, scaleOrdinal } from "d3-scale";
  import { format } from "d3-format";

  import BarStacked from "$components/StackedBar/StackedBars.svelte";
  import AxisX from "$components/Axes/AxisX.svelte";
  import AxisY from "$components/Axes/AxisY.svelte";

  /**@type {Array<Record<any, any>>} [data] - The data to visualize in a flat array. */
  export let data = [];

  /**@type {string | null} */
  export let title = null;

  /**@type {string | null} */
  export let subtitle = null;

  /**@type {string | null} */
  export let notes = null;

  /**@type {string | null} */
  export let source = null;

  /**@type {string} */
  export let yKey;

  /**@type {string} */
  export let tickFormat = "$,.2~s";

  /**@type {string} */
  export let label;

  /**@type {string[]} */
  export let seriesColors = ["#174a7c", "#f0573e", "#fcb64b", "#3f4f56"];

  const zKey = "key";
  const xKey = [0, 1];

  $: seriesNames = Object.keys(data[0]).filter((d) => d !== yKey);

  $: keyData = seriesNames.map((d, i) => ({ label: d, color: seriesColors[i] }));

  /* --------------------------------------------
   * Cast data
   */
  $: {
    data.forEach((d) => {
      seriesNames.forEach((name) => {
        d[name] = +d[name];
      });
    });
  }

  const formatTickX = d => format(tickFormat)(d).replace("G", "B");

  function getDataSum(dataItem) {
    const itemKeys = Object.keys(dataItem).filter((k) => k !== yKey);
    let result = 0;
    for (const k of itemKeys) {
      result += dataItem[k];
    }
    return result;
  }

  function sortData(unsorted) {
    return unsorted.sort((a, b) => {
      return getDataSum(b) - getDataSum(a);
    });
  }
  $: sortedData = sortData(data);
  $: stackedData = stack(sortedData, seriesNames);
</script>

<div class="chart-wrapper">
  {#if title}
    <h4 class="chart-title">{title}</h4>
  {/if}
  <p class="chart-subtitle">{subtitle}</p>
  <ChartKey data={keyData} />
  <div class="chart-container">
    <LayerCake
      padding={{ top: 20, bottom: 20, left: 0, right: 0 }}
      x={xKey}
      y={(d) => d.data[yKey]}
      z={zKey}
      yScale={scaleBand().padding(0.5)}
      yDomain={sortedData.map((d) => d[yKey])}
      zScale={scaleOrdinal()}
      zDomain={seriesNames}
      zRange={seriesColors}
      flatData={flatten(stackedData)}
      data={stackedData}
    >
      <Svg {label}>
        <AxisX snapTicks={true} formatTick={formatTickX} />
        <BarStacked />
        <BarLabels />
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
  @media screen and (max-width: 540px) {
    .chart-container {
      height: 250px;
    }
  }

  @media screen and (max-height: 780px) {
    .chart-container {
      height: 250px;
    }
  }
  @media screen and (max-height: 540px) {
    .chart-container {
      height: 200px;
    }
  }
</style>
