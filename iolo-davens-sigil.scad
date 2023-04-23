// Mage Sigil of Iolo Davens
//

$fn=20;

module circle_cutter(s) {
  difference(){
    circle(s*5);
    circle(s); 
  }
}

module epaulet(s) {
  difference() {
    translate([-s*1.25, 0, 0])  
    circle(s);
    circle_cutter(s);
    //translate([0, -s * .5, 0])
    //circle_cutter(s);
    translate([0, s*.2, 0])
    circle(s*1.1);
  }
}

module pinhole(s){
  translate([-2, 0, 0]) cylinder(s,1.0);
  translate([2, 0, 0]) cylinder(s,1.0);
}

module buttonholes(s) {
  translate([0,s*.83,0]) pinhole(s);
  translate([0,-s*.83,0]) pinhole(s);
  rotate([0,0,85]) translate([0,s*.85,,0]) pinhole(s);
  rotate([0,0,-85]) translate([0, s*.85,,0]) pinhole(s);
}


module i(s,d){
  linear_extrude(s*d) {
    color("#1255AA")
    translate([0,0,.1])
    difference() {
      circle(s);
      translate([-s*1.10, 0,0]) circle(s);
      translate([+s*1.10, 0,0]) circle(s);
    }
  }
}

module d(s,d) {
  //translate([0,s*.1,0]) // hmmm... 
  //scale([0.9, 0.9, 1])
  //color("#435579") 
  linear_extrude(s*d) {
    difference() {
      translate([0,s/2, 0]) difference() {
        circle(s*1.15);
          translate([0, +s*.95,,0]) circle(s*1.35);
          //translate([0, -s*1.25,,0]) circle(s);
        }
        circle_cutter(s);
      
      // cutout
      translate([0,s*.32, 0])
      difference() {
        translate([0,s*.15, 0])
        circle(s*0.9);
        translate([0,s*.5, 0]) circle(s*1.05);
        translate([0,-s*.35, 0])
        difference() {
          circle(s*3);
          circle(s*.7);
        }
      }
    }
  }
}

module fillet(s) {
  rndrad=s*.2;

  translate([0,0,s*.15])
  rotate_extrude() {
    translate([s+rndrad-s*.14,s*.12,0])
        circle(rndrad);
  }
}

module sigil(s,d) {
  difference() {
    union() {
      d(s,.1);
      i(s,.15);
    }
    buttonholes(s);
    fillet(s);
  }  
  
  // epaulets
  //epaulet(s);
  //rotate([0,180,0]) epaulet(s);


}
module roundover(s) {
  intersection() {
  difference() {
    union() {
      //d(s,.1);
      //i(s,.15);
      d(s,2);
      i(s,2);
    }
    buttonholes(s);
    //fillet(s);
  }  
    scale([1,1,.5]) difference() {
      translate([0,0,-s]) sphere(s*1.9);
      translate([0,0,-s-10]) sphere(s*2.1);
    }
    translate([0,0,3.5]) scale([1,1,.5]) sphere(s*1.05);
  }
  //}
}

//translate([70,0,0]) sigil(30);
roundover(30);
