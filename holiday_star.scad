// SPDX-License-Identifier: MIT

$fa = 1;
$fs = 0.4;

module star(lpoint=14,spoint=9,npoints=4,depth=3,miniSize=0) {
	// each point is a 4 sided cone
	difference() {
		for (point=[0:npoints-1]) {
			// long point
			rotate([0,(360/npoints)*point,0]) cylinder(lpoint,depth,0,$fn=4);
			// short point
			rotate([0,(180/npoints)+(360/npoints)*point,0]) cylinder(spoint,depth,0,$fn=4);
			if (miniSize > 0) {
				rotate([0,((180/npoints)+(90/npoints))+(360/npoints)*point,0]) cylinder(miniSize,depth,0,$fn=4);
				rotate([0,((180/npoints)-(90/npoints))+(360/npoints)*point,0]) cylinder(miniSize,depth,0,$fn=4);
			}
		}
	}
}

// The star, with a flat back
module mainstar(lpoint=14, spoint=9, npoints=4, depth=3, miniSize=0, scale=1, loop=false, hollow=false, hangers=false) {

	intersection() {
		union() {
			if (hollow == true) {
				difference() {
					scale([scale, scale, scale])
						rotate([90, 0, 0]) star(spoint = 10, depth = depth);
					translate([0, 0, -1])
						scale([scale, scale, scale])
						if (scale == 1) {
							rotate([90, 0, 0]) star(spoint = 10, depth = depth - 0.05);
						}
						else {
							rotate([90, 0, 0]) star(spoint = 10, depth = depth - 1.5);
						}

				}
			}
			else {
				scale([scale, scale, scale])
				rotate([90, 0, 0])star(lpoint, spoint, npoints, depth, miniSize);
			}

			if (hangers == true) {
				if (scale == 3) {
					s = scale*0.15;
					translate([((scale * 2.5)), (((scale * 3.75) + (s / 2)) - 0.001), (scale * 0.15)])
						scale([s, s, s])
							rotate([90, 0, 0])rotate([90, 0, 0])
								rotate_extrude(convexity = 10, $fn = 100)
									translate([4, 0, 0]) circle(r = 1, $fn = 4);
					translate([(-(scale * 2.5)), (((scale * 3.75) + (s / 2)) - 0.001), (scale * 0.15)])
						scale([s, s, s])
							rotate([90, 0, 0])rotate([90, 0, 0])
								rotate_extrude(convexity = 10, $fn = 100)
									translate([4, 0, 0]) circle(r = 1, $fn = 4);
					translate([((scale * 2.5)), ((-(scale * 3.75) - (s / 2)) - 0.001), (scale * 0.15)])
						scale([s, s, s])
							rotate([90, 0, 0])rotate([90, 0, 0])
								rotate_extrude(convexity = 10, $fn = 100)
									translate([4, 0, 0]) circle(r = 1, $fn = 4);
					translate([(-(scale * 2.5)), ((-(scale * 3.75) - (s / 2)) - 0.001), (scale * 0.15)])
						scale([s, s, s])
							rotate([90, 0, 0])rotate([90, 0, 0])
								rotate_extrude(convexity = 10, $fn = 100)
									translate([4, 0, 0]) circle(r = 1, $fn = 4);
				}
				else {
					s = scale * 0.15;
					translate([((scale * 2.5)), (((scale * 3.75) + s) - 0.001), (scale * 0.15)])
						scale([s, s, s])
							rotate([90, 0, 0])rotate([90, 0, 0])
								rotate_extrude(convexity = 10, $fn = 100)
									translate([4, 0, 0]) circle(r = 1, $fn = 4);
					translate([(-(scale * 2.5)), (((scale * 3.75) + s) - 0.001), (scale * 0.15)])
						scale([s, s, s])
							rotate([90, 0, 0])rotate([90, 0, 0])
								rotate_extrude(convexity = 10, $fn = 100)
									translate([4, 0, 0]) circle(r = 1, $fn = 4);
					translate([((scale * 2.5)), ((-(scale * 3.75) - s) - 0.001), (scale * 0.15)])
						scale([s, s, s])
							rotate([90, 0, 0])rotate([90, 0, 0])
								rotate_extrude(convexity = 10, $fn = 100)
									translate([4, 0, 0]) circle(r = 1, $fn = 4);
					translate([(-(scale * 2.5)), ((-(scale * 3.75) - s) - 0.001), (scale * 0.15)])
						scale([s, s, s])
							rotate([90, 0, 0])rotate([90, 0, 0])
								rotate_extrude(convexity = 10, $fn = 100)
									translate([4, 0, 0]) circle(r = 1, $fn = 4);
				}
			}

			//If you're building a star to hang from the tree, add a loop at the top
			if (loop == true) {
				var_scale = (scale/2);
				scale([var_scale, var_scale, var_scale])
					translate([0, -31, 0])
						rotate([90, 0, 0])rotate([90, 0, 0])
							rotate_extrude(convexity = 10, $fn = 100)
								translate([4, 0, 0]) circle(r = 1, $fn = 4);
			}
		}
		scale([scale, scale, scale])
			translate([0, 0, 50])cube([150, 150, 100], center = true);
	}
}

// Build the star
scale=9;
hollow=true;
hangers=false;
magnets=false;
difference() {
	mainstar(depth=4, scale=scale, hollow=hollow, hangers=hangers);

	// Insets for magnets
	if (magnets == true) {
		translate([scale*2.10, scale*4.6, 0])
			color("purple")cylinder(d=6, h=1);
		translate([scale*2.10, -(scale*4.6), 0])
			color("orange")cylinder(d=6, h=1);
		translate([-(scale*2.10), scale*4.6, 0])
			color("green")cylinder(d=6, h=1);
		translate([-(scale*2.10), -(scale*4.6), 0])
			color("blue")cylinder(d=6, h=1);
	}

}




