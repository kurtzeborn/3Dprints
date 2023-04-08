box=0;
lid=1;

size=50;
feature_count=23;
$fn=50;

//hinges(false);
//hinge();
//lock();

if (box)
{
	difference()
	{
		box_frame();
		box_cutouts();
		box_woodgrain();
		box_nick();
	}
	lock();
	box_rivets();
}

if (lid)
{
	difference()
	{
		lid_frame();
		lock(lid_delete=true);
		hinges(lid_delete=true);

		// curve for lid swing
		translate([-size*.1,size*.555,size*.555]) scale([1,1,.7]) rotate([-90,0,0]) difference()
		{
			cube([size*1.2,size*.2,size*.2]);
			translate([-.1,0,0]) rotate([0,90,0]) cylinder(size*1.3, size*.1, size*.1);
		}
		lid_cutouts();
		lid_woodgrain();
		lid_nicks();
	}
	lid_rivets();
}

module lid_nicks()
{
	translate([-size*.14,0,size*.77]) rotate([0,90,-25]) scale([.5,1,1]) rotate([0,0,-45]) cube([size*.1,size*.1,size*.3]);
	translate([-size*.12,0,size*.8]) rotate([0,90,-25]) scale([.5,1,1]) rotate([0,0,-45]) cube([size*.1,size*.1,size*.3]);
}

module box_nick()
{
	translate([size*.82,-size*.15,size*.4]) rotate([0,90,25]) rotate([0,0,-45]) cube([size*.1,size*.1,size*.3]);
}

module lid_woodgrain()
{
	// top
	translate([size*.375,size*.125,size*.625]) rotate([-2,0,0]) woodgrain_template(); // front left
	translate([size*.65,size*.125,size*.625]) rotate([-2,0,0]) woodgrain_template(); // front right

	translate([size*.375,0,size*.602]) rotate([-40,0,0]) woodgrain_template(); // front corner left
	translate([size*.65,0,size*.602]) rotate([-40,0,0]) woodgrain_template(); // front corner right

	translate([size*.375,0,size*.715]) rotate([-87,0,0]) scale([1,1,2]) woodgrain_template(); // top left
	translate([size*.65,0,size*.715]) rotate([-87,0,0]) scale([1,1,2]) woodgrain_template(); // top right

	translate([size*.375,size*.39,size*.9]) rotate([-125,0,0]) woodgrain_template(); //back corner left
	translate([size*.65,size*.39,size*.9]) rotate([-125,0,0]) woodgrain_template(); // back corner right

	translate([size*.375,size*.565,size]) rotate([-185,0,0]) woodgrain_template(); // back left
	translate([size*.65,size*.565,size]) rotate([-185,0,0]) woodgrain_template(); // back right

	// left
	translate([size*.12, size*.3, size*.55]) scale([1,1,.62]) rotate([0,0,-90]) woodgrain_template();

	// right
	translate([size*.88, size*.3, size*.55]) scale([1,1,.62]) rotate([0,0,90]) woodgrain_template();
}

module box_woodgrain()
{
	// front
	translate([size*.375,size*.12,size*.05]) woodgrain_template();
	translate([size*.65,size*.12,size*.05]) woodgrain_template();

	// left
	translate([size*.12, size*.3, size*.05]) rotate([0,0,-90]) woodgrain_template();

	// right
	translate([size*.88, size*.3, size*.05]) rotate([0,0,90]) woodgrain_template();

	// back
	translate([size*.35,size*.407,size*.108]) rotate([16,0,180]) woodgrain_template();
	translate([size*.625,size*.407,size*.108]) rotate([16,0,180]) woodgrain_template();
}

module woodgrain_template()
{
	translate([0,-size*.1,0]) rotate([0,0,180]) difference()
	{
		translate([0,0,0]) cube([size*.03, size*.06, size*.36]);
		translate([size*.03,0, -size*.001]) scale([1,.8,1]) cylinder(size*.4,size*.015,size*.015);
		translate([0,0, -size*.001]) scale([1,.8,1]) cylinder(size*.4,size*.015,size*.015);
	}
}

module lid_rivets()
{
	// front
	translate([size*.055,0,size*.56]) scale([1,.8,1]) sphere(size*.025); // left
	translate([size*.95,0,size*.56]) scale([1,.8,1]) sphere(size*.025); // right

	// left side
	translate([0,size*.04, size*.535]) scale([.8,1,1]) sphere(size*.025); // front
	translate([0,size*.6, size*.535]) scale([.8,1,1]) sphere(size*.025); // back

	// right side
	translate([size,size*.04, size*.535]) scale([.8,1,1]) sphere(size*.025); // front
	translate([size,size*.6, size*.535]) scale([.8,1,1]) sphere(size*.025); // back

	// back
	translate([size*.055,size*.65,size*.59]) rotate([-5,0,0]) scale([1,.8,1]) sphere(size*.025); // left
	translate([size*.95,size*.65,size*.59]) rotate([-5,0,0]) scale([1,.8,1]) sphere(size*.025); // right
}

module box_rivets()
{
	// front
	translate([size*.055,0,size*.035]) scale([1,.8,1]) sphere(size*.025); // bottom left
	translate([size*.95,0,size*.035]) scale([1,.8,1]) sphere(size*.025); // bottom right
	translate([size*.055,0,size*.46]) scale([1,.8,1]) sphere(size*.025); // top left
	translate([size*.95,0,size*.46]) scale([1,.8,1]) sphere(size*.025); // top right

	// left side
	translate([0,size*.025, size*.035]) scale([.8,1,1]) sphere(size*.025); // bottom front
	translate([0,size*.48, size*.035]) scale([.8,1,1]) sphere(size*.025); // bottom back
	translate([0,size*.025, size*.46]) scale([.8,1,1]) sphere(size*.025); // top front
	translate([0,size*.6, size*.46]) scale([.8,1,1]) sphere(size*.025); // top back

	// right side
	translate([size,size*.025, size*.035]) scale([.8,1,1]) sphere(size*.025); // bottom front
	translate([size,size*.48, size*.035]) scale([.8,1,1]) sphere(size*.025); // bottom back
	translate([size,size*.025, size*.46]) scale([.8,1,1]) sphere(size*.025); // top front
	translate([size,size*.6, size*.46]) scale([.8,1,1]) sphere(size*.025); // top back

// back
	translate([size*.055,size*.515,size*.035]) rotate([-20,0,0]) scale([1,.8,1]) sphere(size*.025); // bottom left
	translate([size*.95,size*.515,size*.035]) rotate([-20,0,0]) scale([1,.8,1]) sphere(size*.025); // bottom right
	translate([size*.055,size*.64,size*.46]) rotate([-20,0,0]) scale([1,.8,1]) sphere(size*.025); // top left
	translate([size*.95,size*.64,size*.46]) rotate([-20,0,0]) scale([1,.8,1]) sphere(size*.025); // top right
}

module lid_cutouts()
{
	translate([size*.01,size*.08,size*.45]) lid_side_cutout(); // left
	translate([size*1.09,size*.08,size*.45]) lid_side_cutout(); // right
	lid_top_cutout();
}

module lid_top_cutout()
{
	translate([0,size*.021,-size*.021]) scale([1,.94,1]) difference()
	{
		translate([size*.1,-size*.1,size*.65]) cube([size*.8,size,size*.5]);
		lid_frame();
	}
}

module lid_side_cutout()
{
		difference(){
		translate([0,0,size*.3]) rotate([0,180,0]) hull()
		{
			cube([size*.1,size*.7,size*.2]);
			translate([size*.05,0,0]) rotate([-93,0,0]) scale([1,.8,1]) cylinder(size*.65, size*.05, size*.05);
		}
		translate([-size*.15,size*.48,-size*.05]) rotate([-6,0,0]) cube([size*.2, size*.3, size*.5]);
	}
}

module box_cutouts()
{
	translate([size*.1,size*.01, size*.05]) square_cutout(); // front
	translate([size*.1, size*.61, size*.05]) rotate([-16,0,0]) square_cutout(); //back
	translate([size*.01,size*.05,size*.1]) box_side_cutout(); // left
	translate([size*1.09,size*.05,size*.1]) box_side_cutout(); // right
}

module box_side_cutout()
{
	difference(){
		translate([0,0,size*.3]) rotate([0,180,0]) union()
		{
			cube([size*.1,size*.6,size*.35]);
			translate([size*.05,0,0]) rotate([-90,0,0]) scale([1,.8,1]) cylinder(size*.6, size*.05, size*.05);
		}
		translate([-size*.15,size*.4,-size*.05]) rotate([-16,0,0]) cube([size*.2, size*.3, size*.5]);
	}
}

module square_cutout()
{
	translate([0,0,size*.35]) rotate([-180,0,0]) union()
	{
		cube([size*.8,size*.1,size*.35]); // back
		translate([0,size*.05,0]) rotate([0,90,0]) scale([.8,1,1]) cylinder(size*.8,size*.05,size*.05);
	}
}

module lid_frame()
{
	difference()
	{
		hull()
		{
			translate([0,0,.03]) top_outline(lid_delete=true);
			minkowski()
			{
				translate([0,size*.05,size*.8]) rotate([0,90,0]) cylinder(size,size*.04,size*.04);
				sphere(size*.01);
			}
			minkowski()
			{
				translate([0,size*.65,size*.85]) rotate([0,90,0]) cylinder(size,size*.02,size*.02);
				sphere(size*.01);
			}
		}

		// lid void
		translate([size*.05,size*.05,size*.65]) scale([1,1.02,.7]) rotate([-90,0,0])
		{
			cube([size*.9, size*.5, size*.5]);
			translate([0,0,size*.25]) rotate([0,90,0]) cylinder(size*.9, size*.25, size*.25, $fn=4);
		}
	}
}

module lock(lid_delete=false)
{
	translate([size*.5,size*.015,size*.48]) 
	{
		difference()
		{
			minkowski()
			{
				difference()
				{
					cube([size*.3,size*.1,size*.3], center=true);
					translate([size*.195, 0,-size*.155]) rotate([0,45,0]) cube([size*.2,size*.2,size*.2], center=true); // corner
					translate([-size*.195, 0,-size*.155]) rotate([0,-45,0]) cube([size*.2,size*.2,size*.2], center=true); // corner
					translate([size*.195, 0,size*.195]) rotate([0,45,0]) cube([size*.2,size*.2,size*.2], center=true); // corner
					translate([-size*.195, 0,size*.195]) rotate([0,-45,0]) cube([size*.2,size*.2,size*.2], center=true); // corner
					translate([0,size*.1,0]) rotate([8,0,0]) cube([size*.4,size*.2,size*.4], center=true); // slanted back
					translate([0,0,-size*.205]) rotate([-35,0,0]) cube([size*.3,size*.3, size*.1], center=true); // bottom edge
				}
				if (lid_delete)
				{
					// since this will be deleted from the lid, make it slightly bigger so it fits well.
					sphere(size*.0175);
				}
				else
				{
					sphere(size*.0125);
				}
			}

			// mickey lock
			translate([0,-size*.03,0]) rotate([90,0,0]) cylinder(size*.04, size*.05, size*.065);
			translate([size*.055,-size*.03,size*.07]) rotate([90,0,0]) cylinder(size*.04, size*.03, size*.04);
			translate([-size*.055,-size*.03,size*.07]) rotate([90,0,0]) cylinder(size*.04, size*.03, size*.04);
		}
	}
}

module box_frame()
{
	difference()
	{
		box_shape();
		translate([size*.075,size*.06,size*.05]) scale([.85,.85,1.2]) box_shape(void=true);
	}
	hinges();
}

module box_shape(void=false)
{
	hull()
	{
		top_outline();
		// bottom outline
		minkowski()
		{
			if (void) {
				cube([size,size*.47,1]);
			} else {
				cube([size,size*.5,1]);
			}
			cylinder(r=size*.01,h=1);
		}
	}
}

module top_outline(lid_delete=false)
{
	// top outline
	translate([0,0, size*.5]) minkowski()
	{
		if(lid_delete)
		{
			cube([size,size*.64,.01]);
		}
		else
		{
			cube([size,size*.65,.01]);
		}
		cylinder(r=size*.01,h=.01);
	}
}

module hinges(lid_delete=false)
{
	difference()
	{
		// hinges
		union()
		{
			translate([size*.22,0,0]) hinge(lid_delete);
			translate([size*.72,0,0]) hinge(lid_delete);
		}

		if(!lid_delete)
		{
			// curve for lid swing
			translate([-size*.1,size*.56,size*.545]) scale([1,1,.5]) difference()
			{
				cube([size*1.2,size*.2,size*.2]);
				translate([-.1,0,0]) rotate([0,90,0]) cylinder(size*1.3, size*.1, size*.1);
			}
		}
	}
}

module hinge(lid_delete=false)
{
	if (lid_delete) {
		hinge_worker(nub_r=size*.0275, corner_r=size*.0125, top_fn=4);
	} else {
		hinge_worker(nub_r=size*.02, corner_r=size*.01, top_fn=$fn);
	}
}

module hinge_worker(nub_r, corner_r, top_fn)
{
	minkowski()
	{
		union()
		{
			difference()
			{
				translate([0,size*.56,size*.35]) cube([size*.06, size*.09, size*.21]);
				translate([-size*.01,size*.606,size*.35]) rotate([-16,0,0]) cube([size*.12, size*.08, size*.25]);
			}
			translate([size*.03,size*.65,size*.56]) rotate([90,0,0]) scale([1,.8,1])
				cylinder(size*.09, size*.03, size*.03, $fn=top_fn);
		}
		cylinder(r=corner_r, h=corner_r);
	}

	if (top_fn==4)
	{
		translate([size*.03,size*.66,size*.5825]) rotate([90,0,0]) scale([1,.8,1])
			cylinder(size*.12, size*.03, size*.03, $fn=top_fn);
	}

	// nubs
	translate([0, size*.61, size*.55]) sphere(nub_r);
	translate([size*.06, size*.61, size*.55]) sphere(nub_r);
}