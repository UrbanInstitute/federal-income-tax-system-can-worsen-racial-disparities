<script>
import { Block } from "@urbaninstitute/dataviz-components";

/** @type {String} */
export let subhead;

/** @type {{type: String, value: String}[]} */
export let text;
</script>
<div class="callout-wrap">
  <Block>
    <h2 class="callout-subhead">{subhead}</h2>
  {#each text as line}
    <p>{@html line.value}</p>
  {/each}
  </Block>
</div>
<style>
  .callout-wrap {
    background: #0A4C6A;
    color: var(--color-white);
    padding: var(--spacing-16) 0;
    margin-bottom: var(--spacing-16);
    margin-top: var(--spacing-16);
  }
  p {
    margin-bottom: var(--spacing-8);
    color: var(--color-white);
  }

  p:last-child {
    margin-bottom: 0;
  }

  h2.callout-subhead {
    margin-bottom: var(--spacing-8);
    color: var(--color-white);
  }
  .callout-wrap :global(a), .callout-wrap :global(a:visited) {
    color: #ffffff !important;
    text-decoration: underline;
  }
</style>

