// Netlify Function: returns the current BTC price in DKK as { dkk }.
// Server-side proxy so the browser never calls CoinGecko directly
// (avoids CORS + shared keyless rate limits).
//
// Optional: set a CoinGecko Demo API key as a Netlify env var named
// COINGECKO_DEMO_KEY. If present it's sent as the x-cg-demo-api-key header,
// which gives the dedicated 100 calls/min Demo quota instead of the
// throttled keyless pool. Works fine with no key too.

export const handler = async function () {
  const apiKey = process.env.COINGECKO_DEMO_KEY;

  const headers = { Accept: "application/json" };
  if (apiKey) headers["x-cg-demo-api-key"] = apiKey;

  try {
    const res = await fetch(
      "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=dkk",
      { headers }
    );
    if (!res.ok) throw new Error(`CoinGecko ${res.status}`);

    const data = await res.json();
    const dkk = data?.bitcoin?.dkk;
    if (!Number.isFinite(dkk) || dkk <= 0) throw new Error("invalid payload");

    return {
      statusCode: 200,
      headers: {
        "Content-Type": "application/json",
        "Cache-Control": "public, max-age=60",
      },
      body: JSON.stringify({ dkk }),
    };
  } catch (e) {
    return {
      statusCode: 502,
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ error: e.message }),
    };
  }
};
