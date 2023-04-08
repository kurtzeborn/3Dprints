width=30;
height=40;
sides=8;
interior_angle=180-(360/sides);
inward_angle=atan((width*.35)/(height*.75));
inward_angle_bottom=120-atan((width*.35)/(height*.25));
$fn=20;

difference()
{
	union() {
		translate([0,0,-height*.95])
		difference()
		{
			// Start with the exact Cavity of the box
			rotate(interior_angle/2) translate([0,0,height*.025]) cylinder(height*1.2, width*.65, width, $fn=sides);

			// Remove the top
			translate([0,0,height+width*.1]) linear_extrude(height) square([width*2.5,width*2.5], center=true);

			// Remove the rest below
			linear_extrude(height*.95) square([width*2.5,width*2.5], center=true);
		}

		// Sun
		translate([0,0,width*.1]) sphere(width*.55, $fn=200);

		// Sun rays
		minkowski()
		{
			rotate(22.5)
			union() {
				pathRadius=width*.55;
				num=8;
				for (i=[1:num])  {
					translate([pathRadius*cos(i*(360/num)),pathRadius*sin(i*(360/num)),0]) 
						rotate(i*(360/num)) scale([1,.5,1]) cylinder(width*.25, width*.3, width*.3, $fn=3);
				}
			}
			sphere(width*.03);
		}
	}

	// Remove the excess below
	translate([0,0,-height*.95]) linear_extrude(height*.95) square([width*2.5,width*2.5], center=true);

	// Create a cavity to save some plastic
	translate([0,0,-.01]) rotate(interior_angle/2) cylinder(height*.325, width*.7, width*.15, $fn=sides);
}


