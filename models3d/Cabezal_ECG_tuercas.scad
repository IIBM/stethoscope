margen_error=0.7;

//Tuercas M3
radio_tuercas_M3=3+(margen_error/2);
alto_tuerca_M3=2.3;
alto_hexagono_tuerca_ciega_M3=3;
radio_tornillo_M3=1.5+(margen_error/2);

//Tuercas M4 
radio_tuercas_M4=3.85+(margen_error/2);
alto_tuerca_M4=3.1;
//alto_hexagono_tuerca_ciega_M4=5.5;
alto_hexagono_tuerca_ciega_M4=4.5;
radio_tornillo_M4=2+(margen_error/2);

radio_exterior_cabezal=22;
radio_interior_cabezal=20;
alto_exterior_cabezal=5;
alto_interior_cabezal=7;
alto_total_cabezal=alto_exterior_cabezal+alto_interior_cabezal;

radio_ubicacion_electrodos=16; //Radio en el que van a estar los electrodos respecto del centro del cabezal
separacion_electrodo=0; //Distancia más chica de un electrodo al eje. Poner en 0 para electrodos sobre los ejes
//angulo_RL=225;

radio_microfono=5;
alto_microfono=10;
radio_cable_microfono=2.5;

/*
echo("Diametro tuercas",radio_tuercas*2);
echo("Diametro tornillo",radio_tornillo*2);
echo("altura total del cabezal=",alto_total_cabezal);
*/

//Tuerca, tuerca ciega y tornillo M3
module tuerca_M3(){
    cylinder(r=radio_tuercas_M3, h=alto_tuerca_M3, $fn=6);
}

module tuerca_ciega_M3(){
    cylinder(r=radio_tuercas_M3, h=alto_hexagono_tuerca_ciega_M3, $fn=6);
    translate([0, 0, alto_hexagono_tuerca_ciega_M3]) cylinder(r1=2.5, r2=1.5, h=3, $fn=50);
}

module tornillo_M3(){
    cylinder(r=radio_tornillo_M3, h=25, $fn=50);
}


//Tuerca, tuerca ciega y tornillo M4
module tuerca_M4(){
    cylinder(r=radio_tuercas_M4, h=alto_tuerca_M4, $fn=6);
}

module tuerca_ciega_M4(){
    cylinder(r=radio_tuercas_M4, h=alto_hexagono_tuerca_ciega_M4, $fn=6);
    translate([0, 0, alto_hexagono_tuerca_ciega_M4]) cylinder(r1=2.5, r2=1.5, h=3, $fn=50);
}

module tornillo_M4(){
    cylinder(r=radio_tornillo_M4, h=25, $fn=50);
}


module microfono(){
    cylinder(r=radio_microfono, h=alto_microfono, $fn=50);
    cylinder(r=radio_cable_microfono, h=alto_total_cabezal, $fn=50);
}


module cabezal(){
    cylinder(r=radio_exterior_cabezal, h=alto_exterior_cabezal, $fn=50);
    translate([0, 0, alto_exterior_cabezal])
        cylinder(r=radio_interior_cabezal, h=alto_interior_cabezal, $fn=50);
}

//Electrodo M3
module electrodo_M3(){
    rotate([180, 0, 30])
        translate([0, 0, -alto_hexagono_tuerca_ciega_M3])
            tuerca_ciega_M3();
    rotate([0, 0, 30])
        translate([0, 0, alto_total_cabezal-alto_tuerca_M3])
            tuerca_M3();
    tornillo_M3();
}

//Electrodo M4
module electrodo_M4(){
    rotate([180, 0, 30])
        translate([0, 0, -alto_hexagono_tuerca_ciega_M4])
            tuerca_ciega_M4();
    rotate([0, 0, 30])
        translate([0, 0, alto_total_cabezal-alto_tuerca_M4])
            tuerca_M4();
    tornillo_M4();
}

module grupo_de_electrodos_M3(){
    angulo_electrodo=acos(separacion_electrodo/radio_ubicacion_electrodos)+45;
    //for(i=[angulo_electrodo,90-angulo_electrodo, 90+angulo_electrodo, angulo_RL, 360-angulo_electrodo]){
    for(i=[angulo_electrodo,90+angulo_electrodo, 180+angulo_electrodo, 270+angulo_electrodo]){
        rotate([0, 0, i])
            translate([radio_ubicacion_electrodos, 0, 0])
               electrodo_M3();
    }
}

module grupo_de_electrodos_M4(){
    angulo_electrodo=acos(separacion_electrodo/radio_ubicacion_electrodos);
    //for(i=[angulo_electrodo,90-angulo_electrodo, 90+angulo_electrodo, angulo_RL, 360-angulo_electrodo]){
    for(i=[angulo_electrodo,90-angulo_electrodo, 90+angulo_electrodo, 360-angulo_electrodo]){
        rotate([0, 0, i])
            translate([radio_ubicacion_electrodos, 0, 0])
               electrodo_M4();
    }
}


difference(){
    cabezal();
    microfono();
    grupo_de_electrodos_M4();
    grupo_de_electrodos_M3();
}

