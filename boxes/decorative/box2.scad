width=30;
height=40;
sides=8;
interior_angle=180-(360/sides);
inward_angle=atan((width*.35)/(height*.75));
inward_angle_bottom=120-atan((width*.35)/(height*.25));
//$fn=100;
$fn=40;

translate([0,0,width*.1])
union()
{
	difference() {
		// Core Box
		rotate(interior_angle/2)
		minkowski() {
			union()
			{
				cylinder(height*.25, width*.75, width*.65, $fn=sides);
				translate([0,0,height*.25]) cylinder(height*.75, width*.65, width, $fn=sides);
			}
			sphere(width*.1);
		}

		// Moons
		// TODO: figure out how to roll this into a loop
	//	translate([width*0,width*1,height*.6])
	//		rotate(-interior_angle*0) rotate([-inward_angle,0,0]) half_moon(size=height*.12, fullness=1/sides);
		translate([-width*.68,width*.68,height*.6])
			rotate(-interior_angle*1-180) rotate([-inward_angle,0,0]) half_moon(size=height*.12, fullness=2/sides);
	//	translate([-width*1,-width*0,height*.6])
	//		rotate(-interior_angle*2) rotate([-inward_angle,0,0]) half_moon(size=height*.12, fullness=3/sides);
		translate([-width*.68,-width*.68,height*.6])
			rotate(-interior_angle*3-180) rotate([-inward_angle,0,0]) half_moon(size=height*.12, fullness=4/sides);
	//	translate([-width*0,-width*1,height*.6])
	//		rotate(-interior_angle*4) rotate([-inward_angle,0,0]) half_moon(size=height*.12, fullness=5/sides);
		translate([width*.68,-width*.68,height*.6])
			rotate(-interior_angle*5-180) rotate([-inward_angle,0,0]) half_moon(size=height*.12, fullness=6/sides);
	//	translate([width*1,width*0,height*.6])
	//		rotate(-interior_angle*6) rotate([-inward_angle,0,0]) half_moon(size=height*.12, fullness=7/sides);
		translate([width*.68,width*.68,height*.6])
			rotate(-interior_angle*7-180) rotate([-inward_angle,0,0]) half_moon(size=height*.12, fullness=8/sides);

		// Cavity
		rotate(interior_angle/2) translate([0,0,height*.025]) cylinder(height*1.2, width*.65, width, $fn=sides);
	}

	// Stars
	translate([0,width*.72,height*.125])
		rotate(interior_angle*0)rotate([-inward_angle_bottom,0,0]) star_3d(8,height*.1, cent_h=3);
	translate([-width*.72,0,height*.125])
		rotate(interior_angle*2)rotate([inward_angle_bottom,0,0]) star_3d(8,height*.1, cent_h=3);
	translate([0,-width*.72,height*.125])
		rotate(interior_angle*4)rotate([-inward_angle_bottom,0,0]) star_3d(8,height*.1, cent_h=3);
	translate([width*.72,0,height*.125])
		rotate([0,inward_angle_bottom,0]) star_3d(8,height*.1, cent_h=3);
}

module half_moon (size=8, thickness=4, fullness=0.5) {
	rotate (a=[90,0,0])
	linear_extrude (height=thickness)
	difference () {
		circle (r=size, $fs=0.2);
		translate ([size*2*fullness,0,0])
		circle (r=size,$fs=0.2);
	}
}

// modules in library:
module star_3d(points, point_len, adjust=0, pnt_h =1, cent_h=1, rnd=0.1, fn=25)
{
    // star_3d: star with raised center.
    //----------------------------------------------//
    // points = num points on star (should be >3.  
    //          Using 3 may require addisional 
    //          adjust be applied.)
    // point_len = len of point on star 
    //              (actual len of point will add 
    //              1/2 rnd to the length.)
    // adjust = +/- adjust of width of point
    // pnt_h = height of star at end of point
    // cent_h = height of star in center needs to be > pnt_h to have effect.
    // rnd = roundness of end of point (diameter)
    // fn = $fn value for rounded point
    //----------------------------------------------//
    
    point_deg= 360/points;
    point_deg_adjusted = point_deg + (-point_deg/2) +  adjust;
    
    if(points == 3 && adjust == 0)
    {  // make a pyramid (this is to avoid rendering 
       //            issues in this special case)
        hull()
        {
           for(i=[0:2])
           {
               rotate([0,0,i*point_deg])
               translate([point_len,0,0])
                    cylinder(pnt_h, d=rnd, $fn=fn);
           }
           cylinder(cent_h, d=.001);
        }
    }
    else
    { // use algorithm
        for(i=[0:points-1])
        {
            rotate([0,0,i * point_deg]) 
                translate([0,-point_len,0]) 
                point(point_deg_adjusted, 
                      point_len, 
                      rnd, 
                      pnt_h, 
                      cent_h, 
                      fn);
        }
    }

}

module point(deg, leng, rnd, h1, h2, fn=25)
{   // create a point of the star.
    hull()
    {
        cylinder(h1, d=rnd, $fn=fn);
        translate([0,leng,0]) cylinder(h2, d=.001);
        rotate([0,0,-deg/2]) 
            translate([0,leng,0]) cylinder(h1, d=rnd);
        rotate([0,0,deg/2]) 
            translate([0,leng,0]) cylinder(h1, d=rnd);
    }
}

// points = number of points (minimum 3)
// outer  = radius to outer points
// inner  = radius to inner points
module star(points, outer, inner) {
	
	// polar to cartesian: radius/angle to x/y
	function x(r, a) = r * cos(a);
	function y(r, a) = r * sin(a);
	
	// angular width of each pie slice of the star
	increment = 360/points;
	
	union() {
		for (p = [0 : points-1]) {
			
			// outer is outer point p
			// inner is inner point following p
			// next is next outer point following p

			x_outer = x(outer, increment * p);
			y_outer = y(outer, increment * p);
			x_inner = x(inner, (increment * p) + (increment/2));
			y_inner = y(inner, (increment * p) + (increment/2));
			x_next  = x(outer, increment * (p+1));
			y_next  = y(outer, increment * (p+1));
			polygon(points = [[x_outer, y_outer], [x_inner, y_inner], [x_next, y_next], [0, 0]], paths  = [[0, 1, 2, 3]]);
		}
	}
}
