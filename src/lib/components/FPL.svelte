<script>
  import { getContext } from "svelte";

  const { xScale, yDomain, height, yRange } = getContext("LayerCake");
  const text = "Federal Poverty Level";
  const x = 30000;

</script>
<g>
<line x1={$xScale(x)} x2={$xScale(x)} y1={0} y2={$height} stroke="#fcb64b" stroke-width="2" stroke-dasharray="2,2" />
  <text fill="#000000" x={$xScale(x)} y={$yRange[1]} dy="15" dx="5" font-size="13px" text-anchor="start">{text}</text>
</g>
