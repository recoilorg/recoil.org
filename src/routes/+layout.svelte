<script lang='ts'>
  import "../app.css";
  import { page } from '$app/stores';
  import HexGrid from "../lib/components/hex-grid.svelte";
</script>
{#if $page?.error}
<div class="container mx-auto z-1">
  <slot />
</div>
{:else}
<HexGrid />
<div class="container mx-auto z-1">
  <slot />
</div>
{/if}
