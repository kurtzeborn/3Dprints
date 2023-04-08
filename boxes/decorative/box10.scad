box=1;
lid=0;

size=30;
feature_count=23;

if (box==1) {
	difference() {
		union() {
			rotate_extrude($fn=150) template();
			translate([size*.36,size*.36,0]) rotate_extrude($fn=150) short_template();
			translate([size*.36,-size*.36,0]) rotate_extrude($fn=150) short_template();
		}
		cavity();
	}
}

if (lid==1) {
	difference() {
		union() {
			translate([0,0,size*.8]) difference() {
				scale([1,1,.5]) sphere(size*.46, $fn=150);
				translate([0,0,-size]) cylinder(size, size*.5, size*.5);
			}
			translate([size*.36,size*.36,size*.8]) difference() {
				scale([1,1,.6]) sphere(size*.26, $fn=150);
				translate([0,0,-size]) cylinder(size, size*.5, size*.5);
			}
			translate([size*.36,-size*.36,size*.8]) difference() {
				scale([1,1,.6]) sphere(size*.26, $fn=150);
				translate([0,0,-size]) cylinder(size, size*.5, size*.5);
			}

			// keep just the brim
			difference() {
				cavity(size*.004);
				cylinder(size*.731,size,size);
			}
		}

		// lid cavity
		hull() {
			translate([0,0, size*.975]) cylinder(size*.001, size*.06, size*.06, $fn=80);
			translate([0,0, size*.73]) cylinder(size*.001, size*.38, size*.38, $fn=80);
		}
		hull() {
			translate([size*.36,size*.36, size*.9]) cylinder(size*.001, size*.04, size*.04, $fn=80);
			translate([size*.36,size*.36, size*.73]) cylinder(size*.001, size*.18, size*.18, $fn=80);
		}
		hull() {
			translate([size*.36,-size*.36, size*.9]) cylinder(size*.001, size*.04, size*.04, $fn=80);
			translate([size*.36,-size*.36, size*.73]) cylinder(size*.001, size*.18, size*.18, $fn=80);
		}
		translate([0,0,size*.73]) rotate([90,90,45]) cylinder(size*.5, size*.15, size*.15, $fn=4);
		translate([0,0,size*.73]) rotate([-90,90,-45]) cylinder(size*.5, size*.15, size*.15, $fn=4);
	}
}

module cavity(shrink=0)
{
	hull() {
		translate([0,0, size*.8]) cylinder(size*.01, size*.42-shrink, size*.42-shrink, $fn=80);
		translate([0,0, size*.05]) cylinder(size*.01, size*.37-shrink, size*.37-shrink, $fn=80);
	}
	translate([size*.36, size*.36,0]) hull() {
		translate([0,0,size*.8]) cylinder(size*.01, size*.22-shrink, size*.22-shrink, $fn=40);
		translate([0,0,size*.05]) cylinder(size*.01, size*.19-shrink, size*.19-shrink, $fn=40);
	}
	translate([size*.36, -size*.36,0]) hull() {
		translate([0,0,size*.8]) cylinder(size*.01, size*.22-shrink, size*.22-shrink, $fn=40);
		translate([0,0,size*.05]) cylinder(size*.01, size*.19-shrink, size*.19-shrink, $fn=40);
	}
	brim();
}

module brim()
{
	translate([0,0,size*.749]) rotate_extrude($fn=100) {
		translate([size*.4125,0,0]) scale([1.1,1.2,1]) rotate([0,0,45]) square(size*.06);
	}

	translate([size*.36,size*.36,size*.749]) rotate_extrude($fn=100) {
		translate([size*.2125,0,0]) scale([1.1,1.2,1]) rotate([0,0,45]) square(size*.06);
	}

	translate([size*.36,-size*.36,size*.749]) rotate_extrude($fn=100) {
		translate([size*.2125,0,0]) scale([1.1,1.2,1]) rotate([0,0,45]) square(size*.06);
	}
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
		square([size*.7,size*.8]);
		translate([size*.4,-.1,0]) rotate([0,0,-5]) square([size*.3,size]);
	}
	translate([size*.4,size*.04,0]) scale([.75,1,1]) circle(size*.04, $fn=80);

	for(i=[.09:.695/(feature_count-1):.785]) {
		translate([size*.385+i*2.5,size*i,0]) rotate([0,0,14]) scale([1,.45,1]) circle(size*.03, $fn=60);
	}
}