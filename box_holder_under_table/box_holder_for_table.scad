// Box holder for table

// https://openscad.org/cheatsheet/

// Object parameters
w = 92;
l = 92;
h = 27;
error = 0; // mm to add to account for print error
wall_width = 10;
screw_hole_r = 4;






// Change quality 
$fn = 64;
object_size = [w,l,h];

module inside_cube(object_size)
{
    cube(object_size,true);
}

module wall_cube(object_size, wall_w, screw_hole_r)
{
     connector_width = 5;
     cube_size_addition = [wall_w,wall_w, 0];
     
     union() {
         translate([0,0,-wall_w/2]) cube(object_size + cube_size_addition + [0,0, wall_w / 2], true);
         translate([0,0,object_size[2]/2 - connector_width/2]) cube([object_size[0], object_size[1] + screw_hole_r*3 +wall_w, connector_width] + cube_size_addition , true);
     }
}

module holes(hole_distance, screw_hole_r)
{
    translate([0, -hole_distance/2, 0]) cylinder(h=100, r=screw_hole_r, center=false);
    translate([0, hole_distance/2, 0]) cylinder(h=100, r=screw_hole_r, center=false);
    
}

difference()
{
    wall_cube(object_size, wall_width, screw_hole_r);
    inside_cube(object_size * (error + 1));
    
    translate([0,0,object_size[2]/5]) inside_cube(object_size + [2*wall_width, 0, 0 ]);
    translate([object_size[1]/2,0,0]) inside_cube(object_size + [2*wall_width, 0, 0 ]);
    
    translate([-object_size[1]/2.5,0,0]) holes(object_size[0] + wall_width*2, screw_hole_r);
    translate([object_size[1]/2.5,0,0]) holes(object_size[0] + wall_width*2, screw_hole_r);
}