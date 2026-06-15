# Enogtyve — English Translation Style Guide

The reference for translating the site from Danish to English. The goal is
**native-quality English**, not literal translation. Read this before translating
any page so terminology and tone stay consistent across the whole site.

## Voice & tone
- **Informal, warm, welcoming.** The Danish uses informal address (du/dig/dine);
  English uses **"you" / "your"**. Never formal/stiff.
- **Plain language.** Short sentences. Explain jargon the first time it appears.
- **Inclusive & non-preachy.** The site welcomes curious newcomers. Avoid
  maximalist lecturing; keep the friendly, educational tone of the original.
- **Not financial advice.** Preserve any "this is not financial advice" framing.
- Rewrite for flow — do **not** calque Danish sentence structure. If a literal
  translation reads awkwardly, rephrase so it reads as if written in English.

## Capitalization of bitcoin / Bitcoin
Follow the original's convention (it is consistent):
- **Bitcoin** (capital B) = the network / protocol / system / idea.
- **bitcoin** (lowercase) = the asset / unit of currency. "buy bitcoin", "1 bitcoin".
- **BTC**, **sats**, **satoshis** as-is.

## Terms kept in English (do NOT translate — already English/native crypto terms)
self-custody, seed phrase, hardware wallet, wallet, node, mining, miner, hash,
Proof of Work (PoW), Lightning, Lightning Network, channel, UTXO, mempool,
multisig, cold storage, exchange, custodian, satoshi/sats, halving, mempool,
fiat, KYC, P2P, on-chain, off-chain, Liquid, eCash, Ark, Value4Value (V4V).

## Danish → English glossary (recurring terms)
| Danish | English |
|---|---|
| børs / vekseltjeneste | exchange |
| kryptovaluta | cryptocurrency ("crypto" only when the original is dismissive of it) |
| opbevaring (af bitcoin) | (bitcoin) storage / custody |
| (private) nøgler | (private) keys |
| privatliv | privacy |
| anskaffe / anskaffelse | acquire / acquiring (or "get") |
| optjen(e) | earn |
| køb / købe | buy / purchase |
| gebyr(er) | fee(s) |
| pung / tegnebog | wallet |
| sikkerhedskopi | backup |
| tofaktorbekræftelse (2FA) | two-factor authentication (2FA) |
| begreber & ord | terms & words |
| rådgivning | advisory / guidance |
| fællesskab | community |
| varmeudnyttelse | heat utilization / using the heat |
| opvarmning | heating |
| forretning / virksomhed | business |
| nyheder | news |
| værktøjer | tools |
| vejledning / guide | guide |
| trin / skridt | step |

## Brand & proper nouns
- **Enogtyve** stays "Enogtyve" (it means "twenty-one" in Danish — gloss it the
  first time on a page if context calls for it, as the homepage does).
- Product/company names, referral codes (e.g. `enogtyve`), and URLs are **never**
  translated.
- Danish institutions: translate descriptively (e.g. "Datatilsynet" → "the Danish
  Data Protection Agency").

## Mechanics (every page)
- **Translate only human-readable text.** Leave untouched: `class`/`id`,
  `<style>` blocks, image `src`, component imports, code, referral codes.
- **`alt` text and `title`/`description` frontmatter must be translated.**
- **Internal links:** rewrite `/da/...` → the English path from
  `src/i18n/routes.ts` (English slugs, e.g. `/da/kom-igang/kob-bitcoin` →
  `/en/get-started/buy-bitcoin`). If a target page is not yet translated, link to
  the English path anyway (it will exist when the section is done) — never leave a
  `/da/` link on an English page.
- **`lang="da"` → `lang="en"`** in the layout props.
- Keep external links, `target="_blank"`, `rel`, and all markup structure identical.

## Numbers, dates, currency
- English number formatting (e.g. "19 million", "100,000,000").
- Dates in English (e.g. "25–26 September 2026").
- Keep DKK where the original references Danish kroner; translate "din bank" →
  "your bank" etc. Keep the meaning local-accurate (some services are EU/DK-specific).

## Review checklist (per page)
1. Reads like native English, not translated Danish.
2. bitcoin/Bitcoin capitalization correct throughout.
3. All internal links point to `/en/...` English slugs.
4. `lang="en"`, title/description/alt translated.
5. No Danish words left (except brand names / glossed terms).
6. Builds with no errors; page renders.
