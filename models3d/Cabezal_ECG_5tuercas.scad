margen_error=0.7;

//Tuercas M4 
radio_tuercas_M4=3.85+(margen_error/2);
alto_tuerca_M4=3.1;
//alto_hexagono_tuerca_ciega_M4=5.5;
alto_hexagono_tuerca_ciega_M4=4;
radio_tornillo_M4=2+(margen_error/2);

radio_exterior_cabezal=22;
radio_interior_cabezal=20.5;
alto_exterior_cabezal=5;
alto_interior_cabezal=7;
alto_total_cabezal=alto_exterior_cabezal+alto_interior_cabezal;

radio_ubicacion_electrodos=16; //Radio en el que van a estar los electrodos respecto del centro del cabezal
separacion_electrodo=7; //Distancia más chica de un electrodo al eje. Poner en 0 para electrodos sobre los ejes
angulo_RL=225;

radio_microfono=5;
alto_microfono=10;
radio_cable_microfono=2.5;

radio_esfera_marcador=0.7;

alto_traba=2;
radio_traba=1.5;

/*
echo("Diametro tuercas",radio_tuercas*2);
*/


//Tuerca, tuerca ciega y tornillo M4
module tuerca_M4(){
    cylinder(r=radio_tuercas_M4, h=alto_tuerca_M4, $fn=6);
}


module tuerca_ciega_M4(){
    cylinder(r=radio_tuercas_M4, h=alto_hexagono_tuerca_ciega_M4, $fn=6);
    translate([0, 0, alto_hexagono_tuerca_ciega_M4]) cylinder(r1=3, r2=1.5, h=3.5, $fn=50);
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

//Electrodo M4
module electrodo_M4(){
    rotate([180, 0, 30])
        translate([0, 0, -alto_hexagono_tuerca_ciega_M4])
            tuerca_ciega_M4();
    //rotate([0, 0, 30])
    //   translate([0, 0, alto_total_cabezal-alto_tuerca_M4])
    //        tuerca_M4();
    tornillo_M4();
}

//Electrodo bulón
/*
module electrodo_bulon(){
    cylinder(r=radio_cabeza_bulon, h=alto_cilindro_cabeza_bulon, $fn=50);
    rotate([-180, 0, 0])
        cylinder(r1=radio_cabeza_bulon, r2=0, h=3, $fn=50);
    translate([-lado_traba_bulon/2, -lado_traba_bulon/2, alto_cilindro_cabeza_bulon])
        cube([lado_traba_bulon, lado_traba_bulon, alto_traba_bulon]);
    translate([0, 0, alto_cilindro_cabeza_bulon+alto_traba_bulon])
        cylinder(r=radio_tornillo_bulon, h=alto_tornillo_bulon, $fn=50);
}
*/
module grupo_de_electrodos_M4(){
    angulo_electrodo=acos(separacion_electrodo/radio_ubicacion_electrodos);
    //for(i=[angulo_electrodo,90-angulo_electrodo, 90+angulo_electrodo, 360-angulo_electrodo]){
    for(i=[angulo_electrodo,90-angulo_electrodo, 90+angulo_electrodo, 360-angulo_electrodo,angulo_RL]){
        rotate([0, 0, i])
            translate([radio_ubicacion_electrodos, 0, 0])
               electrodo_M4();
    }
}

//!grupo_de_electrodos_M4();

//Cuña para redondear la parte del cabezal que hace contacto con la piel
module cunia(){
    rotate_extrude(convexity = 10, $fn = 50)
        translate([-(radio_exterior_cabezal-2.5), 2.5, 0]){
            difference(){
                square(size = 5, center = true); 
                circle(r = 2.5, $fn = 50);
                square(size = 5); 
                translate([-5, 0, 0])
                    square(size = 5); 
                translate([0, -5, 0])
                    square(size = 5); 
            }
        }
}

//Trabas
module trabas(){
    //for(i=[0, 120, 240]){
    for(i=[0, 90, 180, 270]){
        rotate([0, 0, i])
            translate([radio_interior_cabezal-0.5, 0, alto_exterior_cabezal+(alto_interior_cabezal/2)])
        rotate([0, 90, 0])
                cylinder(r=radio_traba, h=alto_traba, $fn=50);
    }
}

//Marcadores para poder armar el cabezal según la regleta de ángulos
module marcadores(){
    for(i=[0, 90, 180, 270]){
        rotate([0, 0, i])
            translate([radio_exterior_cabezal, 0, alto_exterior_cabezal-radio_esfera_marcador])
                sphere(r=radio_esfera_marcador, $fn=50);
    }
}

difference(){
    cabezal();
    //microfono();
    //grupo_de_electrodos_M4();
    rotate([0, 0, angulo_RL])
        translate([radio_ubicacion_electrodos, 0, alto_total_cabezal-(alto_tuerca_M4/2)])
            cube([10, 10, alto_tuerca_M4], center=true);
    cunia();
    cylinder(r=radio_ubicacion_electrodos+radio_tuercas_M4-1,h=alto_total_cabezal, $fn=50);
}
marcadores();
trabas();
