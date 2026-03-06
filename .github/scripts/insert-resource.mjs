// .github/scripts/insert-resource.mjs
// Parses a GitHub issue body and inserts a new resource card into bookmarks.astro

import { readFileSync, writeFileSync } from "fs";

const BOOKMARKS_FILE = "src/pages/da/faellesskab/bookmarks.astro";

function parseIssueBody(body) {
  const fields = {};
  const sections = body.split(/^### /m).filter(Boolean);

  for (const section of sections) {
    const lines = section.trim().split("\n");
    const key = lines[0].trim();
    const value = lines
      .slice(1)
      .join("\n")
      .trim()
      .replace(/^_No response_$/i, "");
    fields[key] = value;
  }

  return {
    navn: fields["Navn på ressourcen"] || "",
    url: fields["URL"] || "",
    kategori: fields["Kategori"] || "",
    beskrivelse: fields["Kort beskrivelse (på dansk)"] || "",
  };
}

function faviconUrl(url) {
  try {
    const domain = new URL(url).hostname;
    return `https://icons.duckduckgo.com/ip3/${domain}.ico`;
  } catch {
    return "https://icons.duckduckgo.com/ip3/bitcoin.org.ico";
  }
}

function buildCard({ navn, url, beskrivelse }) {
  const favicon = faviconUrl(url);
  const safeName = navn.replace(/</g, "&lt;").replace(/>/g, "&gt;");
  const safeDesc = beskrivelse.replace(/</g, "&lt;").replace(/>/g, "&gt;");
  // Add ?ref=enogtyve if no ref/affiliate param already present
  const finalUrl = (url.includes("ref=") || url.includes("aff") || url.includes("affiliate") || url.includes("coupon") || url.includes("/enogtyve"))
    ? url
    : (url.includes("?") ? url + "&ref=enogtyve" : url.replace(/\/$/, "") + "?ref=enogtyve");

  return `            <a href="${finalUrl}" class="resource-card" target="_blank" rel="noopener noreferrer">
                <div class="resource-logo-wrap">
                <img src="${favicon}" alt="${safeName}" class="resource-logo" onerror="this.remove()"/>
                </div>
                <span class="resource-name">${safeName}</span>
                <span class="resource-desc">${safeDesc}</span>
            </a>`;
}

function insertCard(fileContent, kategori, card) {
  const escapedKategori = kategori.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

  // Find the category section, then find the closing </div> of resources-grid
  // by looking for the pattern: last </a> before </div>\n        </section>
  const sectionRegex = new RegExp(
    `(<h2>${escapedKategori}<\\/h2>[\\s\\S]*?<div class="resources-grid">)([\\s\\S]*?)(\\n        <\\/div>\\n    <\\/section>)`,
    "m"
  );

  if (!sectionRegex.test(fileContent)) {
    // Fallback: try with different whitespace
    const fallbackRegex = new RegExp(
      `(<h2>${escapedKategori}<\\/h2>[\\s\\S]*?<div class="resources-grid">)([\\s\\S]*?)(\\s*<\\/div>\\s*<\\/section>)`,
      "m"
    );
    if (!fallbackRegex.test(fileContent)) {
      throw new Error(`Kunne ikke finde kategorien "${kategori}" i bookmarks.astro`);
    }
    return fileContent.replace(fallbackRegex, (_, before, cards, closing) => {
      return `${before}${cards}\n${card}\n        ${closing.trim()}`;
    });
  }

  return fileContent.replace(sectionRegex, (_, before, cards, closing) => {
    return `${before}${cards}\n${card}${closing}`;
  });
}

// --- Main ---
const issueBody = process.env.ISSUE_BODY;
if (!issueBody) {
  console.error("Mangler ISSUE_BODY miljøvariabel");
  process.exit(1);
}

const { navn, url, kategori, beskrivelse } = parseIssueBody(issueBody);

console.log("Parsed:");
console.log({ navn, url, kategori, beskrivelse });

if (!navn || !url || !kategori || !beskrivelse) {
  console.error("Et eller flere påkrævede felter mangler i issue-body");
  process.exit(1);
}

const fileContent = readFileSync(BOOKMARKS_FILE, "utf-8");
const card = buildCard({ navn, url, beskrivelse });
const updated = insertCard(fileContent, kategori, card);

writeFileSync(BOOKMARKS_FILE, updated, "utf-8");
console.log(`✅ Kort tilføjet til kategori "${kategori}" i ${BOOKMARKS_FILE}`);
