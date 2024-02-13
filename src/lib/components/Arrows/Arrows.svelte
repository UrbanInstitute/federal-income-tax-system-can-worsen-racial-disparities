<!--
  @component
  Adds SVG swoopy arrows based on a config object. It attaches arrows to divs, which are created by another component such as [Annotations.html.svelte](https://layercake.graphics/components/Annotations.html.svelte).
 -->
<script>
  import { getContext, onMount } from "svelte";
  import { swoopyArrow, getElPosition, parseCssValue } from "./arrowUtils.js";

  /** @type {Array} annotations - A list of annotation objects. See the [Column](https://layercake.graphics/example/Column) chart example for the schema and options. */
  export let arrows = [];

/** @type {String} [containerClass='.chart-container'] - The class name / CSS selector of the parent element of the `<LayerCake>` component. This is used to crawl the DOM for the text annotations. */
  export let containerClass = ".chart-container";


  /** @type {String} [annotationClass='.layercake-annotation'] - The class name of the text annotation divs. */
  export let annotationClass = ".chart-annotation";

  let container;

  const { width, height, xScale, yScale } = getContext("LayerCake");

  /* --------------------------------------------
   * Some lookups to convert between x, y / width, height terminology
   * and CSS names
   */
  const lookups = [
    { dimension: "width", css: "left", position: "x" },
    { dimension: "height", css: "top", position: "y" },
  ];

  let d = (i, arrow) => "";


  function setPath(w, h) {
    return (i, arrow) => {

      /* --------------------------------------------
       * Parse our attachment directives to know where to start the arrowhead
       * measuring a bounding box based on our annotation el
       */
      const sourceCoords = [$xScale(arrow.source.x), $yScale(arrow.source.y)];

      /* --------------------------------------------
       * Default to clockwise
       */
      const clockwise = typeof arrow.clockwise === "undefined" ? true : arrow.clockwise;

      /* --------------------------------------------
       * Parse where we're drawing to
       */
      const targetCoords = [$xScale(arrow.target.x), $yScale(arrow.target.y)]
      /* --------------------------------------------
       * Create arrow path
       */
      return swoopyArrow()
        .angle(Math.PI / 2)
        .clockwise(clockwise)
        .x((q) => q[0])
        .y((q) => q[1])([sourceCoords, targetCoords]);
    };
  }

  $: d = setPath($width, $height);
</script>

<g bind:this={container}>
  {#if arrows.length}
    <g class="swoops">
        {#each arrows as arrow, i}
          <path marker-end="url(#arrowhead)" d={d(i, arrow)} stroke="#fcb64b" stroke-width="8"/>
        {/each}
    </g>
  {/if}
</g>

<style>
  .swoops {
    position: absolute;
    max-width: 200px;
    line-height: 14px;
  }
  .swoops path {
    fill: none;
    stroke: #fcb64b;
    stroke-width: 1;
  }
</style>
