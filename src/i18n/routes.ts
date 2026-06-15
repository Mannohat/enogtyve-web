/**
 * Single source of truth for Danish ↔ English page paths.
 *
 * The Danish site uses Danish slugs (/da/kom-igang/kob-bitcoin); the English site
 * uses English slugs (/en/get-started/buy-bitcoin). This map drives navigation
 * hrefs, the language switcher, and hreflang alternates so they all stay in sync.
 *
 * Keys/values are paths WITHOUT the /da or /en locale prefix.
 * Add an entry here the moment an English page is created.
 */
export const daToEn: Record<string, string> = {
  // Top level
  "/": "/",
  "/rabat": "/discounts",
  "/privatlivspolitik": "/privacypolicy",

  // Welcome
  "/velkommen/fud-facts": "/welcome/fud-facts",

  // Get started (kom-igang → get-started)
  "/kom-igang/guide": "/get-started/guide",
  "/kom-igang/kob-bitcoin": "/get-started/buy-bitcoin",
  "/kom-igang/optjen-bitcoin": "/get-started/earn-bitcoin",
  "/kom-igang/opbevaring-af-bitcoin": "/get-started/bitcoin-storage",
  "/kom-igang/hardware-wallets": "/get-started/hardware-wallets",
  "/kom-igang/seed-phrase": "/get-started/seed-phrase",
  "/kom-igang/bitcoin-software": "/get-started/bitcoin-software",
  "/kom-igang/privatliv-best-practice": "/get-started/privacy-best-practices",
  "/kom-igang/begreber-ord": "/get-started/terms-and-words",
  "/kom-igang/bitcoin-boeger-dansk": "/get-started/bitcoin-books-danish",

  // Learn (laer-mere → learn)
  "/laer-mere/bitcoin-blockchain": "/learn/bitcoin-blockchain",
  "/laer-mere/lightning": "/learn/lightning",
  "/laer-mere/lightning-wallets": "/learn/lightning-wallets",
  "/laer-mere/lightning-produkter-services": "/learn/lightning-products-and-services",
  "/laer-mere/liquid": "/learn/liquid",
  "/laer-mere/ecash": "/learn/ecash",
  "/laer-mere/ark": "/learn/ark",
  "/laer-mere/value4value": "/learn/value4value",
  "/laer-mere/bitcoin-og-din-forretning": "/learn/bitcoin-for-your-business",
  "/laer-mere/bitcoin-services-og-produkter": "/learn/bitcoin-products-and-services",
  "/laer-mere/quotes-dansk": "/learn/quotes",

  // Buidl (idevaerksted → buidl)
  "/idevaerksted/buidl": "/buidl",

  // Mining
  "/mining/mining-for-opvarmning": "/mining/mining-for-heating",
  "/mining/solo-mining": "/mining/solo-mining",
  "/mining/mempool-guide": "/mining/mempool-guide",

  // Explore (udforsk → explore)
  "/udforsk/udforsk": "/explore",
  "/udforsk/moed-andre": "/explore/meet-people",
  "/udforsk/in-the-world": "/explore/communities-worldwide",
  "/udforsk/cirkulaere-okonomier": "/explore/circular-economies",
  "/udforsk/freecities": "/explore/free-cities",
  "/udforsk/konferencer": "/explore/conferences",
  "/udforsk/twentyoneworld": "/explore/twentyone-world",
  "/udforsk/nyheder": "/explore/news",

  // Community (faellesskab → community)
  "/faellesskab/bookmarks": "/community/bookmarks",
  "/faellesskab/initiativer-danmark": "/community/initiatives-denmark",
  "/faellesskab/mediekit": "/community/media-kit",
  "/faellesskab/playliste": "/community/playlist",
  "/faellesskab/support": "/community/support",

  // Advisory (folder already English)
  "/advisory-services/raadgivning": "/advisory-services/advisory",

  // Podcasts & blog (indexes; individual posts handled by content collections)
  "/podcasts": "/podcasts",
  "/blog": "/blog",
};

/** Reverse map: English path (no prefix) → Danish path (no prefix). */
export const enToDa: Record<string, string> = Object.fromEntries(
  Object.entries(daToEn).map(([da, en]) => [en, da]),
);

/** English tails that currently have a real translated page (drives hreflang). */
export const EN_LIVE = new Set<string>([
  "/", // homepage
  "/privacypolicy",
  // Get started
  "/get-started/guide",
  "/get-started/buy-bitcoin",
  "/get-started/earn-bitcoin",
  "/get-started/bitcoin-storage",
  "/get-started/hardware-wallets",
  "/get-started/seed-phrase",
  "/get-started/bitcoin-software",
  "/get-started/privacy-best-practices",
  "/get-started/terms-and-words",
  "/get-started/bitcoin-books-danish",
  // Learn
  "/learn/bitcoin-blockchain",
  "/learn/lightning",
  "/learn/lightning-wallets",
  "/learn/lightning-products-and-services",
  "/learn/liquid",
  "/learn/ecash",
  "/learn/ark",
  "/learn/value4value",
  "/learn/bitcoin-for-your-business",
  "/learn/bitcoin-products-and-services",
  "/learn/quotes",
  // Explore
  "/explore",
  "/explore/meet-people",
  "/explore/communities-worldwide",
  "/explore/circular-economies",
  "/explore/free-cities",
  "/explore/conferences",
  "/explore/twentyone-world",
  "/explore/news",
  // Mining
  "/mining/mining-for-heating",
  "/mining/solo-mining",
  "/mining/mempool-guide",
]);

/**
 * Resolve a Danish-prefixed path (e.g. "/da/kom-igang/kob-bitcoin") to the
 * correct path for `lang`. Falls back to the Danish path when no English page
 * exists yet, so navigation never 404s mid-migration.
 */
export function localizedHref(daHref: string, lang: "da" | "en"): string {
  if (lang === "da") return daHref;
  const tail = daHref.replace(/^\/da/, "") || "/";
  const enTail = daToEn[tail];
  // Only route to English once the page is live; otherwise keep the Danish page
  // so navigation never 404s while the translation is in progress.
  if (!enTail || !EN_LIVE.has(enTail)) return daHref;
  return enTail === "/" ? "/en" : `/en${enTail}`;
}
