box=0;
lid=1;

size=25;
$fn=150;

// box
if (box==1) {
	difference() {
		union() {
			rotate([90,0,0]) linear_extrude(size*.4,center=true) template();
			rotate([90,0,180]) linear_extrude(size*.4,center=true) template();
			translate([0,size*.2,0]) rotate_extrude(angle=180) template();
			translate([0,-size*.2,0]) rotate([0,0,180]) rotate_extrude(angle=180) template();
		}
		cavity();
	}
}

// lid
if (lid==1) {
	difference() {
		union() {
			difference() {
				scale ([1,1,.88]) union() {
					translate([0,0,size*.8]) rotate([90,0,0]) cylinder(size*.4, size*.45, size*.45, center=true);
					translate([0,size*.2,size*.8]) sphere(size*.45);
					translate([0,-size*.2,size*.8]) sphere(size*.45);
				}
				translate([-size*.5,-size*.65,0]) cube([size,size*1.3, size*.805]); // chop off the bottom half
			}
			// handle
			translate([-size*.05,0,size*1.09]) scale([1,1.5,1]) difference() {
				rotate([0,90,0]) cylinder(size*.1,size*.1,size*.1);
				scale([.4,1,1]) sphere(size*.085);
				translate([size*.1,0,0]) scale([.4,1,1]) sphere(size*.085);
			}

			// keep the bottom lip of the cavity part
			difference() {
				cavity();
				translate([-size*.5,-size*.65,0]) cube([size,size*1.3, size*.74]); // chop off the bottom
			}
		}

		// now clear out the inside of the lid
		translate([0,0,size*.7]) hull() {
			translate([0,size*.2,0]) cylinder(size*.38, size*.38, size*.06);
			translate([0,-size*.2,0]) cylinder(size*.38, size*.38, size*.06);
		}
	}
}


module cavity() {
	translate([0,0,size*.05]) hull() {
		translate([0,size*.2,0]) cylinder(size*.8, size*.23, size*.38);
		translate([0,-size*.2,0]) cylinder(size*.8, size*.23, size*.38);
	}
	translate([0,0,size*.6551]) hull() {
		translate([0,size*.2,0]) cylinder(size*.15, size*.23, size*.435);
		translate([0,-size*.2,0]) cylinder(size*.15, size*.23, size*.435);
	}
	translate([0,0,size*.6551]) hull() {
		translate([0,size*.2,0]) cylinder(size*.15, size*.32, size*.415);
		translate([0,-size*.2,0]) cylinder(size*.15, size*.32, size*.415);
	}
}

module template() {
	difference() { 
		union() { 
			difference() {
				square([size*.4,size*.8]);
				translate([size*.42,size*.197,0]) circle(size*.1);
				translate([size*.42,size*.35,0]) rotate([0,0,-10]) scale([.8,1.2,1]) circle(size*.1);
			}
			translate([size*.39, size*.05,0]) circle(size*.05);
			translate([size*.39, size*.515,0]) rotate([0,0,-18]) scale([.8,1.3,1]) circle(size*.05);
			translate([size*.3, size*.575,0]) square([size*.14,size*.23]);
		}
		translate([size*.46, size*.7,0]) rotate([0,0,-15]) scale([1,1.92,1]) circle(size*.07);
		translate([size*.45, size*.01,0]) scale([1,1.4,1]) circle(size*.05);
	}
}