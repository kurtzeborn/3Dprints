width=50;
height=40;
wall=3;

difference() {
	// Full box
	union() {
		
		// Base box
		translate([0,0,height/2]) cube([width,width,height], center=true);

		// Diamond designs
		translate([width/2,0,height/2]) rotate([0,90,0]) diamond(height*.2, sides=4);
		translate([width/2,0,height/2]) rotate([0,90,0]) diamond(height*.4, sides=4);
		translate([0,-width/2,height/2]) rotate([90,90,0]) diamond(height*.2, sides=4);
		translate([0,-width/2,height/2]) rotate([90,90,0]) diamond(height*.4, sides=4);
		translate([-width/2,0,height/2]) rotate([0,90,0]) diamond(height*.2, sides=4);
		translate([-width/2,0,height/2]) rotate([0,90,0]) diamond(height*.4, sides=4);
		translate([0,width/2,height/2]) rotate([90,90,0]) diamond(height*.2, sides=4);
		translate([0,width/2,height/2]) rotate([90,90,0]) diamond(height*.4, sides=4);

		// Corners
		translate ([width*.48,width*.48,0]) cylinder(height, width*.05, width*.05, $fn=50);
		translate ([-width*.48,width*.48,0]) cylinder(height, width*.05, width*.05, $fn=50);
		translate ([width*.48,-width*.48,0]) cylinder(height, width*.05, width*.05, $fn=50);
		translate ([-width*.48,-width*.48,0]) cylinder(height, width*.05, width*.05, $fn=50);

		// Roof
		translate([0,0,-height*.42])
		scale([1,1,1.4])
		intersection() {
			translate([0,width,height]) rotate([90,0,0]) cylinder(width*3, width/2, width/2, $fn=200);
			translate([-width,0,height]) rotate([90,0,90]) cylinder(width*3, width/2, width/2, $fn=200);
		}

		// Ridges
		translate([0,0,height*1.685]) rotate([0,0,45]) diamond(width*.4);
		translate([0,0,height*1.395]) rotate([0,0,45]) diamond(width*.6);

		// Topper
		intersection() {
			translate([0,width,height*2]) rotate([90,0,0]) cylinder(width*3, width/10, width/10, $fn=100);
			translate([-width,0,height*2]) rotate([90,0,90]) cylinder(width*3, width/10, width/10, $fn=100);
		}

		//arches
		translate ([0,0,height])
		difference() {
			union() {
				rotate([90,0,45]) rotate_extrude($fn = 500) translate([width*.6788, 0, 0]) circle(r=width*.05, $fn=50);
				rotate([90,0,-45]) rotate_extrude($fn = 500) translate([width*.6788, 0, 0]) circle(r=width*.05, $fn=50);
			}
			translate([0,0,-height]) cube([width*2,width*2,height*2], center=true);
		}
	}

	// delete box
	translate([0,0,height*.499]) cube([width*1.2, width*1.2, height], center=true);

	// inner bevel
	translate ([width/2+wall+width*.01,width,height*.95]) scale([1,1,1.5]) rotate([90,0,0]) cylinder(width*2, width*.1, width*.1, $fn=100);
	translate ([-(width/2+wall+width*.01),width,height*.95]) scale([1,1,1.5]) rotate([90,0,0]) cylinder(width*2, width*.1, width*.1, $fn=100);
	translate ([-width,width/2+wall+width*.01,height*.95]) scale([1,1,1.5]) rotate([90,0,90]) cylinder(width*2, width*.1, width*.1, $fn=100);
	translate ([width,-(width/2+wall+width*.01),height*.95]) scale([1,1,1.5]) rotate([90,0,-90]) cylinder(width*2, width*.1, width*.1, $fn=100);

	// cavity
	translate([0,0,-(height*.45+wall*3)])
	scale([1,1,1.6])
	intersection() {
			translate([0,width,height]) rotate([90,0,0]) cylinder(width*3, width*.44, width*.44, $fn=200);
			translate([-width,0,height]) rotate([90,0,90]) cylinder(width*3, width*.44, width*.44, $fn=200);
	}
}

module diamond (size=height*.25, sides=4) {
	rotate_extrude($fn = sides) translate([size, 0, 0]) circle(r=width*.05, $fn=50);
}