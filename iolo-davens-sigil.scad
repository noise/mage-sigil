// Mage Sigil of Iolo Davens
//

$fn=50;

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
  cylinder(s,1.2);
}

module pinholes(s) {
  translate([0,s*.83,0]) pinhole(s);
  translate([0,-s*.83,0]) pinhole(s);
  rotate([0,0,5]) translate([s*.85, 0,0]) pinhole(s);
  rotate([0,0,-5]) translate([-s*.85, 0,0]) pinhole(s);
}


module i(s){
  linear_extrude(s*0.15) {
    color("#1255AA")
    translate([0,0,.1])
    difference() {
      circle(s);
      translate([-s*1.10, 0,0]) circle(s);
      translate([+s*1.10, 0,0]) circle(s);
    }
  }
}

module d(s) {
  //translate([0,s*.1,0]) // hmmm... 
  //scale([0.9, 0.9, 1])
  //color("#435579") 
  linear_extrude(s*0.1) {
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

module sigil(s) {
  difference() {
    union() {
      d(s);
      i(s);
    }
    pinholes(s);
    fillet(s);
  }  
  // epaulets
  //epaulet(s);
  //rotate([0,180,0]) epaulet(s);


}

sigil(30);
