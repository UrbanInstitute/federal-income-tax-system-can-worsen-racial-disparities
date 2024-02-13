<script>
  import Analytics from "$components/Analytics/Analytics.svelte";
</script>
<Analytics sendPageview={true}/>
<svelte:head>
<link rel="preconnect" href="https://cdn.fonts.net">
<link href="https://cdn.fonts.net/kit/8f38fb4c-184e-4fb9-b6c2-20fbc0867dd9/8f38fb4c-184e-4fb9-b6c2-20fbc0867dd9.css" rel="stylesheet" />
</svelte:head>
<slot></slot>
