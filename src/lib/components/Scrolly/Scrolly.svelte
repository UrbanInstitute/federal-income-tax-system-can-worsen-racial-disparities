<script>
  import Scroller from "@sveltejs/svelte-scroller";
  import Headline from "./Headline.svelte";
  import { writable } from "svelte/store";
  import { setContext } from "svelte";

  /**
   * An array of content blocks with text or HTML to use in the foreground of the scrolly component
   * @type {{type: string, value: string}[]}
   */
  export let slides = [];

  /**
   * The vertical position that the top of the foreground must scroll past before the background becomes fixed, as a proportion of window height
   * @type {number} [top=0]
   */
  export let top = 0;

  /**
   * The inverse of top —  once the bottom of the foreground passes this point, the background becomes unfixed
   * @type {number} [bottom=1]
   */
  export let bottom = 1;

  /**
   * Once a section crosses this point, it becomes 'active'
   * @type {number} [threshold=0.75]
   */
  export let threshold = 0.75;

  /**
   * The spacing between sections, as a proportion of window height
   * @type {number} [spacing=0.75]
   */
  export let spacing = 0.75;

  /**
   * The spacing before the first section
   * @type {number} [startOffset=0.5]
   */
  export let startOffset = 0.5;

  /**
   * The spacing after the last section
   * @type {number} [endOffset=0.75]
   */
  export let endOffset = 0.75;

  // setup stores to add to context
  const index = writable(0);
  const offset = writable(0);
  const progress = writable(0);
  const slideHeight = writable(0);
  const slideWidth = writable(0);

  $: context = { index: index, offset: offset, progress: progress, slideHeight, slideWidth };
  $: setContext("scrolly", context);
</script>

<svelte:window bind:innerHeight={$slideHeight} bind:innerWidth={$slideWidth} />
<div class="scrolly-wrapper">
  <Scroller
    {top}
    {bottom}
    {threshold}
    bind:index={$index}
    bind:offset={$offset}
    bind:progress={$progress}
  >
    <div slot="background">
      <slot name="background" />
    </div>
    <div slot="foreground" class="foreground">
      {#each slides as slide, i}
        {@const firstSlide = i === 0}
        {@const lastSlide = i === slides.length - 1}
        <section
          style:margin-top="{firstSlide ? $slideHeight * startOffset : 0}px"
          style:margin-bottom="{lastSlide ? $slideHeight * endOffset : $slideHeight * spacing}px"
        >
          <slot {slide} name="foreground">
            {#if slide.type == "headline"}
              <Headline headline={slide.title} subhead={slide.subtitle} pubdate={slide.pubdate}/>
            {:else}
              <div class="scrolly-text-box">
                <p>{@html slide.value}</p>
              </div>
            {/if}
          </slot>
        </section>
      {/each}
    </div>
  </Scroller>
</div>

<style>
  .scrolly-text-box {
    background-color: rgba(255, 255, 255, 0.95);
    box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25);
    padding: 2rem;
    max-width: 595px;
    width: 80%;
    margin: 0 auto;
    text-align: center;
  }
  .scrolly-text-box p:last-child {
    margin-bottom: 0;
  }
  .foreground {
    display: flex;
    flex-direction: column;
  }
  .scrolly-wrapper {
    margin-bottom: var(--spacing-8);
  }
  :global(.annotation-highlight) {
    background-color: #b0d0db;
    padding: var(--spacing-1) .25rem;
  }
  @media (min-width: 768px) {
    .scrolly-text-box {
      padding: 4rem 3rem;
    }
  }
</style>
