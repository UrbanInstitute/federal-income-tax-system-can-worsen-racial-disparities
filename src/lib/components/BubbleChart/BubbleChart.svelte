<script>
  import { LayerCake, Svg, Html } from "layercake";
  import { Block } from "@urbaninstitute/dataviz-components";
  import { tpcColors } from "@urbaninstitute/dataviz-components/utils";
  import Tooltip from "./Tooltip.html.svelte";

  import CirclePack from "$components/BubbleChart/Bubbles.svg.svelte";

  // This example loads csv data as json using @rollup/plugin-dsv
  import data from "$data/cap_retirement_expend.csv";

  /** @type {String} */
  export let title;
  /** @type {String} */
  export let subtitle;
  /** @type {String} */
  export let source;
  /** @type {String} */
  export let notes;
  /** @type {String} */
  export let label;

  let tooltip = null;

  const idKey = "policy";
  const valueKey = "value";

  data.forEach((d) => {
    d[valueKey] = +d[valueKey];
  });
</script>

<Block>
  <div class="chart-wrapper">
    <h4 class="chart-title">{title}</h4>
    <p class="chart-subtitle">{subtitle}</p>
    <div class="chart-container">
      <LayerCake padding={{ top: 0, bottom: 20, left: 30 }} {data}>
        <Svg {label}>
          <CirclePack
            {idKey}
            {valueKey}
            fill={tpcColors.blue}
            stroke="#000000"
            textColor="#FFFFFF"
            textStroke="#000000"
            spacing={1}
            strokeWidth={0}
            textStrokeWidth={0}
            on:mousemove={(e) => {
              tooltip = e;
            }}
            on:touchstart={(e) => {
              tooltip = e;
            }}
            on:mouseout={() => {
              tooltip = null;
            }}
            on:blur={() => {
              tooltip = null;
            }}
            on:touchend={() => {
              tooltip = null;
            }}
          />
        </Svg>
        {#if tooltip}
          <Html pointerEvents={false}>
            <Tooltip evt={tooltip} let:detail size="large" style="light">
              {detail.props.data.policy}
            </Tooltip>
          </Html>
        {/if}
      </LayerCake>
    </div>
    <p class="chart-guide">Hover over or tap for provision details.</p>
    <div class="chart-footer">
      <p><strong>Source:</strong> {@html source}</p>
      <p><strong>Notes:</strong> {notes}</p>
    </div>
  </div>
</Block>

<style>
  /*
    The wrapper div needs to have an explicit width and height in CSS.
    It can also be a flexbox child or CSS grid element.
    The point being it needs dimensions since the <LayerCake> element will
    expand to fill it.
  */
  .chart-container {
    width: 100%;
    max-width: 750px;
    margin: 0 auto;
    height: 550px;
  }
  .chart-wrapper {
    margin-bottom: var(--spacing-8);
  }
  .chart-guide {
    text-align: center;
    margin-bottom: var(--spacing-8);
    font-family: var(--font-family-avenir-italic);
    font-style: italic;
  }
  @media(max-width: 600px) {
    .chart-container {
      height: 90vw;
    }

  }
</style>
