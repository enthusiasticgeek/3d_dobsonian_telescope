/*
(c) 2023 Pratik M Tambe <enthusiasticgeek@gmail.com>
MIT license
This is the base plate for focuser for Pratik's 4.5" f/4.7 telescope.
the outer diameter of the curve is 176 mm (6.93")
the inner diameter of the curve is 127 mm (5")
the curve is for base plate
*/

//This is thinner version

hole_screws=true;
offset_thin=0.90;

$fn=360;

outer_curve=6.93;
inner_curve=5;
focuser_width=2.8;
center_hole_diameter=2.4;


module pipe_raw(){
difference(){
cylinder (r=outer_curve/2,h=focuser_width, center=true);
translate([0,0,0]) cylinder (r=inner_curve/2,h=3, center=true);
}
}


module pipe_with_a_hole(){
difference(){
 rotate([0,90,0]) pipe_raw();
 cylinder(r=center_hole_diameter/2, h=20, center=true);
}
}


module symmetric_pipe_with_a_hole(){
difference(){
pipe_with_a_hole();
translate([0,-focuser_width,0]) cube([focuser_width*3,focuser_width,focuser_width*3],center=true);
translate([0,focuser_width,0]) cube([focuser_width*3,focuser_width,focuser_width*3],center=true);
}
}

module single_pipe_with_a_hole(){
difference(){
symmetric_pipe_with_a_hole();
translate([0,0,2]) cube([5,5,5],center=true);
}
}

// The dimensions of holes are based on https://agenaastro.com/gso-1-25-crayford-focuser-with-176mm-base-plate-for-reflectors-single-speed.html

hole_placement=2.25;
hole_size=0.05;

module holes(){
   translate([-hole_placement/2,-hole_placement/2,0])  cylinder(r=hole_size, h=10, center=true);
   translate([-hole_placement/2,hole_placement/2,0])  cylinder(r=hole_size, h=10, center=true);
   translate([hole_placement/2,-hole_placement/2,0])  cylinder(r=hole_size, h=10, center=true);
   translate([hole_placement/2,hole_placement/2,0])  cylinder(r=hole_size, h=10, center=true);
}

//holes();

module single_pipe_with_a_hole_final(){
    difference(){
    single_pipe_with_a_hole();
    holes();
    }
}

module single_pipe_with_a_hole_final_thin(){
    difference(){
        if (hole_screws) {
           single_pipe_with_a_hole_final();
    } else {
           single_pipe_with_a_hole();
        }
        translate([0,0,-offset_thin])  rotate([0,90,0]) cylinder(r=inner_curve/2, h=20, center=true);
    }
}

//single_pipe_with_a_hole_final_thin();


module cutter(){
width = 1;   // width of rectangle
height = 0.2;   // height of rectangle
r = 0.31;       // radius of the curve
a = 90;       // angle of the curve

rotate_extrude(angle = a) translate([r, 0, 0]) square(size = [height, width], center = true);
}

module cutter_final(){
    translate([center_hole_diameter/2,center_hole_diameter/2,-inner_curve/2-0.65])rotate([0,0,0]) cutter();
    
    translate([-center_hole_diameter/2,center_hole_diameter/2,-inner_curve/2-0.65])rotate([0,0,90]) cutter();
    
    translate([-center_hole_diameter/2,-center_hole_diameter/2,-inner_curve/2-0.65])rotate([0,0,180]) cutter();
    
    translate([center_hole_diameter/2,-center_hole_diameter/2,-inner_curve/2-0.65])rotate([0,0,270]) cutter();
}


module single_pipe_with_a_hole_final_thin_cut(){
    difference(){
    single_pipe_with_a_hole_final_thin();
    
        cutter_final();
    }
}
    


single_pipe_with_a_hole_final_thin_cut();





