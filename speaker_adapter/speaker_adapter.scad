// Speaker adapter for a smaller speaker to bigger hole

// https://openscad.org/cheatsheet/

// Object parameters

// Speaker 
// https://www.daytonaudio.com/images/resources/295-305-dayton-audio-dc160-8-specifications-46146.pdf

// Speaker specs
// https://www.daytonaudio.com/images/resources/295-305-dayton-audio-dc160-8-specifications-46146.pdf
speaker_cylinder_r_min = 144.7 / 2;
speaker_cylinder_w = 15;
speaker_cylinder_holes_r_center = 156.5/2;
speaker_cylinder_holes_r = 3;
speaker_holes_n = 4;

// Speaker holder specs
box_cylinder_r = 203/2;
box_cylinder_r_min = (176)/2;

box_cylinder_w = 10;
box_cylinder_holes_r_center = 194/2;
box_cylinder_holes_r = 3;
box_holes_n = 8;



// setting the quality
$fn = 128;

module inner_cylinder(w, r_in, r_out, r_holes_center,r_holes, holes_n)
{
    difference() {
        
        cylinder(h=w, r=r_out, center = true );
        cylinder(h=w+0.1, r=r_in, center = true );
        for (angle = [ 0 : 360 / holes_n : 360])
        rotate([0,0,angle])  
            translate([r_holes_center, 0, 0]) 
        cylinder(h = w * 2, r = r_holes, center = true);
        
    }
}

union() {
    inner_cylinder(
        w = speaker_cylinder_w, 
        r_in = speaker_cylinder_r_min,
        r_out = box_cylinder_r_min,
        r_holes_center = speaker_cylinder_holes_r_center, 
        r_holes = speaker_cylinder_holes_r,
        holes_n = speaker_holes_n);
    translate([0,0,(box_cylinder_w - speaker_cylinder_w)/2]) inner_cylinder(
        w = box_cylinder_w, 
        r_in = box_cylinder_r_min,
        r_out = box_cylinder_r,
        r_holes_center = box_cylinder_holes_r_center, 
        r_holes = box_cylinder_holes_r,
        holes_n = box_holes_n
        );

}
    
    






