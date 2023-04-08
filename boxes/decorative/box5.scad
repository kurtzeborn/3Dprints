box=0; // set to 1 to render the box
lid=1; // set to 1 to render the lid
feature_count=23; // can safely be changed to any number greater than 3 and less than 40

// less safe to change, but maybe?
height=50;
width=25;

// default resolution
$fn=30;

// box
if (box==1) {
	difference () { // cavity removal
		union () { // body and base
			difference () { // divot removal
				// body
				hull () {
					translate([0, 0, height*.7]) rotate_extrude($fn=200) translate([width, 0, 0]) circle(r=height*.05);
					translate([0, 0, height*.2]) cylinder(height*.2,width*.2,width*.2);
				}

				// divots
				for (i = [0:360/feature_count:360]) {
					rotate([0,0,i]) translate([width*.38,0,height*.2]) rotate([0,40,0]) rotate([0,0,45])
						cube([width*.2, width*.2, height*2], center=true);
				}
			}

			// base
			cylinder(height*.21, width*.5, width*.2, $fn=150); // main cylinder
			cylinder(height*.025, width*.5, width*.5, $fn=150); // lower rim

			// dimples
			for (i = [0:360/feature_count:360]) {
				rotate([0,0,i]) translate([width*.34,0,height*.1]) rotate([0,-34,0]) scale([.7,.7,6]) sphere(width*.04, $fn=50);
			}
		}

		// cavity
		lid_template();
	}
}

if (lid==1) {
	difference() {
		union() {
			lid_template(lid);

			// ribs
			for (i = [0:360/feature_count:360]) {
				rotate([0,0,i]) translate([width*.497,0,height*.935]) rotate([0,-41,0]) rotate([0,0,45])
					cube([width*.2, width*.2, height*.61], center=true);
			}

			// nob
				translate([0,0,height*1.25]) sphere(width*.25, $fn=100);

			// nob dimples
			for (i = [0:360/feature_count:360]) {
				rotate([0,0,i]) translate([width*.2,0,height*1.28]) rotate([0,-15,0])
					scale([3,1,6]) sphere(width*.02, $fn=50);
			}

		}

		// lid cavity
		translate([0,0,height*.25]) scale([.83,.83,1.35]) sphere(width*1.25, $fn=80);
		translate([0,0,height*.625]) cylinder(height*.05,width*1.5,width*1.5);
	}
	
}

// this module is used to render both the box cavity and the lid
module lid_template(lid=0)
{
	// lid body
	intersection() {
		translate([0,0,height*.25]) cylinder(height*.85, width*1.95, width*.34, $fn=150);
		translate([0,0,height*.25]) cylinder(height*1.15, width*.16, width*2.1, $fn=80);
	}

	// rim
	if (lid==1) {
		translate([0,0,height*.68]) rotate_extrude($fn=200) translate([width*.87, 0, 0]) square(height*.035);
	}
	else {
		translate([0,0,height*.68]) rotate_extrude($fn=200) translate([width*.88, 0, 0]) square(height*.035);
	}

	// lower box cavity
	translate([0,0,height*.3]) scale([1,1,3]) sphere(width*.16, $fn=50);
}
