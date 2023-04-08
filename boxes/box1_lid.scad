$fn=100;
length = 20; width = 16; height = 10; s_arch_width=4.25; e_arch_width=5;

difference() {
	union() {
		translate([0,0,-height+1])
		difference() {
			// start with the exact bevel shape from the box
			translate([0,0,height-2.9])
			difference() {
				linear_extrude(3) square([length, width], center=true);
				translate([length/2,width/2,0]) rotate([90,-77,0]) scale([2,1.05,1])linear_extrude(width) circle(1.6);
				translate([-length/2,width/2,0]) rotate([90,77,0]) scale([2,1.05,1]) linear_extrude(width) circle(1.6);
				translate([-length/2,width/2,0]) rotate([0,90,0]) rotate([0,0,-13]) scale([2,1.05,1]) linear_extrude(length) circle(1.6);
				translate([-length/2,-width/2,0]) rotate([0,90,0]) rotate([0,0,13]) scale([2,1.05,1]) linear_extrude(length) circle(1.6);
			}

			// remove the bottom
			linear_extrude(height-1) square([length,width], center=true);

			// remove the top
			translate([0,0,height]) linear_extrude(height/2) square([length*1.5,width*1.5], center=true);
		}

		translate([0,0,1])
		difference() {
			// main box
			linear_extrude(height/3) square([length+1,width+1], center=true);
			
			// inner cavity
			translate([0,0,1]) linear_extrude(height) square([length-3,width-3], center=true);

			// molding curve
			translate([-12,-9.3,0]) rotate([0,90,0]) scale([3,1.1,1]) linear_extrude(length+4) circle(1.3);
			translate([-12,9.3,0]) rotate([0,90,0]) scale([3,1.1,1]) linear_extrude(length+4) circle(1.3);
			translate([-11.3,10,0]) rotate([90,0,0]) scale([1.1,3,1]) linear_extrude(width+4) circle(1.3);
			translate([11.3,10,0]) rotate([90,0,0]) scale([1.1,3,1]) linear_extrude(width+4) circle(1.3);

			// arches
			translate([7,0,0]) arch();
			translate([4.2,0,0]) arch();
			translate([1.4,0,0]) arch();
			translate([-1.4,0,0]) arch();
			translate([-4.2,0,0]) arch();
			translate([-7,0,0]) arch();

			translate([0,5.2,0]) rotate(90) arch();
			translate([0,2.6,0]) rotate(90) arch();
			rotate(90) arch();
			translate([0,-2.6,0]) rotate(90) arch();
			translate([0,-5.2,0]) rotate(90) arch();
		}

		// center dome
		difference() {
			scale([1.5,1,.7])sphere(width/3);
			translate([0,0,-height+1]) linear_extrude(height) square([length+1,width+1], center=true);
		}

		// center dome rim
		translate([0,0,2])
		difference() {
			linear_extrude(.5) scale([1.5,1,.7]) circle(width/3.5);
			translate([0,0,-1]) linear_extrude(3) scale([1.5,1,.7]) circle(width/3.8);
		}
	}

	// cavity underneith (to save a little plastic)
	translate([0,0,-.375]) scale([1.4,1,1]) rotate(45) minkowski() { cylinder(2.6, width-9, width-14, $fn=4); sphere(.75);}
}

// top rim
translate([0,0,1+height/3])
difference() {
	linear_extrude(.25) square([length,width], center=true);
	translate([0,0,-1]) linear_extrude(3) square([length-.5,width-.5], center=true);
}
module arch() {
	translate([0,-(length+4)/2,1])
	rotate([-90,0,0])
	scale([.7,1.2,1])
	difference() {
		linear_extrude(length+4) circle(1.5);
		translate([0,3,-1]) linear_extrude(length+6) square([6,6], center=true);
	}
}

