box=0;
lid=1;
size=30;

$fn=60;

if (box==1) {
difference() {
		union() {
			difference() {
				union() {
					translate([-size*.5,-size*.5,0]) cube([size,size,size*.8]);
					for(i=[0:360/4:360]) {
						rotate([0,0,i]) translate([size*.45, size*.45,0]) cylinder(size*.8,size*.08,size*.08);
					}
				}

				// side cutouts
				for (i=[0:360/4:360]) {
					rotate([0,0,i]) translate([-size*.35,size*.55,size*.15]) minkowski() { cube([size*.7, size*.05, size*.5]); sphere(size*.1); }
				}

				// bottom corners
				for (i=[0:360/4:360]) {
					rotate([0,0,i]) translate([size*.075,size*.075,-size*.5]) rotate([45, 45, 45]) cube(size);
				}

				// top corners
				for (i=[0:360/4:360]) {
					rotate([0,0,i]) translate([-size*1.285,-size*1.285,size]) rotate([45, 45, 45]) cube(size);
				}
			}

			// mickeys and minneys
			translate([0,size*.45,size*.35]) rotate([90,0,0]) minney();
			translate([0,-size*.45,size*.35]) rotate([90,0,0]) minney();
			translate([size*.45,0,size*.35]) rotate([90,0,90]) mickey();
			translate([-size*.45,0,size*.35]) rotate([90,0,90]) mickey();
		}
		cavity(box);
	}
}

if (lid==1) {
	difference() {
		union() {
			hull () {
				translate([-size*.05,-size*.05,size*1.15]) cube([size*.1, size*.1, size*.01]);
				lid_edge();
			}
			translate([0,0,size*1.2]) sphere(size*.1, $fn=150);
			cavity();
		}

		translate([0,0,-size*.01]) hull() {
			translate([-size*.025,-size*.025,size*1.1]) cube([size*.05, size*.05, size*.01]);
			translate([-size*.375,-size*.375,size*.02]) cube([size*.75,size*.75,size*.8]);
		}
	}
}

module cavity(box) {
	hull () {
		lid_edge();
		translate([-size*.4,-size*.4,size*.72]) cube([size*.8,size*.8,size*.01]);
	}
	if (box==1) translate([-size*.4,-size*.4,size*.04]) cube([size*.8,size*.8,size*.8]);
}

module lid_edge() {
	difference() {
		translate([-size*.5,-size*.5,size*.8]) cube([size, size, size*.01]);
		for (i=[0:360/4:360]) {
			rotate([0,0,i]) translate([-size*1.285,-size*1.285,size]) rotate([45, 45, 45]) cube(size);
		}
	}
}

module minney() {
	mickey();
	translate([-size*.03,size*.12,0]) scale([.5,1,.5]) sphere(size*.1);
	translate([size*.03,size*.12,0]) scale([.5,1,.5]) sphere(size*.1);
	translate([0,size*.15,0]) scale([1,.6,.6]) sphere(size*.08);
}

module mickey() {
		translate([-size*.14,size*.13,0]) scale([1,1,.5]) sphere(size*.1, $fn=100);
		translate([size*.14,size*.13,0]) scale([1,1,.5]) sphere(size*.1, $fn=100);
		scale([1,1,.5]) sphere(size*.15, $fn=100);
}
