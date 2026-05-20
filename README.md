# enogtyve.org

Source code for [enogtyve.org](https://enogtyve.org) — Danmarks Bitcoin-fællesskab. Built with [Astro 5](https://astro.build) and deployed on Netlify.

## Tech stack

- **Astro 5** — static site generator
- **Netlify** — hosting, edge redirects, serverless functions
- **Pagefind** — client-side search
- **Netlify Functions** — server-side proxies for Stacker News (GraphQL) and BTC price (CoinGecko)

## Project structure

```
src/
  components/       Reusable Astro components (Header, Footer, home sections)
  content/          Markdown content collections (blog, podcasts)
  data/             Shared typed data (events.ts — conferences and meetup)
  layouts/          Page layouts (BaseLayout, ArticleLayout, ResourcePageLayout)
  pages/
    da/             Danish pages (primary language)
    en/             English pages (index + privacy policy)
    404.astro       Bilingual 404 page
  styles/           Global CSS
netlify/
  functions/        Serverless functions (stacker-news.js, btc-price.js)
public/
  images/           Logos, icons, content images
```

## Local development

Requires [Node.js](https://nodejs.org) and the [Netlify CLI](https://docs.netlify.com/cli/get-started/).

```sh
npm install
npm run netlify     # starts Astro dev server + Netlify functions locally
```

The `netlify` script runs `netlify dev`, which wires up the serverless functions at `/.netlify/functions/*` alongside the Astro dev server. Using plain `npm run dev` skips the functions, so the Stacker News feed and BTC price stat will not load.

## Build

```sh
npm run build       # outputs to dist/
```

## Contributing

Suggestions for new bookmarks, resources, or events can be submitted via the "Foreslå ressource" form on the [Bogmærker](https://enogtyve.org/da/faellesskab/bookmarks) page, or by opening an issue on GitHub.

Pull requests are welcome. Please run `npm run build` and confirm it completes without errors before opening a PR.
