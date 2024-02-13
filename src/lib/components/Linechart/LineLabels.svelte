<script context="module">
  /**
   * @typedef {Object} LabelItem
   * @property {number} x
   * @property {number} y
   * @property {string} text
   * @property {string} color
   * @property {boolean} bold
   * @property {number} fontSize
   */
</script>

<script>
  import { getContext } from "svelte";
  import { transitionIn, transitionOut } from "$components/Scrolly/transitions.js";
  import { fade } from "svelte/transition";

  const { xScale, yScale } = getContext("LayerCake");

  /** @type {LabelItem[]} */
  export let labels = [];
</script>

<div class="chart-annotations">
  {#each labels as { x, y, text, color, bold, fontSize } (text)}
    <!-- <text x={$xScale(36000)} y={$yScale(5500)}>CTC</text> -->
    <!-- <text x={$xScale(60000)} y={$yScale(4500)}>EITC</text> -->
    <p
      style:left="{$xScale(x)}px"
      style:top="{$yScale(y)}px"
      style:color
      class:bold
      class="chart-annotation"
      style:font-size={fontSize ? `${fontSize}px` : null}
      in:fade={{ duration: 300 }}
      out:fade={{ duration: 300 }}
    >
      {text}
    </p>
  {/each}
</div>

<style>
  .chart-annotations {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
  }
  p {
    position: absolute;
    /* text-align: center; */
    font-size: 13px;
    font-family: var(--font-family-avenir-regular);
  }
  p.bold {
    font-family: var(--font-family-avenir-bold);
  }
  @media (max-width: 768px) {
    p {
      font-size: 11px;
      /* transform: translateX(-50%); */
    }
  }
</style>
