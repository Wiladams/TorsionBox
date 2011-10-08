include <corners.scad>

joinfactor = 0.1;
gapsize = 6;

panelheight = 100;
panellength = 300;

//lockpanel(thickness=gapsize, length = panellength, height=panelheight);

torsionbox();

//basedcorner(length=8, thickness=2, height=5, gap=6.5);
//corner(8, 2, 5, 6.5);

//connector(length=16, thickness=3,height=12,gap=gapsize, corners=4, hole=false); 


module lockpanel(thickness, length, height)
{
	slotthickness = thickness+joinfactor*2;
	slotdepth = height/2;
	slotwidth = thickness +joinfactor*2;
	
	translate([-length/2, -thickness/2, -height/2])
	difference()
	{
		// Main panel
		cube(size=[length, thickness, height]);

		// left end slot
		translate([12+slotwidth/2, -joinfactor, -joinfactor])
		cube(size=[slotwidth, slotthickness, slotdepth]);

		// right end slot
		translate([length-12-slotwidth/2, -joinfactor, -joinfactor])
		cube(size=[slotwidth, slotthickness, slotdepth]);

		// middle slot
		translate([(length/2)-slotwidth/2, -joinfactor, -joinfactor])
		cube(size=[slotwidth, slotthickness, slotdepth]);
	}
}

module torsionbox()
{
	lockpanel(thickness=gapsize, length = panellength, height=panelheight);

	rotate([180, 0, 90])
	lockpanel(thickness=gapsize, length = panellength, height=panelheight);

	// Place a cap over the joint
	color([0,1,1])
	translate([0,0,panelheight/2])
	rotate([180, 0,0])
	connector(length=16, thickness=3,height=12,gap=gapsize, corners=4, hole=true); 

}