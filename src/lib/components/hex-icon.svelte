<script lang="ts">
  import type { IconDefinition } from "@fortawesome/free-solid-svg-icons";
  import Fa from "svelte-fa";

  export let iconColor = '#AFA';
  export let secondaryColor = '#2A8';
  export let icon: IconDefinition | null = null;
  export let iconPadding = 'p-2';
</script>
<div class="w-full h-auto min-w-16">
  <svg xmlns="http://www.w3.org/2000/svg" class="w-full h-auto" viewBox="0 0 87 87">
    <path fill="{secondaryColor}" d="M38.5 1.3867513459481a10 10 0 0 1 10 0l28.9711431703 16.726497308104a10 10 0 0 1 5 8.6602540378444l0 33.452994616207a10 10 0 0 1 -5 8.6602540378444l-28.9711431703 16.726497308104a10 10 0 0 1 -10 0l-28.9711431703 -16.726497308104a10 10 0 0 1 -5 -8.6602540378444l0 -33.452994616207a10 10 0 0 1 5 -8.6602540378444"></path>
  </svg>
</div>
<div class="w-1/2 h-auto absolute top-4 left-1/4 rounded-lg">
  {#if icon}
  <Fa icon={icon} class='!w-full !h-full {iconPadding}' color="{iconColor}" />
  {:else}
  <slot />
  {/if}
</div>
