<script>
  import { getContext } from "svelte";
  import { fade } from "svelte/transition";
  const { xScale, height } = getContext("LayerCake");
  export let xStart = 0;
  export let xEnd = 0;
  export let fill = "#b0d0db";
  // export let fill = "#cae0e7";
  export let opacity = 0.5;
</script>

<g transition:fade clip-path="url(#line-mask)">
  <rect
    x={$xScale(xStart)}
    width={$xScale(xEnd) - $xScale(xStart)}
    {fill}
    {opacity}
    y={0}
    height={$height}
  />
</g>
