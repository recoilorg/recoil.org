<script lang='ts'>
  import { faEnvelope, faDatabase, faCircleNodes, faMap } from '@fortawesome/free-solid-svg-icons'
  import { faMastodon, faWikipediaW } from '@fortawesome/free-brands-svg-icons';

  import HexIcon from '$lib/components/hex-icon.svelte';
  import Scrambler from '$lib/components/scrambler.svelte';

  let avatar_icons = [
    '/sd_avatar_thumbs/anime_1_NAME_sm.jpg',
    '/sd_avatar_thumbs/characature_1_NAME_sm.jpg',
    '/sd_avatar_thumbs/cybersplash_1_NAME_sm.jpg',
    '/sd_avatar_thumbs/fort_1_NAME_sm.jpg',
    '/sd_avatar_thumbs/fort_2_NAME_sm.jpg',
    '/sd_avatar_thumbs/graffitti_1_NAME_sm.jpg',
    '/sd_avatar_thumbs/gta_1_NAME_sm.jpg',
  ];

  function getRandomAvatarPair() {
    const randomIndex = Math.floor(Math.random() * avatar_icons.length);
    const pathTemplate = avatar_icons[randomIndex];
    return [{
      path: pathTemplate.replace('NAME', 'anil'),
      alt: 'Anil Madhavapeddy',
      link: 'https://anil.recoil.org'
    }, {
      path: pathTemplate.replace('NAME', 'nick'),
      alt: 'Nick Ludlam',
      link: 'https://nick.recoil.org'
    }];
  }

  // Colors
  let iconColor = '#DDF';
  let secondaryColor = '#36D';

  // SVG icons not covered by FontAwesome
  let peertubeIcon = `<svg viewBox="-2 0 24 24" xmlns="http://www.w3.org/2000/svg" style="fill: ${iconColor}"><path d="m3 0v12l9-6zm0 12v12l9-6zm9-6v12l9-6z"/></svg>`;
  let matrixIcon = `<svg viewBox="-2 0 33 33" style="fill: ${iconColor}">
  <g transform="translate(0.1561,0.99699998)">
    <path d="M 27.1,31.2 V 0.7 h -2.19 v -0.732 h 3.04 v 32 h -3.04 v -0.732 z" />
    <path d="m 8.23,10.4 v 1.54 h 0.044 c 0.385,-0.564 0.893,-1.03 1.49,-1.37 0.58,-0.323 1.25,-0.485 1.99,-0.485 0.72,0 1.38,0.14 1.97,0.42 0.595,0.279 1.05,0.771 1.36,1.48 0.338,-0.5 0.796,-0.941 1.38,-1.32 0.58,-0.383 1.27,-0.574 2.06,-0.574 0.602,0 1.16,0.074 1.67,0.22 0.514,0.148 0.954,0.383 1.32,0.707 0.366,0.323 0.653,0.746 0.859,1.27 0.205,0.522 0.308,1.15 0.308,1.89 v 7.63 h -3.13 v -6.46 c 0,-0.383 -0.015,-0.743 -0.044,-1.08 -0.0209,-0.307 -0.103,-0.607 -0.242,-0.882 -0.133,-0.251 -0.336,-0.458 -0.584,-0.596 -0.257,-0.146 -0.606,-0.22 -1.05,-0.22 -0.44,0 -0.796,0.085 -1.07,0.253 -0.272,0.17 -0.485,0.39 -0.639,0.662 -0.159,0.287 -0.264,0.602 -0.308,0.927 -0.052,0.347 -0.078,0.697 -0.078,1.05 v 6.35 h -3.13 v -6.4 c 0,-0.338 -0.007,-0.673 -0.021,-1 -0.0114,-0.314 -0.0749,-0.623 -0.188,-0.916 -0.108,-0.277 -0.3,-0.512 -0.55,-0.673 -0.258,-0.168 -0.636,-0.253 -1.14,-0.253 -0.198,0.0083 -0.394,0.042 -0.584,0.1 -0.258,0.0745 -0.498,0.202 -0.705,0.374 -0.228,0.184 -0.422,0.449 -0.584,0.794 -0.161,0.346 -0.242,0.798 -0.242,1.36 v 6.62 h -3.13 v -11.4 z" />
    <path d="m 0.936,0.732 v 30.5 h 2.19 v 0.732 h -3.04 v -32 h 3.03 v 0.732 z" />
  </g>
</svg>`;

  // The main service list for the page
  let services = [
    {
      name: 'Mastodon',
      faIcon: faMastodon,
      iconPadding: 'p-0',
      url: 'https://amok.recoil.org',
      text: 'We have a small, closed instance of Mastodon for all recoil.org users'
    },
    {
      name: 'Peertube',
      svg: peertubeIcon,
      url: 'https://crank.recoil.org/',
      text: 'Our instance of Peertube, a federated video sharing platform'
    },
    {
      name: 'Matrix',
      svg: matrixIcon,
      url: 'https://recoil.org/',
      tex: 'We run our own Matrix server for chat and collaboration'
    },
    {
      name: 'Wiki',
      faIcon: faWikipediaW,
      iconPadding: 'pt-1',
      url: 'https://wiki.recoil.org',
      text: ''
    },
    {
      name: 'Reforger Maps',
      faIcon: faMap,
      iconPadding: 'p-0',
      url: 'https://reforger.recoil.org',
      text: ''
    },
    {
      name: 'Karakeep',
      img: '/karakeep_logo.png',
      iconPadding: 'pt-1',
      url: 'https://hoard.recoil.org',
      text: ''
    },
    {
      name: 'Email',
      faIcon: faEnvelope,
      iconPadding: 'p-0',
      url: 'mailto:postmaster@recoil.org',
      text: 'recoil.org has hosted its own mail service since the very beginning in 1998!'
    },
    {
      name: 'Storage',
      faIcon: faDatabase,
      iconPadding: 'p-1',
      url: 'https://openzfs.org/',
      text: ''
    },
    {
      name: 'Hub',
      faIcon: faCircleNodes,
      iconPadding: 'p-0',
      url: 'https://headscale.net',
      text: ''
    },
  ];

  let phrases = services.map(s => s.name.toLowerCase()).filter(name => !name.includes(' '));
</script>
<svelte:head>
  <title>recoil.org - Homepage</title>
</svelte:head>
<div class="w-full mx-auto justify-center p-7" style="z-index:2">
  <h1 class="text-3xl sm:text-4xl md:text-5xl lg:text-6xl xl:text-8xl font-black text-gray-800">
    recoil.org/<span style="color: {secondaryColor}"><Scrambler phrases={phrases}/></span>
  </h1>
  <p class="text-sm md:text-base">Purveyors of artisanal internet services since 1998</p>

  <div class="w-full mt-10">
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
      {#each services as service}
      <a href={service.url}>    
        <div class="py-5 flex items-start justify-between shadow-md bg-clip-border rounded-xl bg-white hover:bg-blue-200">
            <div class="flex gap-5 pl-6">
              <div class="w-16 relative">
                {#if service.faIcon}
                  <HexIcon faIcon={service.faIcon} iconPadding={service.iconPadding} iconColor={iconColor} secondaryColor={secondaryColor} />
                {:else if service.svg}
                  <HexIcon iconPadding={service.iconPadding} iconColor={iconColor} secondaryColor={secondaryColor}>
                    {@html service.svg}
                  </HexIcon>
                {:else}
                <HexIcon iconPadding={service.iconPadding} iconColor={iconColor} secondaryColor={secondaryColor}>
                  <img src={service.img} alt={service.name} class="opacity-80 w-14" />
                </HexIcon>
             {/if}
              </div>
              <div class="flex items-center">
                {#if service.url}
                  <div class="block text-lg text-gray-800 font-semibold">{service.name}
                  <span class="block text-sm font-normal text-blue-700">{service.url}</span>
                  </div>
                {:else}
                  <div class="block text-2xl text-gray-800 font-semibold">{service.name}</div>
                {/if}
              </div>
            </div>
        </div>
      </a>
      {/each}
    </div>
  </div>

  <div class="mt-4 grid grid-cols-1 md:grid-cols-2 gap-4">
    {#each getRandomAvatarPair() as avatar}
      <a href={avatar.link}>
        <div class="shadow-md bg-clip-border rounded-xl w-full p-6 bg-white hover:bg-blue-200">
          <div class="flex items-center gap-4">
            <img width="64px" height="64px" class="w-16 h-16 rounded-xl" src={avatar.path} alt="{avatar.alt}">
            <div>
              <div class="text-lg font-semibold text-gray-800">{avatar.alt}</div>
              <div class="text-sm text-gray-500 text-blue-600">{avatar.link}</div>
            </div>
          </div>  
        </div>
      </a>
    {/each}
  </div>
</div>

<style lang="postcss">
  :global(html) {
    background-color: theme(colors.gray.100);
  }
</style>
