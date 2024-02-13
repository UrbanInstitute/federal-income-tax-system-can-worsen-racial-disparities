<script>
  import { getContext } from "svelte";

  const { slideHeight } = getContext("scrolly");

  /**
   * Image filename
   * @type {string}
   */
  export let src;
  /**
   * Image alt text
   * @type {string}
   */
  export let alt;

  /**
   * Image alt text
   * @type {string | null}
   */
  export let overlay = null;

  /**
   * Opacity of image overlay
   * @type {number} [overlayOpacity=0.95]
   */
  export let overlayOpacity = 0.95;
</script>

<div class="image-wrapper" style:height="{$slideHeight}px">
  <picture>
    <!-- AVIF image for browsers that support AVIF -->
    <source srcset="{src}.avif" type="image/avif" />

    <!-- WebP image for browsers that support WebP -->
    <source srcset="{src}.webp" type="image/webp" />

    <!-- JPEG image for browsers that do not support WebP -->
    <source srcset="{src}.jpg" type="image/jpeg" />

    <!-- Fallback image for browsers that do not support the <picture> element -->
    <img src="{src}.jpg" {alt} width="2000" height="1620" />
  </picture>

  {#if overlay}
    <div class="image-overlay" style:background={overlay} style:opacity={overlayOpacity} />
  {/if}
</div>

<style>
  .image-wrapper {
    width: 100%;
  }
  picture,
  img {
    display: block;
    height: 100%;
    width: 100%;
    object-fit: cover;
  }
  .image-overlay {
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
  }
</style>
