<script>
  import { getContext } from 'svelte';

  const { data, xGet, yGet, y } = getContext('LayerCake');

</script>
<g class="label-group">
  {#each $data[0] as group, i}
      <text
        class='group-rect'
        data-id="{i}"
        dy="-0.5em"
        font-size="14"
        font-weight="bold"
        x="{$xGet(group)[0]}"
        y="{$yGet(group)}"
      >{$y(group)}</text>
  {/each}
</g>
