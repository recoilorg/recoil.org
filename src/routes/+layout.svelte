<script lang='ts'>
  import "../app.css";
  import { page } from '$app/state';
  import HexGrid from "../lib/components/hex-grid.svelte";
  interface Props {
    children?: import('svelte').Snippet;
  }

  let { children }: Props = $props();
</script>
{#if page?.error}
<div class="container mx-auto z-1">
  {@render children?.()}
</div>
{:else}
<HexGrid />
<div class="container mx-auto z-1">
  {@render children?.()}
</div>
{/if}
