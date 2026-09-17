// @ts-check
import { defineConfig } from 'astro/config';
import pagefind from 'astro-pagefind';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://enogtyve.org',
  integrations: [
    pagefind(),
    sitemap({
      // /tools is unlisted: keep it out of the sitemap
      filter: (page) => !page.includes('/tools'),
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