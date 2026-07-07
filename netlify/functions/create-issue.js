const ALLOWED_ORIGINS = new Set([
  "https://enogtyve.org",
  "https://www.enogtyve.org",
]);

const ALLOWED_LABELS = ["ny-ressource"];

const MAX_LENGTHS = { navn: 120, url: 500, kategori: 80, beskrivelse: 1000 };

function isValidUrl(s) {
  try {
    const u = new URL(s);
    return u.protocol === "http:" || u.protocol === "https:";
  } catch {
    return false;
  }
}

export const handler = async function (event) {
  if (event.httpMethod !== "POST") {
    return { statusCode: 405, body: "Method Not Allowed" };
  }

  // CSRF: reject requests not originating from the site
  const origin = event.headers["origin"] || event.headers["referer"] || "";
  const allowed =
    ALLOWED_ORIGINS.has(origin) ||
    [...ALLOWED_ORIGINS].some((o) => origin.startsWith(o + "/")) ||
    origin.includes("localhost") ||
    origin.includes("deploy-preview");
  if (!allowed) {
    return { statusCode: 403, body: "Forbidden" };
  }

  const token = process.env.GH_ISSUES_TOKEN;
  if (!token) {
    return { statusCode: 500, body: "Server misconfiguration" };
  }

  let payload;
  try {
    payload = JSON.parse(event.body);
  } catch {
    return { statusCode: 400, body: "Invalid JSON" };
  }

  const { navn, url, kategori, beskrivelse, labels } = payload;

  // Validate required fields and lengths
  if (
    typeof navn !== "string" ||
    typeof url !== "string" ||
    typeof kategori !== "string" ||
    typeof beskrivelse !== "string"
  ) {
    return { statusCode: 400, body: "Missing fields" };
  }

  const fields = { navn: navn.trim(), url: url.trim(), kategori: kategori.trim(), beskrivelse: beskrivelse.trim() };

  for (const [key, max] of Object.entries(MAX_LENGTHS)) {
    if (!fields[key]) return { statusCode: 400, body: `${key} is required` };
    if (fields[key].length > max) return { statusCode: 400, body: `${key} too long` };
  }

  if (!isValidUrl(fields.url)) {
    return { statusCode: 400, body: "Invalid URL" };
  }

  // Whitelist labels — never trust client-supplied label list
  const safeLabels = Array.isArray(labels)
    ? labels.filter((l) => ALLOWED_LABELS.includes(l))
    : ALLOWED_LABELS;

  const title = `[Ressource]: ${fields.navn}`.slice(0, 160);
  const body = [
    "### Navn på ressourcen", "", fields.navn, "",
    "### URL", "", fields.url, "",
    "### Kategori", "", fields.kategori, "",
    "### Kort beskrivelse (på dansk)", "", fields.beskrivelse,
  ].join("\n");

  try {
    const res = await fetch(
      "https://api.github.com/repos/Mannohat/enogtyve-web/issues",
      {
        method: "POST",
        headers: {
          Authorization: "Bearer " + token,
          "Content-Type": "application/json",
          Accept: "application/vnd.github+json",
        },
        body: JSON.stringify({ title, body, labels: safeLabels }),
      }
    );

    return {
      statusCode: res.ok ? 200 : 502,
      body: res.ok ? "ok" : "upstream error",
    };
  } catch {
    return { statusCode: 502, body: "upstream error" };
  }
};
