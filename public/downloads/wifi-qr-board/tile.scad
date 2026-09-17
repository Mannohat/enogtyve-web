// WiFi QR puzzle board — 2x2-module tile
// Orientation: +y is "up" (toward the letter row on the board), clipped corner at top-left.
// Bit weights: TL=8, TR=4, BL=2, BR=1

id        = 0;        // 0..15, which pattern
part      = "light";  // "light" (body) or "dark" (inlay)

m         = 3.5;      // module size
tile      = 2*m;      // 7 mm
h         = 2.0;      // tile thickness
inlay     = 0.6;      // depth of dark inlay from top face
clip      = 2.0;      // clipped corner leg length
dot_d     = 0.8;      // orientation dot diameter
dot_depth = 0.3;
chamfer   = 0.3;      // bottom edge chamfer for easy seating
text_depth= 0.4;      // dark inlay on the back (first two layers)
text_size = 3.6;

$fn = 24;

module outline2d() {
    difference() {
        square(tile, center=true);
        // clip top-left corner
        translate([-tile/2, tile/2]) polygon([[0,0],[clip,0],[0,-clip]]);
    }
}

module body() {
    hull() {
        linear_extrude(0.01) offset(delta=-chamfer) outline2d();
        translate([0,0,chamfer]) linear_extrude(h-chamfer) outline2d();
    }
}

// quadrant q: 0=TL 1=TR 2=BL 3=BR
function qx(q) = (q==0||q==2) ? -m/2 : m/2;
function qy(q) = (q<2) ? m/2 : -m/2;
function bit(q) = [8,4,2,1][q];
function set(q) = floor(id / bit(q)) % 2 == 1;

module inlay_block(q, over=0) {
    translate([qx(q), qy(q), h - inlay])
        linear_extrude(inlay + over) intersection() {
            translate([qx(q)*-1, qy(q)*-1]) outline2d();   // keep clipped corner
            square(m, center=true);
        }
}

module inlays(over=0) { for (q=[0:3]) if (set(q)) inlay_block(q, over); }

module dot() {
    translate([-tile/2 + 2.2, tile/2 - 2.2, h - dot_depth])
        cylinder(d=dot_d, h=dot_depth + 0.01);
}

module back_id(over=0) {
    // dark inlay on the back, mirrored so it reads correctly when the tile is flipped over
    translate([0,0,-over]) mirror([1,0,0])
        linear_extrude(text_depth + over)
            text(str(["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"][id]),
                 size=text_size, halign="center", valign="center", font="Liberation Sans:style=Bold");
}

if (part == "light") {
    difference() {
        body();
        inlays(0.01);
        dot();
        back_id(0.01);
    }
} else {
    difference() {
        inlays();
        dot();
    }
    back_id();
}
