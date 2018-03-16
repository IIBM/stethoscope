margen_error=0.7;

//Conector
radio_cuerpo=1.3+(margen_error/2);
alto_cuerpo=20;


//Tuercas M3
 
radio_tuercas=3+(margen_error/2);
radio_menor_tuercas=sqrt(3)*radio_tuercas;
alto_tuerca=2.3;
radio_tornillo=1.5+(margen_error/2);


//Tuercas M4 
/*
radio_tuercas=3.85+(margen_error/2);
radio_menor_tuercas=sqrt(3)*radio_tuercas;
alto_tuerca=3.1;
radio_tornillo=2+(margen_error/2);
*/

radio_exterior_cabezal=22;
radio_interior_cabezal=10;
alto_exterior_cabezal=15;
alto_interior_cabezal=25;
alto_total_cabezal=alto_exterior_cabezal+alto_interior_cabezal;

radio_ubicacion_electrodos=16; //Radio en el que van a estar los electrodos respecto del centro del cabezal
separacion_electrodo=7; //Distancia más chica de un electrodo al eje. Poner en 0 para electrodos sobre los ejes
angulo_RL=225;


/*
echo("Diametro tuercas",radio_tuercas*2);
*/
module tuerca(){
        cylinder(r=radio_tornillo, h=10, $fn=50, center=true);
        translate([-5, 0, 0])
            cube([10, radio_menor_tuercas, alto_tuerca], center=true);
        rotate([0, 0, 0])
            cylinder(r=radio_tuercas, h=alto_tuerca, $fn=6, center=true);
}

//!tuerca_M4();
module conector(){
    translate([0, 0, -5])
        cylinder(r=radio_cuerpo, h=alto_cuerpo, $fn=50);
}


module cabezal(){
    cylinder(r=radio_exterior_cabezal, h=alto_exterior_cabezal, $fn=50);
    translate([0, 0, alto_exterior_cabezal])
        cylinder(r=radio_interior_cabezal, h=alto_interior_cabezal, $fn=50);
}


//!grupo_de_electrodos_M4();
module grupo_de_electrodos(){
    angulo_electrodo=acos(separacion_electrodo/radio_ubicacion_electrodos);
    for(i=[0, 120, 240]){
        rotate([0, 0, i])
            translate([0, radio_ubicacion_electrodos, 0])
               conector();
    }
}


module grupo_tuercas(){
    angulo_electrodo=acos(separacion_electrodo/radio_ubicacion_electrodos);
    for(i=[0, 120, 240]){
        rotate([0, 0, i])
            translate([0, radio_ubicacion_electrodos+3.5, alto_exterior_cabezal/2])
                rotate([90, 90, 0])
                    tuerca();
    }
}
/*
!union(){
    %cabezal();
grupo_de_electrodos();
grupo_tuercas();
}
*/
difference(){
    cabezal();
    grupo_de_electrodos();
    grupo_tuercas();
}

