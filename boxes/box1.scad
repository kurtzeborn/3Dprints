$fn=80;
length = 20; width = 16; height = 10; s_arch_width=4.25; e_arch_width=5;
difference() {
	union() {
		// main box
		linear_extrude(height) square([length,width], center=true);
		// lower molding block
		linear_extrude(2) square([length+2,width+2], center=true);
	}
	// inner cavity
	translate([0,0,.5]) linear_extrude(height) square([length-2.5,width-2.5], center=true);

	// lower molding curve
	translate([-12,-9.3,2]) rotate([0,90,0]) linear_extrude(length+4) circle(1.3);
	translate([-12,9.3,2]) rotate([0,90,0]) linear_extrude(length+4) circle(1.3);
	translate([-11.3,10,2]) rotate([90,0,0]) linear_extrude(width+4) circle(1.3);
	translate([11.3,10,2]) rotate([90,0,0]) linear_extrude(width+4) circle(1.3);

	// side arch cutouts
	translate([6,width/2,0]) side_arch();
	translate([-6,width/2,0]) side_arch();
	translate([0,width/2,0]) side_arch();
	translate([6,-width/2,0]) side_arch();
	translate([-6,-width/2,0]) side_arch();
	translate([0,-width/2,0]) side_arch();

	// end arch cutouts
	translate([length/2,3.5,0]) end_arch();
	translate([length/2,-3.5,0]) end_arch();
	translate([-length/2,3.5,0]) end_arch();
	translate([-length/2,-3.5,0]) end_arch();

	// bevel for lid
//	translate([0,0,5.4]) scale([1.25,1,1]) rotate(45) cylinder(height-3,width*.1,width,$fn=4);
	translate([0,0,height-2.9])
	difference() {
		linear_extrude(3) square([length, width], center=true);
		translate([length/2,width/2,0]) rotate([90,-77,0]) scale([2,1,1])linear_extrude(width) circle(1.6);
		translate([-length/2,width/2,0]) rotate([90,77,0]) scale([2,1,1]) linear_extrude(width) circle(1.6);
		translate([-length/2,width/2,0]) rotate([0,90,0]) rotate([0,0,-13]) scale([2,1,1]) linear_extrude(length) circle(1.6);
		translate([-length/2,-width/2,0]) rotate([0,90,0]) rotate([0,0,13]) scale([2,1,1]) linear_extrude(length) circle(1.6);
	}
}

// bubbles
translate([s_arch_width/2+.875,width/2,height-1]) scale([1.5,1,1.5]) sphere(.4);
translate([-(s_arch_width/2+.875),width/2,height-1]) scale([1.5,1,1.5]) sphere(.4);
translate([s_arch_width/2+.875,-width/2,height-1]) scale([1.5,1,1.5]) sphere(.4);
translate([-(s_arch_width/2+.875),-width/2,height-1]) scale([1.5,1,1.5]) sphere(.4);
translate([length/2,0,height-1]) scale([1,1.5,1.5]) sphere(.4);
translate([-length/2,0,height-1]) scale([1,1.5,1.5]) sphere(.4);

// corners
translate([(length-.3)/2,(width-.3)/2,0]) corner();
translate([-(length-.3)/2,(width-.3)/2,0]) corner();
translate([-(length-.3)/2,-(width-.3)/2,0]) corner();
translate([(length-.3)/2,-(width-.3)/2,0]) corner();

module corner() {
	for (i = [0:0.35:height-2.5]){
		translate([0,0,2.25+i]) scale([1,1,.5]) sphere(.35);
	}
}

module side_arch() {
	translate([-s_arch_width/2,-.5,7])
	rotate([-90,0,0])
	union() {
		translate([s_arch_width/2,0,0]) linear_extrude(1) circle(s_arch_width/2);
		linear_extrude(1) square([s_arch_width,5]);
	};
}

module end_arch() {
	translate([.5,-e_arch_width/2,6.25])
	rotate([-90,0,90])
	union() {
		translate([e_arch_width/2,0,0]) linear_extrude(1) circle(e_arch_width/2);
		linear_extrude(1) square([e_arch_width,4.25]);
	};
}
