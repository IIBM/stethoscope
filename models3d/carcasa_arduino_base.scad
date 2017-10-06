placa_x=54;
placa_y=69; //56 + lugar para el prensacables
placa_z=25;

ancho_tapa=2;
ancho_pared=3;
alto_tapa=14;
radio_prensacable=8.5;

ancho_usb=11.5;
alto_usb=8;

difference(){
    %cube([placa_x+ancho_pared*2, placa_y+ancho_pared*2, placa_z+ancho_tapa*2]);
    
    translate([ancho_pared, ancho_pared, ancho_tapa])
        cube([placa_x, placa_y, placa_z]);
    //translate([0.5*ancho_pared, 0.5*ancho_pared, alto_tapa-4])
    //    cube([placa_x+ancho_pared, placa_y+ancho_pared, 4]);
    translate([(placa_x+ancho_pared*2)/2, ancho_pared+1, (placa_z+ancho_tapa*2)/2])
        rotate([90, 0, 0])
            #cylinder(r=radio_prensacable, h=ancho_pared+2, $fn=50);
}

translate([ancho_pared+10, placa_y-1, 16])
    #cube([ancho_usb, alto_usb, ancho_pared+2]);

