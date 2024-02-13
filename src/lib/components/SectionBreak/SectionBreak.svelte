<script>
  import { Block } from "@urbaninstitute/dataviz-components";
  /** @type { string } **/
  export let number;
  /** @type { string } **/
  export let subhead;
</script>

<Block width="wide">
  <div class="section-break">
    <span class="section-number">{number}.</span>
    <div class="section-line" />
  </div>
  <h2>{subhead}</h2>
</Block>

<style>
  .section-break {
    display: flex;
    align-items: flex-end;
    justify-content: flex-start;
    margin-bottom: var(--spacing-12);
    margin-top: var(--spacing-10);
  }
  .section-number {
    font-size: 5rem;
    color: #f0573e;
    line-height: 1;
    margin-right: var(--spacing-6);
    flex-shrink: 0;
    font-family: Lato;
  }
  .section-line {
    width: 100%;
    border-bottom: solid 1px #d2d2d2;
    transform: translateY(-10px);
    flex-shrink: 1;
  }

  h2 {
    margin-bottom: var(--spacing-8);
  }
  @media screen and (min-width: 376px) {
    .section-break {
      margin-bottom: var(--spacing-10);
      margin-top: var(--spacing-16);
    }
    h2 {
      margin-bottom: var(--spacing-12);
    }
  }
  @media screen and (min-width: 768px) {
    h2 {
      margin-bottom: var(--spacing-16);
    }
    .section-break {
      margin-bottom: var(--spacing-20);
      margin-top: var(--spacing-20);
    }
    .section-number {
      margin-right: var(--spacing-4);
    }
    .section-line {
      /* transform: translateY(0); */
      display: inline-block;
      vertical-align: text-bottom;
    }
  }
</style>
