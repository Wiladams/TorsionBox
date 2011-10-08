joinfactor = 0.01;


module corner(length, thickness, height, gap)
{
	translate([gap/2, gap/2,0])
	cube(size=[thickness, length, height]);

	translate([gap/2, gap/2,0])
	cube(size=[length, thickness, height]);
}

module basedcorner(length, thickness, height, gap, basecarve=false)
{
	blength = length+gap/2+joinfactor;
	cradius = (length-thickness);
	

	difference()
	{
		union()
		{
			corner(length, thickness, height, gap);

			// Lay in a base
			translate([0,0,-thickness])
			cube(size=[blength, blength, thickness+joinfactor]);
		}

		translate([cradius+gap/2+thickness, cradius+gap/2+thickness, -thickness-joinfactor*2])
		cylinder(r= (cradius), h=thickness*2+joinfactor*4, $fn=24);	
	}
}

module slots(length, thickness, height, gap, corners)
{
	angle = 360/corners;

	// corners
	for(i=[0:corners-1])
	{
		rotate([0,0,i*angle])
		basedcorner(length, thickness, height, gap);
	}
}

module connector(length, thickness, height, gap, corners, hole=false)
{
	if (hole == true)
	{
		difference()
		{
			slots(length, thickness, height, gap, corners);

			translate([0,0,-thickness-joinfactor*2])
			cylinder(r=(gap/2), h=thickness*2);
		}
	} else
	{
		slots(length, thickness, height, gap, corners);
	}
}

