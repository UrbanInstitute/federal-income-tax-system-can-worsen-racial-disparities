<script>
  import { getContext } from "svelte";
  export let id = "clipMask";

  const { width, height } = getContext("LayerCake");
</script>

<clipPath {id}>
  <rect x="0" y="0" width="{$width}px" height="{$height}px" />
</clipPath>
