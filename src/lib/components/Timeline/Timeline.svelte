<script>
  import { scaleLinear } from "d3-scale";
  import { getContext } from "svelte";

  import items from "./items.yml";

  const { slideHeight } = getContext("scrolly");

  const breakPoint = 1268;

  let timelineWidth = 768;
  $: timelineHeight = $slideHeight > 975 ? 800 : $slideHeight > 700 ? 500 : $slideHeight < 600 ? 200 : 300;
  $: timelineCenter = timelineHeight / 2;
  $: xScale = scaleLinear().range([0, timelineWidth]);

  $: desktopLayout = timelineWidth > breakPoint;

  export let headline =
    "Throughout US History, People of Color Have Faced Significant Barriers to Economic Opportunity";
  export let sourceline = "The included events reinforce one another and are not exhaustive. See About the Data section for sources.";
</script>

<svelte:window bind:innerWidth={timelineWidth} />
<div
  class="timeline-wrap"
  style:--timeline-height="{timelineHeight}px"
  style:height="{$slideHeight}px"
>
  <div class="timeline-inner">
    <h4 class="timeline-headline">{headline}</h4>
    {#if desktopLayout}
      <div
        class="timeline-container"
        style:width="{timelineWidth}px"
        style:height="{timelineHeight}px"
      >
        <svg
          width={timelineWidth}
          height={timelineHeight}
          viewBox="0 0 {timelineWidth} {timelineHeight}"
        >
          {#each items as item}
            <line
              x1={xScale(item.x)}
              y1={timelineCenter}
              x2={xScale(item.x)}
              y2={item.orientation == "top" ? timelineCenter / 2 : timelineCenter * 1.5}
              stroke="var(--color-black)"
              stroke-width="2"
            />
          {/each}
          <line
            x1="8"
            y1={timelineCenter}
            x2={timelineWidth}
            y2={timelineCenter}
            stroke="var(--color-white)"
            stroke-width="5"
          />
          <circle cx="8" cy={timelineCenter} r="8" fill="white" />
        </svg>
        <div class="timeline-annotations">
          {#each items as item}
            <div
              class="timeline-annotation-item {item.orientation}"
              style:left="{item.x * timelineWidth}px"
              style:width="{item.width}px"
            >
              <p class="timeline-label">{item.date_label}</p>
              <p>{item.title}</p>
            </div>
          {/each}
        </div>
      </div>
    {:else}
      <div class="timeline-items">
        {#each items as item, i}
          <div class="timeline-item">
            <p><span class="timeline-label">{item.date_label}</span> {item.title}</p>
          </div>
        {/each}
      </div>
    {/if}
    <div class="chart-footer"><p>{sourceline}</p></div>
  </div>
</div>

<style>
  .timeline-wrap {
    z-index: 10;
    position: absolute;
    top: 0;
    padding: 4rem 1rem 0;
    width: 100%;
  }
  .timeline-item {
    color: var(--color-white);
    padding: 0 var(--spacing-2);
  }
  .timeline-item .timeline-label {
    width: 70px;
  }
  .timeline-item p {
    color: var(--color-white);
    font-size: 14px;
    line-height: 1.4;
  }
  .timeline-label {
    font-family: var(--font-family-sans-bold);
  }
  .timeline-headline {
    padding-left: var(--spacing-4);
    padding-right: var(--spacing-4);
    border-left: solid 5px var(--color-white);
    margin: var(--spacing-8) 0 var(--spacing-4);
  }

  .timeline-items {
    background: var(--color-black);
    margin: 0 calc(var(--spacing-4) + 5px);
    padding: var(--spacing-2);
  }

  .timeline-container {
    position: relative;
  }
  .timeline-annotations {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
  }

  .timeline-annotation-item {
    background: var(--color-black);
    color: var(--color-white);
    padding: var(--spacing-4);
    position: absolute;
    width: 250px;
    top: 50%;
  }
  .timeline-annotation-item p {
    font-size: 14px;
  }
  :global(.timeline-annotation-item.bottom) {
    transform: translate(-50%, calc(var(--timeline-height) / 8));
  }
  :global(.timeline-annotation-item.top) {
    transform: translate(-50%, calc(0px - var(--timeline-height) / 8 - 100%));
  }
  .timeline-annotation-item p {
    color: var(--color-white);
    line-height: 1.2;
  }
  .timeline-inner {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    width: calc(100% - 2rem);
    max-width: 600px;
  }

  @media screen and (min-width: 1269px) {
    .timeline-item p {
      display: block;
    }
    .timeline-item p {
      font-size: var(--font-size-normal);
    }
    .timeline-items {
      margin: 0;
    }
    .timeline-inner {
      max-width: none;
    }
  }
  @media screen and (min-width: 540px) {
    .timeline-item p {
      font-size: var(--font-size-normal);
      line-height: var(--line-height-normal);
      margin-bottom: 1em;
    }
  }
  @media screen and (max-width: 768px) {
    .timeline-headline {
      font-size: var(--font-size-normal);
    }
  }
  @media screen and (max-height: 728px) {}
    .timeline-headline {
      font-size: var(--font-size-large);
    }
    .timeline-item p {
      font-size: 14px;
    }
</style>
