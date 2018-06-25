placa_x=54;
placa_y=69; //56 + lugar para el prensacables
placa_z=25;

ancho_tapa=2;
ancho_pared=3;
alto_tapa=14;
radio_prensacable=8.5;

ancho_usb=11.5;
alto_usb=8;


module tapa(){
    difference(){
        union(){
            difference(){
                cube([placa_x+ancho_pared*2, placa_y+ancho_pared*2, placa_z+ancho_tapa*2]);
                
                translate([ancho_pared, ancho_pared, ancho_tapa])
                    cube([placa_x, placa_y, placa_z]);
                //Le saco la mitad de abajo
                cube([placa_x+ancho_pared*2, placa_y+ancho_pared*2, (placa_z+ancho_tapa*2)/2]);
            }
            //Aleta para enganchar
            translate([ancho_pared-1, ancho_pared-1, (placa_z+ancho_tapa*2)/2-4.5]){
                difference(){
                    cube([placa_x+1.75, placa_y+1.75, 4.5]);
                    translate([1, 1, 0])
                        cube([placa_x, placa_y, 4.5]);
                }
            }
        }
        //Agujero para el prensacables
        translate([(placa_x+ancho_pared*2)/2, ancho_pared+2, (placa_z+ancho_tapa*2)/2]){
            rotate([90, 0, 0]){
                cylinder(r=radio_prensacable, h=ancho_pared+4, $fn=50);
                translate([0, -radio_prensacable/2, (ancho_pared+4)/2])
                    cube([radio_prensacable*2, radio_prensacable, ancho_pared+4], center=true);
            }           
        }
        //Agujero para el USB
        translate([ancho_pared+8, placa_y-2, 10])
            #cube([ancho_usb, alto_usb, ancho_pared+10]);
        
        //Agujero para que se vean los leds del arduino
        translate([ancho_pared+8-0.5, 30, (alto_tapa*2)-4.7])
            cube([(ancho_usb/4)*3, ancho_usb/2, ancho_pared+2]);
        //Agujero para que se vean los leds del arduino
        translate([ancho_pared+8+(ancho_usb/4)*3-0.5, 30, (alto_tapa*2)-5.2])
            #cube([ancho_usb/4, ancho_usb/2, ancho_pared+2]);

        //Texto
        translate([(placa_x+ancho_pared*2)/2, (placa_y+ancho_pared*2)/2, (placa_z+ancho_tapa*2)-1])
            rotate([0, 0, 90])
                #linear_extrude(height = 4) {text("IIBM", font = "Arial", size=22,$fn=25, halign="center", valign="center");}
    }
}

tapa();

//module base(){
//    difference(){
//        union(){
//            difference(){
//                cube([placa_x+ancho_pared*2, placa_y+ancho_pared*2, placa_z+ancho_tapa*2]);
//                
//                translate([ancho_pared, ancho_pared, ancho_tapa])
//                    cube([placa_x, placa_y, placa_z]);
//                //Le saco la mitad de arriba
//                translate([0, 0, (placa_z+ancho_tapa*2)/2])
//                    cube([placa_x+ancho_pared*2, placa_y+ancho_pared*2, (placa_z+ancho_tapa*2)/2]);
//                //Aleta para enganchar
//                translate([ancho_pared-1, ancho_pared-1, (placa_z+ancho_tapa*2)/2-5]){
//                    difference(){
//                        cube([placa_x+2.25, placa_y+2.25, 5]);
//                        translate([1, 1, 0])
//                            cube([placa_x, placa_y, 5]);
//                    }
//                }
//            }
//        }
//        //Agujero para el prensacables
//        translate([(placa_x+ancho_pared*2)/2, ancho_pared+2, (placa_z+ancho_tapa*2)/2])
//            rotate([90, 0, 0])
//                cylinder(r=radio_prensacable, h=ancho_pared+4, $fn=50); 
//    }
//}
//
//base();
