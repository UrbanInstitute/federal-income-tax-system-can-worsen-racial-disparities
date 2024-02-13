<script>

/** @type {{label: string, color: string}[]} [data] - The data to visualize in a flat array. */
export let data = [];

</script>
<div class="key-wrap">
  {#each data as item}
  <div class="key-item-wrap">
    <div class="key-item-swatch" style:background={item.color}></div>
    <p class="key-item-label">{item.label}</p>
  </div>
  {/each}
</div>
<style>
.key-wrap {
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  width: 100%;
}
.key-item-wrap {
  display: flex;
  align-items: middle;
  justify-content: flex-start;
  font-size: var(--font-size-small);
  margin-right: 1rem;
}
p.key-item-label {
  line-height: 1;
  vertical-align: middle;
  font-size: var(--font-size-small);
  margin-left: 0.25rem;
}

.key-item-swatch {
  width: 1em;
  height: 1em;
}
</style>
