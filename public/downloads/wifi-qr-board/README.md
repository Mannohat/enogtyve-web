# WiFi QR puzzle board — print files

Version 3 QR (29x29, padded to 30x30), 3.5 mm modules, 2x2-module tiles.

## Files
- `qr_puzzle_board_all.3mf` — everything in one file: board, 16-tile test plate, 384-tile full set laid out to fit one Bambu A2L plate (330 x 320).
- `qr_board.3mf` — tray, 133 x 133 x 4.5 mm. Two parts: light body, dark finder-pattern inlays.
- `qr_tiles_one_of_each.3mf` — 16 tiles (0-F), for a test print and fit check.
- `qr_tiles_full_set_384.3mf` — 24 of each tile, 228 x 152 mm.
- `board.scad`, `tile.scad` — parametric sources (OpenSCAD 2021.01). `make3mf.py` packs STLs into 3MF.

## Slicing
1. Import the 3MF. Each object already has two parts with extruder 1 = light and extruder 2 = dark assigned (Bambu Studio native metadata; also works in OrcaSlicer). If asked to split disconnected shells: **no**.
2. Check the part list shows "light" on filament 1 and "dark" on filament 2; reassign if your slicer ignored the metadata.
3. Tiles: 0.2 mm layers, 100% infill or 4+ top/bottom layers (they are only 2 mm thick). No supports.
4. Board: 0.2 mm layers, 3 walls, 15-20% infill. No supports.

## Why 24 of each, and why the chart tool must choose the mask
Tile demand is not uniform: the timing patterns always fall in the same tile rows, so some types
(e.g. 8, C, A) are needed far more often. Simulated over 1500 random credentials:
- fixed mask: up to 37 of one type needed
- best of the 8 QR mask patterns per code: at most 23 of any type
So the chart tool must generate all 8 masks and pick the one whose tile counts fit the inventory.
All 8 are valid, scannable codes. 24 of each covers every case tested.

## Simulation results
- Finder blocks match a real version-3 QR for 100% of 2000 random credentials.
- Only the correct rotation clears the corner post (wrong rotations collide by 1.2 mm²).
- Photo-realistic renders (seams, dots, 0.1-0.3 mm tile jitter, blur, perspective, uneven light)
  decode 100% with zbar (phone-class decoder). Extreme sensor noise is the only failure mode.

## Conventions
- Bit weights per tile: TL=8, TR=4, BL=2, BR=1. Tile ID = hex value.
- Clipped corner and dot go top-left, toward the letter row. Tiles only seat flush in the right rotation.
- Back ID is a dark inlay (0.4 mm, first two layers); reads upright when the tile is flipped like a page (clipped corner then top-right).
- Fixed finder blocks occupy slots A-D 1-4, L-O 1-4, A-D 12-15. 177 slots remain.
- Padding column is module 29 (right), padding row is module 29 (bottom): both always light.

## Parameters worth tuning after the test print
- `clr` (board.scad, 0.15) — overall field clearance. Increase if tiles bind.
- `post` follows `clip - clr`; increase `clip` on both files if posts feel fragile.
- `inlay` (0.6) — depth of dark colour. Deeper = more layers of dark, less bleed-through.
