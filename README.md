# recoil.org

Services we are running:

- Mastodon
- PeerTube
- Email
- Shell access
- anil.recoil.org
- nick.recoil.org

## Local development

1. `pnpm install`
2. `pnpm dev` - Spin up the local server on http://localhost:5173
3. `pnpm build` - Output the static site into the build/ directory

## Docker build

The docker image binds to port 80, so replace the local 3333 with whatever you like.

1. `docker build . -t recoilorg`
2. `docker run -p 3333:80 recoilorg`

## Amok deploy

1. Get a root shell on amok.recoil.org
2. Run /root/recoil.org/run.sh

## Notes

This is an initial minimal build so we find it easier to maintain and extend

## Screenshot

![The website](/screenshot.jpeg)
