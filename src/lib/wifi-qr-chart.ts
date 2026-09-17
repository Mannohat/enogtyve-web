import qrcodegen from "./qrcodegen";

/** Slots occupied by the three finder blocks moulded into the board. */
export const FIXED = (r: number, c: number): boolean =>
  (r < 4 && c < 4) || (r < 4 && c >= 11) || (r >= 11 && c < 4);

export const INVENTORY = 24; // tiles of each type in the printed set
export const HEX = "0123456789ABCDEF";

export type Security = "WPA" | "WEP" | "nopass";

export function wifiString(ssid: string, pass: string, sec: Security, hidden: boolean): string {
  const esc = (s: string) => s.replace(/([\\;,":])/g, "\\$1");
  let s = `WIFI:T:${sec};S:${esc(ssid)};`;
  if (sec !== "nopass") s += `P:${esc(pass)};`;
  if (hidden) s += "H:true;";
  return s + ";";
}

export interface Plan {
  mask: number;
  ecl: "L" | "M" | "Q" | "H";
  grid: boolean[][];   // 30x30, row-major, row 0 at the top
  ids: number[][];     // 15x15 tile ids
  counts: number[];    // tiles needed per type, fixed slots excluded
  worst: number;
  over: number;        // tiles short of the inventory, 0 when it fits
}

function padGrid(qr: qrcodegen.QrCode): boolean[][] {
  return Array.from({ length: 30 }, (_, r) =>
    Array.from({ length: 30 }, (_, c) => (r < 29 && c < 29 ? qr.getModule(c, r) : false)));
}

function tileId(g: boolean[][], r: number, c: number): number {
  return (g[2*r][2*c] ? 8 : 0) + (g[2*r][2*c+1] ? 4 : 0) + (g[2*r+1][2*c] ? 2 : 0) + (g[2*r+1][2*c+1] ? 1 : 0);
}

/** Try every mask and error-correction level; keep the one needing the fewest tiles of any one type. */
export function plan(text: string, inventory = INVENTORY): Plan | null {
  const Ecc = qrcodegen.QrCode.Ecc;
  const segs = qrcodegen.QrSegment.makeSegments(text);
  let best: (Plan & { score: number }) | null = null;
  for (const ecl of [Ecc.LOW, Ecc.MEDIUM, Ecc.QUARTILE, Ecc.HIGH]) {
    for (let mask = 0; mask < 8; mask++) {
      let qr: qrcodegen.QrCode;
      try { qr = qrcodegen.QrCode.encodeSegments(segs, ecl, 3, 3, mask, false); } catch { break; }
      const grid = padGrid(qr);
      const ids: number[][] = [], counts = new Array(16).fill(0);
      for (let r = 0; r < 15; r++) {
        ids.push([]);
        for (let c = 0; c < 15; c++) { const id = tileId(grid, r, c); ids[r].push(id); if (!FIXED(r, c)) counts[id]++; }
      }
      const worst = Math.max(...counts);
      const over = counts.reduce((a, n) => a + Math.max(0, n - inventory), 0);
      const score = over * 1000 + worst - ecl.ordinal * 0.1;
      if (!best || score < best.score)
        best = { score, mask, ecl: (["L", "M", "Q", "H"] as const)[ecl.ordinal], grid, ids, counts, worst, over };
    }
  }
  return best;
}
