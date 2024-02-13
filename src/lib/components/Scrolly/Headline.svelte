<script>
  import { SocialShare } from "@urbaninstitute/dataviz-components";

  /**
   * Text to display as page headline
   * @type {string}
   */
  export let headline;
  /**
   * Text to display as page subhead
   * @type {string}
   */
  export let subhead;
  /**
   * Text to display as publication date
   * @type {string}
   */
  export let pubdate;
</script>

<div class="page-headline-wrapper">
  <h1 class="page-headline">{headline}</h1>
  {#if subhead}
    <p class="page-subhead">{subhead}</p>
  {/if}
  {#if pubdate}
    <p class="page-pubdate">{pubdate}</p>
  {/if}
  {#if typeof window !== "undefined"}
    <SocialShare shareUrl={window.location.href} variant="light" />
  {/if}
</div>

<style>
  .page-headline-wrapper {
    text-align: center;
    width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    position: relative;
    max-width: 960px;
    margin: 0 auto;
  }
  .page-headline {
    margin-bottom: 1rem;
    color: var(--color-white);
  }
  .page-subhead {
    color: var(--color-white);
    font-style: italic;
    margin-bottom: 2rem;
  }
  .page-pubdate {
    color: var(--color-white);
    font-size: var(--font-size-large);
    margin-bottom: 2rem;
  }
</style>
