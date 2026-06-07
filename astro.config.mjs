// Astro 블로그 — GitHub Pages 루트 배포 설정
import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://ericbean90-ship-it.github.io',
  base: '/',
  trailingSlash: 'always',
  markdown: {
    shikiConfig: {
      theme: 'github-dark',
    },
  },
});
