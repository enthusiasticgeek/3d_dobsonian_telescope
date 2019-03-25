//f/8 6" Square Tube Dobsonian Telescope
/*
MIT License

Copyright (c) 2019 Enthusiasticgeek <enthusiasticgeek@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

// Note: All measurements are in inches unless otherwise specified

//baseboard
module baseboard_plate(){
radius=19/2.0;
color("orange") cylinder(h=0.75, r1=radius, r2=radius,$fn=50, center=true);
}

//rockerboard base
module rockerboard_base(){
radius=19/2.0;
translate ([0,0,1]){
  color("orange") cylinder(h=0.75, r1=radius, r2=radius,$fn=50, center=true);
}
}
//board_legs
module baseboard_legs(){
  color("orange") cylinder(h=0.75, r1=2, r2=2, $fn=50, center=true);
}

//primary mirror
module primary_mirror(){
    //radius of curvature
    roc=96;
    focal_length=roc/2.0;
    thickness=1;
    difference(){
       color("green") cylinder(h=thickness, r1=3, r2=3, center=false, $fn=50);
       color("silver") translate([0,0,roc+thickness/2.0]) sphere(r = roc, $fn=100);
    
}
}

//secondary mirror
module secondary_mirror(){
    //optical flat
  rotate([0,0,45])  difference(){
       color("green") cylinder(h=5, r1=1.3, r2=1.3,$fn=50, center=false);
       color("green") translate([0,0,3]) rotate(45, [ 0,1,0 ]) cylinder(h=3, r1=5, r2=5,$fn=50, center=false);
       color("silver") translate([0,0,-2]) rotate(45, [ 0,1,0 ]) cylinder(h=3, r1=5, r2=5,$fn=50, center=false);
    }
    //spider
    translate([0,0,1]) spider();
}

module leg(){
  minkowski() {
  cube([2,1,1.5],center=true);
  // rounded corners
  sphere(0.3,center=true);
 }
}

module baseboard(){
   baseboard_plate();
    //center shaft
    color("red") translate([0,0,-0.5])  cylinder(h=3, r1=0.5, r2=0.1,$fn=50, center=false);
   /*    
   //leg1
    translate([19/2-2,0,-1]) cylinder(h=0.5, r1=2, r2=2,$fn=50, center=false);
   //leg2
    translate([-19/2+2,0,-1]) cylinder(h=0.5, r1=2, r2=2,$fn=50, center=false);
   //leg3
    translate([0,-19/2+2,-1]) cylinder(h=0.5, r1=2, r2=2,$fn=50, center=false);
   //leg4
    translate([0,19/2-2,-1]) cylinder(h=0.5, r1=2, r2=2,$fn=50, center=false);
    */
    
    //hull ($fn=20) {
    //radius of base - radius of leg
    translate([-19/2-1,0,-1.2])
    {
    //https://www.ajdesigner.com/phptriangle/equilateral_triangle_inscribed_circle_radius_r.php
        
        /*
    # translate([0,0,0]) cylinder(r=2,h=2,$fn=50, center=false);
    translate([19/2.0*6/sqrt(3)/2,-19/2.0*6/sqrt(3)/2.0/2,0]) cylinder(r=2,h=2, $fn=50, center=false);
    translate([19/2.0*6/sqrt(3)/2,19/2.0*6/sqrt(3)/2.0/2,0]) cylinder(r=2,h=2, $fn=50, center=false); 
        */
        
        
    translate([0.25,0,0]) leg();
    translate([19/2.0*6/sqrt(3)/2,-19/2.0*6/sqrt(3)/2.0/2,0]) rotate(125,[0,0,1]) leg();
    translate([19/2.0*6/sqrt(3)/2,19/2.0*6/sqrt(3)/2.0/2,0])  rotate(-125,[0,0,1]) leg();
        
    }
   //}
}

//helper function for cutout
module bearing_cutout_helper(){
    
         width=12;
         side=4.25;
         thickness=0.75;
         rotate(90,[1,0,0]) 
         difference(){
             translate([0,-side,0])  cylinder(h=2, r1=side, r2=side,$fn=50, center=true);
             cube([side*2,side*2,side*2],center=true);
         }
}

module rockerboard(){
    //add
    thickness=0.75;
    side_length=30;
    front_length=12;
    width=12;
    radius=3;
    
    //front
    translate([12/2.0,-width/2.0-thickness,thickness]) 
    difference(){
        cube([thickness,width+2*thickness,front_length], center=false);
        translate([0,width/2.0+thickness,front_length/2.0]) rotate(90,[0,1,0])  cylinder(h=2, r1=radius, r2=radius,$fn=50, center=true);
    }
    
    //left
    rotate(90,[0,0,1]) translate([12/2.0,-width/2.0,thickness]) 
    difference(){
        difference(){
            difference(){
                cube([thickness,width,side_length], center=false);
                translate([0,width/2.0,side_length/3.0]) rotate(90,[0,1,0])  cylinder(h=2, r1=radius, r2=radius,$fn=50, center=true);
            }
            translate([0,width/2.0,2*side_length/3.0]) rotate(90,[0,1,0])  cylinder(h=2, r1=radius, r2=radius,$fn=50, center=true);
         }
         helper_side=4.26;
         translate([0,width/2.0,side_length+helper_side]) rotate(90,[0,0,1]) bearing_cutout_helper();
    }
    
    //right
    rotate(90,[0,0,1]) translate([-12/2.0-thickness,-width/2.0,thickness]) 
    difference(){
        difference(){
            difference(){
                cube([thickness,width,side_length], center=false);
                translate([0,width/2.0,side_length/3.0]) rotate(90,[0,1,0])  cylinder(h=2, r1=radius, r2=radius,$fn=50, center=true);
            }
            translate([0,width/2.0,2*side_length/3.0]) rotate(90,[0,1,0])  cylinder(h=2, r1=radius, r2=radius,$fn=50, center=true);
         }
         helper_side=4.26;
         translate([0,width/2.0,side_length+helper_side]) rotate(90,[0,0,1]) bearing_cutout_helper();
     }
    
    rockerboard_base();
}

//=======================================================================================  
module fan($fn=720){
  
  difference()
    {
    linear_extrude(height=25, center = true, convexity = 4, twist = 0)
       difference()
        {
        //overall outside
        square([60,60],center=true);
        //main inside bore, less hub
        difference()
          {
          circle(r=57/2,center=true);
          //hub. Just imagine the blades, OK?
          circle(r=31.5/2,center=true);
          }
        //Mounting holes
        translate([+25,+25]) circle(r=3.4/2,h=25+0.2,center=true);
        translate([+25,-25]) circle(r=3.4/2,h=25+0.2,center=true);
        translate([-25,+25]) circle(r=3.4/2,h=25+0.2,center=true);
        translate([-25,-25]) circle(r=3.4/2,h=25+0.2,center=true);
        //Outside Radii
        translate([+30,+30]) difference()
          {
          translate([-4.9,-4.9]) square([5.1,5.1]);
          translate([-5,-5]) circle(r=5);
          }
        translate([+30,-30]) difference()
          {
          translate([-4.9,-0.1]) square([5.1,5.1]);
          translate([-5,+5]) circle(r=5);
          }
        translate([-30,+30]) difference()
          {
          translate([-0.1,-4.9]) square([5.1,5.1]);
          translate([+5,-5]) circle(r=5);
          }
        translate([-30,-30]) difference()
          {
          translate([-0.1,-0.1]) square([5+0.1,5+0.1]);
          translate([5,5]) circle(r=5);
          }
      } //linear extrude and 2-d difference
    //Remove outside ring
    difference()
      {
      cylinder(r=88/2,h=25-3.6-3.6,center=true);
      cylinder(r=64/2,h=25-3.6-3.6+0.2,center=true);
      }      
    }// 3-d difference

    //Seven Blades
    linear_extrude(height=10, center = true, convexity = 4, twist = -30)
      for(i=[0:6])
        rotate((360*i)/7)
          translate([0,-1.5/2]) #square([57/2-0.75,1.5]);
}


module quarter_rims(rim_length, angle=0){
    rotate(angle,[0,0,1]) difference(){
        color("orange") cylinder(h=rim_length, r1=0.75, r2=0.75,$fn=50, center=true);
        translate([-0.75/2.0,-0.75/2.0,0]) cube([0.75,0.75,rim_length], center=true);
        translate([-0.75/2.0,+0.75/2.0,0]) cube([0.75,0.75,rim_length], center=true);
        translate([+0.75/2.0,+0.75/2.0,0]) cube([0.75,0.75,rim_length], center=true);
    }
}

module baffle(){
    inner_side=8;
    thickness=0.25;
      difference(){
       color("silver") cube([inner_side,inner_side,thickness], center=true);
       color("green") cylinder(h=1, r1=3.75, r2=3.75, center=true, $fn=50);
    }
}

module lid(offset){
    inner_side=8;
    color("red") cube([inner_side,inner_side,0.75], center=true);
    mirror_cell();
}

module mirror_cell(){
    inner_side=8;
    color("green") translate([0,0,4]) cube([inner_side,inner_side,0.75], center=true);
    color("yellow") translate([0,0,9]) scale([0.05,0.05,0.05]) fan();
    color("yellow",0.8) translate([0,0,5]) difference(){
        cylinder(h=1.5, r1=4, r2=4, center=true, $fn=50);
        cylinder(h=1.5, r1=3.8, r2=3.8, center=true, $fn=50);
    }
}

module spider(){
    
    inner_side=8;
    translate([0,0,inner_side/2.0]) cube([0.2,inner_side,0.2], center=true);
    translate([0,0,inner_side/2.0]) cube([inner_side,0.2,0.2], center=true);
    translate([0,0,inner_side/2.0-1]) cylinder(h=1.5, r1=0.5, r2=0.5, center=true, $fn=50);
}

module incra_mitre_channel(){
    ota_length=54;
    focal_length=48;
    length=ota_length/4.0;
    difference(){
        color("green") cube([length,1.0,1.5], center=true);
        color("green") cube([length+1,0.75,1.0], center=true);
        color("green") translate([-ota_length/4.0,-0.5,0]) cube([2*length+1,1,0.25], center=false);       
    }
}

module ota_altitude_bearing(offset=6){
    ota_length=54;
    focal_length=48;
    length=ota_length/4.0;
    radius=4;
    rotate(180,[0,1,1]) translate([0,0,offset]) cylinder(h=1.5, r1=radius, r2=radius, center=true, $fn=50);
}

module telrad(){
    ota_length=54;
    focal_length=48;
    length=ota_length/2.0;
   //l x w x h
   //base 9 x 2 x 5 inches
   //translate([0,0,10])  rotate(-45,[0,1,0]) cube([2,2,2],center=true);
    rotate([180,0,0])
    {
    rotate(180,[1,0,1]) union(){
       cube([9,2,2],center=true);
       translate([+9/2.0-1.5,0,-1]) rotate(-45,[0,1,0])  cube([2,2,2],center=true);
       color("red",0.2) translate([+9/2.0-2,0,-2.2]) rotate(-45,[0,1,0])  cube([0.2,1.8,3],center=true);
    }
   }
}

//focuser
module focuser(){
    ota_length=54;
    focal_length=48;
    thickness=0.25;
    inner_side=8;
    outer_side=2*thickness+inner_side;
    
    difference(){
    union(){
       translate([0,0,-ota_length/2.0+focal_length+3]) rotate(90, [ 1,0,0 ]) cylinder(h=3, r1=1.3, r2=1.3,$fn=50, center=false);
       translate([0,0,-ota_length/2.0+focal_length+3]) rotate(90, [ 1,0,0 ]) cylinder(h=2, r1=1.5, r2=1.5,$fn=50, center=false);        
       translate([0,0,-ota_length/2.0+focal_length+3]) rotate(90, [ 1,0,0 ]) cube([3,3,0.5], center=true);               
       translate([0,-1,-ota_length/2.0+focal_length+5]) rotate(270, [ 0,0,1 ]) cylinder(h=0.5, r1=1.0, r2=1.0,$fn=50, center=false);    
       translate([0,-1,-ota_length/2.0+focal_length+0.5]) rotate(270, [ 0,0,1 ]) cylinder(h=0.5, r1=1.0, r2=1.0,$fn=50, center=false);       
    }   
       
       translate([0,0,-ota_length/2.0+focal_length+3]) rotate(90, [ 1,0,0 ]) cylinder(h=3, r1=1.2, r2=1.0,$fn=50, center=false);
   }
}

// Helper to create 3D text with correct font and orientation
module t(t, s = 18, style = "") {
  rotate([90, 0, 0])
    linear_extrude(height = 1)
      text(t, size = s, font = str("Liberation Sans", style), $fn = 16);
}

//optical tube assembly
module ota(){
    ota_length=54;
    focal_length=48;
    thickness=0.25;
    inner_side=8;
    outer_side=2*thickness+inner_side;
    
    color("red") difference() {
      cube([outer_side,outer_side,ota_length],center=true);
      cube([inner_side,inner_side,ota_length+2], center=true);
      translate([-inner_side/2.0,-inner_side/2.0,ota_length/2.0-13.5/2+1]) cube([3.5,3.5,13.5], center=true);
      //rotate([90, 90, 0])  translate([-ota_length/2.0-2,-inner_side/2.0-0.5,inner_side/2.0+0.5])  prism();
      rotate([90, 90, 0])  translate([-ota_length/2.0-2,-inner_side/2.0-0.5,inner_side/2.0+0.5])  cube([10,10,10]);
      #translate([0,0,-ota_length/2.0+focal_length+3]) rotate(90, [ 1,-1,0 ]) cylinder(h=30, r1=1.3, r2=1.3,$fn=50, center=false);
    }

      translate([3.0,-3.0,0]) rotate([90, 90, 45]) translate([-ota_length/2.0+13.5/2, -inner_side/2.0,-inner_side/2.0]) cube([13.5,0.5,3.5], center=true);   

//corner1
 translate([-inner_side/2.0,inner_side/2.0,0]) quarter_rims(ota_length,0);

//corner2
 translate([inner_side/2.0,inner_side/2.0,0]) quarter_rims(ota_length,270);

//corner3
 translate([-inner_side/2.0,-inner_side/2.0,0]) quarter_rims(ota_length,90);

//corner4
 translate([inner_side/2.0,-inner_side/2.0,0]) quarter_rims(ota_length,180);

//secondary mirror
color("green") translate([0,0,-ota_length/2.0+1+focal_length]) secondary_mirror();

//primary mirror
color("Silver") translate([0,0,-ota_length/2.0+1]) primary_mirror();
    
//front baffle    
color("green") translate([0,0,ota_length/2.0]) baffle();
    
//front middle baffle    
color("green") translate([0,0,ota_length/4.0]) baffle();
    
//center baffle    
color("green") translate([0,0,0]) baffle();

//rear middle baffle    
color("green") translate([0,0,-ota_length/4.0]) baffle();
    
//rear lid    
translate([0,0,-ota_length/2.0 - 25]) lid();

//left side
translate([0,inner_side/2.0+0.75,0]) rotate(90,[0,1,0]) incra_mitre_channel();

//right side
translate([0,-inner_side/2.0-0.75,0]) rotate(90,[0,1,0]) incra_mitre_channel();

//left altitude bearing 
color("white") ota_altitude_bearing(6);

//right altitude bearing 
color("white") ota_altitude_bearing(-6);

//telrad
translate([-inner_side/2.0-1.5,0,+ota_length/2.0-9/2.0]) telrad();

//focuser
rotate([0, 0, -45]) translate([0,-5,0]) focuser();

}

module prism(){
    offset=0.5;
    length=13.5+offset;
    width=4+offset;
    #polyhedron(points=[[0,0,0],[0,width,0],[length,0,0],[length,width,0],[0,0,-width],[length,0,-width]], faces=[[0,1,3,2],[0,2,5,4],[1,3,5,4],[0,1,4],[2,3,5]]);
   
}

module telescope(){
        
    ota_length=54;
    focal_length=48;
    thickness=0.25;
    inner_side=8;
    outer_side=2*thickness+inner_side;

//start with the base of telescope
baseboard();
rockerboard();
    
//show dis-assembled    
ota_offset=40;    
//Start telescope construction
translate([0,0,ota_offset]) rotate(80, [ 0,1,0 ]) difference(){ ota(); translate([0,0,-ota_length/2.0+focal_length+3]) rotate(90, [ 1,-1,0 ]) cylinder(h=30, r1=1.3, r2=1.3,$fn=50, center=false); }
//ota();
     
translate([50, 0, 40])  t("Enthusiasticgeek Telescope", 2, ":style=Bold");
    
rotate(180,[0,0,1]) translate([50, 0, 40])  t("Enthusiasticgeek Telescope", 2, ":style=Bold");
    

}


//call telescope
telescope();
