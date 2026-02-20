// @ts-check
import { defineConfig } from 'astro/config';
import pagefind from 'astro-pagefind';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://enogtyve.org',
  integrations: [
    pagefind(),
    sitemap({
      i18n: {
        defaultLocale: 'da',
        locales: {
          da: 'da-DK',
          en: 'en-US',
        },
      },
    }),
  ],
});