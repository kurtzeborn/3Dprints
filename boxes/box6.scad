box=0; // set to 1 to render the box
lid=1; // set to 1 to render the lid

size=40;
feature_count=23;

// default resolution
$fn=25;

if (box==1)
{
	difference() {
	union() {
		rotate_extrude($fn=100) union() {
			difference() {
				square(size*.5);
				translate([size*.4,size*.3,0]) rotate([0,0,-40]) scale([.5,1.3,1]) circle(size*.2);
				translate([size*.35,-size*.01,0]) square(size*.3);
				translate([size*.34,size*.38,0]) square(size*.3);
			}
			translate([size*.28,size*.503,0]) scale([1,1.5,1]) circle(size*.1);
			translate([size*.35,size*.062,0]) scale([.3,1.23,1]) circle(size*.05);
		}

		// mickeys
		for (i=[0:360/feature_count:360]) {
			rotate([0,0,i]) translate([0,size*.363,size*.06]) rotate([90,0,0]) mickey();
			}
		}
		lid_template();
		// cuts
		for (i=[0:360/feature_count:360]) {
			rotate([0,0,i]) translate([0,size*.35,size*.35]) rotate([-33,0,0]) scale([.2,1,5]) sphere(size*.06);
		}
	}
}

if (lid==1)
{
	difference () {
		lid_template();
		cylinder(size*.55, r=size*.34);
		translate([0,0,size*.5]) cylinder(size*.3, size*.35, size*.05, $fn=50);
	}
}

module minney() {
	mickey();
	translate([-size*.003,size*.012,0]) scale([.5,1,.5]) sphere(size*.01);
	translate([size*.003,size*.012,0]) scale([.5,1,.5]) sphere(size*.01);
	translate([0,size*.015,0]) scale([1,.6,.6]) sphere(size*.008);
}

module mickey() {
		translate([-size*.014,size*.013,0]) scale([1,1,.5]) sphere(size*.01);
		translate([size*.014,size*.013,0]) scale([1,1,.5]) sphere(size*.01);
		scale([1,1,.5]) sphere(size*.015);
}

module lid_template() {
	difference() {
		union() {
			translate([-size*.25,0,size*.67]) rotate([0,90,0]) scale([.7,1,1]) roof_part(length=size*.5);
			translate([0,-size*.25,size*.67]) rotate([0,90,90]) scale([.7,1,1]) roof_part(length=size*.5);

			translate([0,0,size*.645])
				rotate_extrude($fn=100) translate([size*.32, 0, 0]) circle(r=size*.045);

			translate([0,0,size*.05]) cylinder(size*.57, size*.1, size*.355, $fn=50);
			translate([0,0,size*.605]) cylinder(size*.085, r=size*.322);
		}

		translate([0,0,size*.504]) scale([1,1,2.5])
			rotate_extrude($fn=100) translate([size*.363, 0, 0]) circle(r=size*.045);
	}
	translate([0,-size*.23,size*.73]) rotate([90,0,0]) scale([2,2,1]) minney();
	translate([0,size*.23,size*.73]) rotate([90,0,0]) scale([2,2,1]) minney();
	translate([-size*.23,0,size*.73]) rotate([0,0,90]) rotate([90,0,0]) scale([2,2,1]) mickey();
	translate([size*.23,0,size*.73]) rotate([0,0,90]) rotate([90,0,0]) scale([2,2,1]) mickey();
}


module roof_part(length) {
	difference() {
		cylinder(length, r=size*.25, $fn=4);
		translate([0,0,-size*.01])cylinder(size*.02, r=size*.22, $fn=4);
		translate([0,0,-size*.01])cylinder(size*.03, r=size*.20, $fn=4);
		translate([0,0,length-size*.01])cylinder(size*.02, r=size*.22, $fn=4);
		translate([0,0,length-size*.02])cylinder(size*.03, r=size*.20, $fn=4);
	}
}
/*
union() {
	hull() {
		translate([0, 0, height*.7]) scale([1,1,.8]) rotate_extrude() translate([size*.9, 0, 0]) circle(r=height*.25);
		translate([0, 0, height*.2]) rotate_extrude() translate([size*.2, 0, 0]) circle(r=height*.1);
	}

	hull() {
		translate([0, 0, height*.2]) rotate_extrude() translate([size*.2, 0, 0]) circle(r=height*.1);
		translate([0, 0, height*.05]) rotate_extrude() translate([size*.5, 0, 0]) circle(r=height*.05);
	}
}
*/

