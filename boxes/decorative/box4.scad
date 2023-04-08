lid=0; // set to 1 to render just the lid
box=1; // set to 1 to render just the box

side=50;
height=90;
base_h=height*.13;
center_r=side*.1;
topper_r=center_r*1.3;
topper_h=height*.08;

difference() { // for removing cavity
union() { // for adding back inner lip to lid
difference() { // for splitting box and lid

//
// full box
//
union() {
	
	// topper
	translate ([0,0,height*.5+topper_h])
	difference () {
		sphere(topper_r, $fn=80);
		translate([0,0,-topper_r]) cube(topper_r*2, center=true);
	}
	translate([0,0,height*.5+topper_h*.5]) cylinder(h=topper_h, r1=center_r, r2=topper_r, center=true, $fn=50);

	// body
	difference () {
		hull() {
			translate([0,0,height*.1])
			minkowski () {
				cube([side,side,height*.33], center=true);
				sphere(r=side*.1, $fn=50);
			}
			cylinder(r=center_r,h=height, center=true, $fn=30);
		}

		// hearts (hacky offset guesses)
		translate([0,side*.71,side*.16]) rotate([90,0,0]) scale([.6,.6,.6]) heart();
		translate([0,-side*.59,side*.16]) rotate([90,0,0]) scale([.6,.6,.6]) heart();
		translate([-side*.71,0,side*.16]) rotate([90,0,90]) scale([.6,.6,.6]) heart();
		translate([side*.59,0,side*.16]) rotate([90,0,90]) scale([.6,.6,.6]) heart();
	}

	// center column joining it all together (to guarantee no small gaps between topper or base when slicing)
	cylinder(r=center_r,h=height+min(base_h,topper_h), center=true, $fn=30);

	if(lid==0) {
		// base
		rotate([0,0,45])
		hull() {
			translate ([0,0,-height*.5-base_h*.5]) cylinder(r=center_r,h=base_h, center=true, $fn=30);
			translate ([0,0,-height*.5-base_h]) cylinder(base_h*.5, side*.5, side*.4, center=true, $fn=4);
		}
	}
}

// chop off top or bottom
if (lid == 1)
{
	translate([0,0,-height*.25]) cube([side*1.5, side*1.5, height], center=true);
}
if (box == 1)
{
	translate([0,0,height*.75]) cube([side*1.5, side*1.5, height], center=true);
}
} // end difference() for splitting box and lid

if (lid == 1) {
	// add inner lip to lid
	hull() {
		translate([0,0,height*.25])
		minkowski () {
			cube([side,side,height*.03], center=true);
			sphere(r=side*.05, $fn=50);
		}

		translate([0,0,height*.25])
		difference() {
		minkowski () {
			cube([side,side,height*.03], center=true);
			sphere(r=side*.1, $fn=50);
		}
		translate([0,0,-height*.05]) cube([side*1.3,side*1.3,height*.1], center=true);
		}
	}
}

} // end union for adding back inner lip on lid

// make room for inner lip in box
if (box == 1) {
	hull() {
		translate([0,0,height*.25])
		minkowski () {
			cube([side,side,height*.03], center=true);
			sphere(r=side*.05, $fn=50);
		}

		translate([0,0,height*.25])
		difference() {
		minkowski () {
			cube([side,side,height*.03], center=true);
			sphere(r=side*.1, $fn=50);
		}
		translate([0,0,-height*.05]) cube([side*1.3,side*1.3,height*.1], center=true);
		}
	}
}

if (lid == 1 || box == 1) {
	// remove inner cavity
	hull() {
		translate([0,0,height*.1]) 
		cube([side,side,height*.33], center=true);
		cylinder(r=center_r,h=height*.95, center=true, $fn=30);
	}
}

} // end difference for removing cavity

//
// MODULES
//
module heart() {
	n = 100;
	h = 10;
	step = 360/n;
	points = [ for (t=[0:step:359.999]) [16*pow(sin(t),3), 13*cos(t) - 5*cos(2*t) - 2*cos(3*t) - cos(4*t)]];
	linear_extrude(height=h) polygon(points);
}