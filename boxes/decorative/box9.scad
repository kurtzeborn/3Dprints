box=0;
lid=1;

size=50;


if (box==1) {
	difference() {
		box_template();
		hull () {
			translate([0,0,size*.08]) lid_bottom_edge(size*.05, size*.3, size*.2);
			translate([0,0,size*.85]) lid_bottom_edge(size*.17, size*.47, size*.38);
		}
	}
}

if (lid==1) {
	difference() {
		union() {
			hull() {
				// lid top edge
				translate([0,0,size*1.5]) cylinder(size*.01, size*.1, size*.1, $fn=60);

				// lid bottom edge
				translate([0,0,size*.85]) lid_bottom_edge(size*.2, size*.5, size*.4);
			}
			// petals
			for (i=[0:360/10:360]) {
				rotate([0,0,i]) translate([size*.13,0,size*1.55]) rotate([11,20,0]) scale([.5,1,3.25]) sphere(size*.05, $fn=60);
			}
			for (i=[0:360/13:360]) {
				rotate([0,0,i]) translate([size*.165,0,size*1.5]) rotate([-11,30,0]) scale([.5,1,3.25]) sphere(size*.05, $fn=60);
			}
			translate([0,0,size*1.5]) sphere(size*.1, $fn=50);
			}
		box_template();
		hull () {
			translate([0,0,size*1.4]) cylinder(size*.01, size*.08, size*.08);
			translate([0,0,size*.84]) lid_bottom_edge(size*.2, size*.5, size*.29, thickness=size*.01);
		}
	}
}

module lid_bottom_edge(width, length, radius, thickness=size*.1) {
	hull() {
		translate([width, length, 0]) cylinder(thickness, radius, radius, $fn=80);
		translate([-width, length, 0]) cylinder(thickness, radius, radius, $fn=80);
		translate([width, -length, 0]) cylinder(thickness, radius, radius, $fn=80);
		translate([-width, -length, 0]) cylinder(thickness, radius, radius, $fn=80);
	}
}

module box_template() {
	// sides
	rotate([90,0,0]) translate([0,0,-size*.5]) linear_extrude(size) template();
	rotate([90,0,180]) translate([0,0,-size*.5]) linear_extrude(size) template();
	translate([0,size*.3,0]) rotate([90,0,90]) translate([0,0,-size*.2]) linear_extrude(size*.4) template();
	translate([0,-size*.3,0]) rotate([90,0,-90]) translate([0,0,-size*.2]) linear_extrude(size*.4) template();

	// corners
	translate([size*.2, size*.5,0]) rotate_extrude(angle=90, $fn=150) short_template();
	translate([-size*.2, size*.5,0]) rotate([0,0,90]) rotate_extrude(angle=90, $fn=150) short_template();
	translate([size*.2, -size*.5,0]) rotate([0,0,-90]) rotate_extrude(angle=90, $fn=150) short_template();
	translate([-size*.2, -size*.5,0]) rotate([0,0,180]) rotate_extrude(angle=90, $fn=150) short_template();
}


module short_template()
{
	difference() {
		translate([-size*.2,0,0]) template();
		translate([-size*.5,-size*.01,0]) square([size*.5,size*.82]);
	}
}

module template() {
	difference(){
		square([size,size*.8]);
		translate([size*.9,0,0]) scale([1,2,1]) circle(size*.5, $fn=300);
		translate([size*.32,-size*.001,0]) square([size*.13,size*.25]);
	}
	translate([size*.465, size*.8, 0]) rotate([0,0,-45]) scale([1,2,1]) square(size*.1);
	translate([size*.323, size*.4,0]) scale([1,4,1]) circle(size*.1, $fn=300);
}