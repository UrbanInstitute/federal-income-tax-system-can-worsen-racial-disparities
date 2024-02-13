<!--
  @component
  Generates an HTML circle pack chart using [d3-hierarchy](https://github.com/d3/d3-hierarchy).
 -->
<script>
  import { stratify, pack, hierarchy } from "d3-hierarchy";
  import { getContext } from "svelte";
  import { format } from "d3-format";
  import { createEventDispatcher } from "svelte";

  const { width, height, data } = getContext("LayerCake");

  /** @type {String} [idKey='id'] - The key on each object where the id value lives. */
  export let idKey = "id";

  /** @type {String} [parentKey] - Set this if you want to define one parent circle. This will give you a [nested](https://layercake.graphics/example/CirclePackNested) graphic versus a [grouping of circles](https://layercake.graphics/example/CirclePack). */
  export let parentKey = undefined;

  /** @type {String} [valueKey='value'] - The key on each object where the data value lives. */
  export let valueKey = "value";

  /** @type {Function} [labelVisibilityThreshold=r => r > 25] - By default, only show the text inside a circle if its radius exceeds a certain size. Provide your own function for different behavior. */
  export let labelVisibilityThreshold = (r) => r > 15;

  /** @type {String} [fill='#fff'] - The circle's fill color. */
  export let fill = "#fff";

  /** @type {String} [stroke='#999'] - The circle's stroke color. */
  export let stroke = "#999";

  /** @type {Number} [strokeWidth=1] - The circle's stroke width, in pixels. */
  export let strokeWidth = 1;

  /** @type {String} [textColor='#333'] - The label text color. */
  export let textColor = "#333";

  /** @type {String} [textStroke='#000'] - The label text's stroke color. */
  export let textStroke = "#000";

  /** @type {Number} [textStrokeWidth=0] - The label text's stroke width, in pixels. */
  export let textStrokeWidth = 0;

  /** @type {Function} [sortBy=(a, b) => b.value - a.value] - The order in which circle's are drawn. Sorting on the `depth` key is also a popular choice. */
  export let sortBy = (a, b) => b.value - a.value; // 'depth' is also a popular choice

  /** @type {Number} [spacing=0] - Whitespace padding between each circle, in pixels. */
  export let spacing = 0;

  const dispatch = createEventDispatcher();

  /* --------------------------------------------
   * This component will automatically group your data
   * into one group if no `parentKey` was passed in.
   * Stash $data here so we can add our own parent
   * if there's no `parentKey`
   */
  let parent = {};
  $: dataset = $data;

  $: if (parentKey === undefined) {
    parent = { [idKey]: "all" };
    dataset = [...dataset, parent];
  }

  $: stratifier = stratify()
    .id((d) => d[idKey])
    .parentId((d) => {
      if (d[idKey] === parent[idKey]) return "";
      return d[parentKey] || parent[idKey];
    });

  $: packer = pack().size([$width, $height]).padding(spacing);

  $: stratified = stratifier(dataset);

  $: root = hierarchy(stratified)
    .sum((d, i) => {
      return d.data[valueKey] || 1;
    })
    .sort(sortBy);

  $: packed = packer(root);

  $: descendants = packed.descendants();

  const titleCase = (d) => d.replace(/^\w/, (w) => w.toUpperCase());
  const commas = format(",");
  const roundToBillion = (num) => Math.round(num / 1e9) * 1e9;
  const formatLabel = (input) => format("$,~s")(roundToBillion(input)).replace("G", "B");
</script>

<g class="circle-pack" data-has-parent-key={parentKey !== undefined}>
  {#each descendants as d}
    <g class="circle-group" data-id={d.data.id} data-visible={labelVisibilityThreshold(d.r)}>
      <circle
        role="presentation"
        aria-hidden="true"
        focusable="false"
        class="circle"
        r={d.r}
        cx={d.x}
        cy={d.y}
        {fill}
        style="left:{d.x}px;top:{d.y}px;width:{d.r * 2}px;height:{d.r *
          2}px;background-color:{fill};border: {strokeWidth}px solid {stroke};"
        on:mousemove={(e) => {
          dispatch("mousemove", {
            e,
            props: d.data,
          });
        }}
        on:mouseout={(e) => {
          dispatch("mouseout", {
            e,
            props: d.data,
          });
        }}
        on:blur={(e) => {
          dispatch("blur", {
            e,
            props: d.data,
          });
        }}
        on:touchstart={(e) => {
          dispatch("touchstart", {
            e,
            props: d.data,
          });
        }}
        on:touchend={(e) => {
          dispatch("touchend", {
            e,
            props: d.data,
          });
        }}
      />
      <g
        class="text-group"
        style="
            color:{textColor};
            text-shadow:
              -{textStrokeWidth}px -{textStrokeWidth}px 0 {textStroke},
              {textStrokeWidth}px -{textStrokeWidth}px 0 {textStroke},
              -{textStrokeWidth}px {textStrokeWidth}px 0 {textStroke},
              {textStrokeWidth}px {textStrokeWidth}px 0 {textStroke};
            left:{d.x}px;
            top:{d.y - (labelVisibilityThreshold(d.r) ? 0 : d.r + 4)}px;
          "
      >
        <!-- <div class="text">{titleCase(d.data.id)}</div> -->
        {#if d.data.data[valueKey]}
          <text
            class="text value"
            x={d.x}
            y={d.y}
            dominant-baseline="middle"
            text-anchor="middle"
            fill="#ffffff"
            font-weight="bold">{formatLabel(d.data.data[valueKey])}</text
          >
        {/if}
      </g>
    </g>
  {/each}
</g>

<style>
  /* Hide the root node if we want, useful if we are creating our own root */
  .circle-pack[data-has-parent-key="false"] .circle-group[data-id="all"] {
    display: none;
  }
  text {
    font-family: var(--font-family-avenir-bold);
    font-stretch: normal;
    font-style: normal;
    font-weight: bold;
    font-size: 17px;
  }
  .circle {
    cursor: pointer;
  }
</style>
