// WiFi QR puzzle board — tray for a 30x30-module (version 3, padded) code
// Origin at bottom-left corner of the board. Row 1 / letter row is at the TOP (+y).

part      = "light";   // "light" (tray) or "dark" (finder pattern inlays)

m         = 3.5;       // module size
tile      = 2*m;
n         = 15;        // slots per side
field     = n*tile;    // 105 mm
rim       = 4*m;       // 14 mm quiet zone
W         = field + 2*rim;

base      = 1.5;       // floor thickness
th        = 2.0;       // tile thickness -> pocket depth
lip       = 1.0;       // rim stands this much above tile tops
inlay     = 0.6;
clr       = 0.15;      // clearance around the whole field
clip      = 2.0;       // tile corner clip
post      = clip - clr;
label_depth = 0.4;
label_size  = 5;
back_text   = "ENOGTYVE.ORG/TOOLS";   // dark inlay on the underside
back_size   = 7;
back_depth  = 0.4;                    // first two layers

$fn = 24;

top_tiles = base + th;       // 3.5
top_rim   = top_tiles + lip; // 4.5

// slot (c,r): c 0..14 left->right, r 0..14 top->bottom. returns [x_left, y_top]
function slot(c, r) = [rim + c*tile, rim + field - r*tile];
// module (col,row) 0..29
function mod(col, row) = [rim + col*m, rim + field - row*m];

fixed_blocks = [[0,0],[11,0],[0,11]];   // slot coords of top-left slot of each 4x4 fixed block
function is_fixed(c, r) = (c<4 && r<4) || (c>=11 && r<4) || (c<4 && r>=11);

module fixed_block_2d(b) {
    p = slot(b[0], b[1]);
    translate([p[0], p[1] - 4*tile]) square(4*tile);
}

module recess_2d() {
    difference() {
        translate([rim - clr, rim - clr]) square(field + 2*clr);
        for (b = fixed_blocks) fixed_block_2d(b);
    }
}

module posts() {
    for (c=[0:n-1], r=[0:n-1]) if (!is_fixed(c, r)) {
        p = slot(c, r);
        translate([p[0], p[1], 0])
            linear_extrude(top_tiles) polygon([[-0.05,0.05],[post,0.05],[-0.05,-post]]);
    }
}

// finder pattern: 7x7, dark ring, light ring, dark 3x3 centre
function finder_dark(i, j) = (i==0||i==6||j==0||j==6) || (i>=2&&i<=4&&j>=2&&j<=4);
finders = [[0,0],[22,0],[0,22]];   // module col,row of finder top-left

module finder_inlays(over=0) {
    for (f = finders) for (i=[0:6], j=[0:6]) if (finder_dark(i, j)) {
        p = mod(f[0]+i, f[1]+j);
        translate([p[0], p[1]-m, top_tiles - inlay]) cube([m, m, inlay + over]);
    }
}

module labels() {
    letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O"];
    translate([0,0,top_rim - label_depth]) linear_extrude(label_depth + 0.01) {
        for (c=[0:n-1])
            translate([rim + c*tile + tile/2, W - rim/2])
                text(letters[c], size=label_size, halign="center", valign="center", font="Liberation Sans:style=Bold");
        for (r=[0:n-1])
            translate([rim/2, rim + field - r*tile - tile/2])
                text(str(r+1), size=label_size, halign="center", valign="center", font="Liberation Sans:style=Bold");
    }
}

module back_label(over=0) {
    // on the underside, mirrored so it reads correctly when the board is flipped over
    translate([W/2, W/2, -over]) mirror([1,0,0])
        linear_extrude(back_depth + over)
            text(back_text, size=back_size, halign="center", valign="center", font="Liberation Sans:style=Bold");
}

module tray() {
    difference() {
        union() {
            difference() {
                linear_extrude(top_rim) offset(r=3) offset(delta=-3) square(W);
                // pocket field down to floor
                translate([0,0,base]) linear_extrude(top_rim) recess_2d();
                // fixed blocks sit at tile-top height, not rim height
                translate([0,0,top_tiles]) linear_extrude(top_rim) for (b=fixed_blocks) fixed_block_2d(b);
            }
            posts();
        }
        finder_inlays(0.01);
        labels();
        back_label(0.01);
    }
}

if (part == "light") tray(); else { finder_inlays(); back_label(); }
