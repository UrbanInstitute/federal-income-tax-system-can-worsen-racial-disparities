<script>
  // global stylesheet
  import "../app.css";
  // url helper
  import { getAbsoluteUrl } from "$lib/utils/urls.js";

  // page components
  import Meta from "$components/Meta/Meta.svelte";
  import Datawrapper from "$components/Datawrapper/Datawrapper.svelte";
  import Callout from "$components/Callout/Callout.svelte";
  import BubbleChart from "$components/BubbleChart/BubbleChart.svelte";
  import Scrolly from "$components/Scrolly/Scrolly.svelte";
  import SectionBreak from "$components/SectionBreak/SectionBreak.svelte";
  import {
    TextBlock,
    ProjectCredits,
    Navbar,
    HeadingAlt,
    Block,
  } from "@urbaninstitute/dataviz-components";
  import IntroScrolly from "$components/Scrolly/IntroScrolly.svelte";
  import TaxScrolly from "$components/Scrolly/TaxScrolly.svelte";

  // page content
  // @ts-ignore
  import site_content from "$data/site_content.json";

  const scrollyComponents = { IntroScrolly, TaxScrolly };

  const _DEBUG = false;
</script>

<Meta
  title={site_content.meta.title}
  description={site_content.meta.description}
  social_image={getAbsoluteUrl("social.jpg")}
  authors={site_content.meta.authors}
  keywords={site_content.meta.keywords}
/>
<Navbar title={site_content.meta.title} brand="tpc" projectUrl={site_content.meta.url} sticky />
<main>
  {#each site_content.content as block}
    {#if block.type === "text"}
      <TextBlock>
        {@html block.value}
      </TextBlock>
    {:else if block.type.toLowerCase() === "bubblechart"}
      <BubbleChart {...block} />
    {:else if block.type.toLowerCase() === "datawrapper"}
      <Datawrapper {...block} />
    {:else if block.type.toLowerCase() === "section-break"}
      <SectionBreak {...block} />
    {:else if block.type.toLowerCase() === "scrolly"}
      <Scrolly {...block}>
        <svelte:fragment slot="background">
          <svelte:component this={scrollyComponents[block.bg]} />
        </svelte:fragment>
      </Scrolly>
    {:else if block.type.toLowerCase() === "callout"}
      <Callout {...block} />
    {/if}
  {/each}
  <Block width="body">
    <HeadingAlt content={site_content.about.heading} />
  </Block>
  {#each site_content.about.text as text}
    <TextBlock>{@html text.value}</TextBlock>
  {/each}
  <Block width="body">
    <HeadingAlt content={site_content.reading.heading} />
  </Block>
  <Block>
    <ul>
      {#each site_content.reading.items as item}
        <li>{@html item}</li>
      {/each}
    </ul>
  </Block>
  <div class="credits-spacing" />
  <ProjectCredits {...site_content.credits}>
    <svelte:fragment slot="intro">
      {#each site_content.credits.text as text}
        <TextBlock>{@html text}</TextBlock>
      {/each}
    </svelte:fragment>
  </ProjectCredits>
  <div class="post-credits-section">
    <Block>
      {#each site_content.post_credit_lines as line}
        <p class="post-credit-line">{@html line.text}</p>
      {/each}
    </Block>
  </div>
</main>

<style>
  .post-credits-section {
    margin-bottom: var(--spacing-16);
  }
  .post-credit-line {
    font-size: var(--font-size-small);
  }
</style>
