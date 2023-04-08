box=0;
lid=1;

size=30;
feature_count=23;

if (box == 1)
{
	translate([0,0,size*.88])
	union()
	{
		// inner petals
		for(i=[0:360/5:360]) {
			rotate([0,0,i]) petal();
		}

		// outer petals
		for(i=[36:360/5:396]) {
			rotate([0,0,i]) translate([-size*.15,0,size*.1]) petal();
		}

		// inner sphere
		difference()
		{
			inner_sphere();
			brim();
		}
	}

	// base, stem
	rotate_extrude($fn=80) base_template();
}

if (lid == 1)
{
	translate([0,0,size*.88])
		union() {
			difference()
			{
				union()
				{
					translate([0,0,size*1.2]) scale ([1,1,.6]) sphere(size*.96, $fn=150);
					// handle
					translate([-size*.05,0,size*1.8]) scale([2,3,2]) 
					difference()
					{
						rotate([0,90,0]) cylinder(size*.1,size*.1,size*.1, $fn=50);
						scale([.4,1,1]) sphere(size*.085, $fn=50);
						translate([size*.1,0,0]) scale([.4,1,1]) sphere(size*.085, $fn=50);
					}
				}
				// slits
				for(i=[0:360/feature_count:360])
				{
					rotate([0,0,i]) translate([-size*2.2,0,size*1.5]) rotate([0,75,0]) scale([.5,.1,2]) sphere(size, $fn=50);
				}
				inner_sphere();
				translate([0,0,size*.4]) cylinder(size*1.25, size*1.77, size*.15, $fn=50);

			}

			// brim
			difference()
			{
				brim();
				translate([0,0,size*2+size*.236]) cube(size*2, center=true);
			}
		}
		
		
}


module brim()
{
	translate([0,0,size*1.1])
		rotate_extrude($fn=100)
		translate([size*.825,0,0])
			difference() 
				{
					square(size*.15);
					translate([size*.07,0,0]) rotate([0,0,-25]) square(size*.5);
				}
}

module inner_sphere()
{
	difference()
	{
		translate([0,0,size*1.235]) scale([1,1,1.1]) sphere(size, $fn=100);
		translate([0,0,size*2+size*.235]) cube(size*2, center=true);
		translate([0,0,size*1.235]) scale([.87,.87,.97]) sphere(size, $fn=100);
	}
}

module base_template() {
	difference()
	{
		square([size*.7,size*1.15]);
		translate([size*.94,size*.67,0]) scale([1.3,1.24,1]) circle(size*.5, $fn=200);
	}
	translate([size*.7, size*.055,0]) scale([.7,1,1]) circle(size*.055, $fn=50);
}

module petal() {
	translate([-size*.6, 0, size])
	intersection() {
		difference() {
			translate([-size*.15,0,0]) rotate([0,55,0]) scale ([4,2,1]) sphere(size*.3, $fn=100);
			translate([0,0,size*.05]) rotate([0,60,0]) scale([3.75,2,1]) sphere(size*.3, $fn=100);
		}
			translate([-size*.05,0,size*.05]) rotate([0,60,0]) scale([3.75,2,1]) sphere(size*.32, $fn=100);
	}
}
