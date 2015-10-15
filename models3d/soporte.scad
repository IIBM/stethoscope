diam=35;
diaminelectr = 3.5;
diamoutelectr = 4;
diambaselect = 10;
besp = 0.6;
holehigh = 2;
elecesp = 1.2;

rad=diam/2.0;
radinelectr = diaminelectr/2.0;
radoutelectr= diamoutelectr/2.0;
radbaselect = diambaselect/2.0;

posin = 8;
posout = rad;

//base
//module
difference(){
  cylinder(h = elecesp, r = rad, $fn=100);

  for (i=[0:2]){
    rotate([0,0,i*120])
      hull() {
        translate([posin,0,-elecesp])
          cylinder(h = 6, r = radbaselect, $fn=100);
        translate([posout,0,-elecesp])
          cylinder(h = 6, r = radbaselect, $fn=100);
      }
  }
}

translate([0,0,elecesp])
difference(){
  cylinder(h = besp, r = rad, $fn=100);

  for (i=[0:2]){
    rotate([0,0,i*120])
      hull() {
        translate([posin,0,-0.5])
          cylinder(h = 6, r = radinelectr, $fn=100);
        translate([posout,0,-0.5])
          cylinder(h = 6, r = radinelectr, $fn=100);
      }
  }
}

// marcas de posicion
translate([0,0,elecesp])
for (i=[0:2]){
  rotate([0,0,i*120+60])
    for (j=[0:i]){
      translate([11-j*2.5,0,0]) cylinder(h = 2*besp+1, r = 1, $fn=100);
    }
}

//base superior
translate([0,0,elecesp])
difference(){
  cylinder(h = 2*besp, r = rad, $fn=100);
  for (i=[0:2]){
    rotate([0,0,i*120])
      hull() {
        translate([posin,0,-0.5])
          cylinder(h = 6, r = radoutelectr, $fn=100);
        translate([posout,0,-0.5])
          cylinder(h = 6, r = radoutelectr, $fn=100);
      }
  }
}

translate([0,0,elecesp])
difference(){
 union(){
  cylinder(h = 12, r = 5, $fn=100);
  translate([0,0,11])
    cylinder(h = 8, r1 = 5, r2=6.3, $fn=100);
  translate([0,0,19])
    cylinder(h = 4, r = 6.3, $fn=100);
 }
  cylinder(h = 25, r = 3 	, $fn=100);
  translate([0,0,24])cube([5,20,20],center=true);
  for (i=[0:2]){
    rotate([0,0,i*120])
      union(){
        translate([0,-1.5,2*besp]) cube([6,3,holehigh]);
        translate([0,0,2*besp+holehigh]) rotate([0,90,0]) 
          cylinder(h = 6, r = 1.5, $fn=100);
      }
  }
}