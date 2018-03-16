margen_error=0.7;

//Tuercas EEG 
radio_1_cilindro_EEG=3.7+(margen_error/2);
radio_2_cilindro_EEG=4.5+(margen_error/2);
alto_tuerca_M4=3.1;
alto_cilindro_EEG=5;
radio_tornillo_M4=2+(margen_error/2);

radio_exterior_cabezal=22.25;
radio_interior_cabezal=20.5;
alto_exterior_cabezal=5;
alto_interior_cabezal=7;
alto_total_cabezal=alto_exterior_cabezal+alto_interior_cabezal;

radio_ubicacion_electrodos=16; //Radio en el que van a estar los electrodos respecto del centro del cabezal
separacion_electrodo=7; //Distancia más chica de un electrodo al eje. Poner en 0 para electrodos sobre los ejes
angulo_RL=0;

radio_esfera_marcador=0.7;

alto_traba=2;
radio_traba=1.5;

/*
echo("Diametro tuercas",radio_tuercas*2);
*/


//Tuerca ciega y tornillo M4
module pieza_EEG(){
    cylinder(r1=radio_1_cilindro_EEG, r2=radio_2_cilindro_EEG, h=alto_cilindro_EEG, $fn=50);
    translate([0, 0, alto_cilindro_EEG]) cylinder(r1=3, r2=1.5, h=3.5, $fn=50);
}

module tornillo_M4(){
    cylinder(r=radio_tornillo_M4, h=25, $fn=50);
}

//Cuerpo del cabezal
module cabezal(){
    cylinder(r=radio_exterior_cabezal, h=alto_exterior_cabezal, $fn=50);
    translate([0, 0, alto_exterior_cabezal])
        cylinder(r=radio_interior_cabezal, h=alto_interior_cabezal, $fn=50);
}

//Electrodo M4
module electrodo_EEG(){
    rotate([180, 0, 30])
        translate([0, 0, -alto_cilindro_EEG])
            pieza_EEG();
    tornillo_M4();
}

module grupo_de_electrodos_EEG(){
    //for(i=[angulo_electrodo,90-angulo_electrodo, 90+angulo_electrodo, 360-angulo_electrodo]){
    for(i=[0, 120, 240]){
        rotate([0, 0, i])
            translate([radio_ubicacion_electrodos, 0, 0])
               electrodo_EEG();
    }
}

//!grupo_de_electrodos_EEG();

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
    grupo_de_electrodos_EEG();
    rotate([0, 0, angulo_RL])
        translate([radio_ubicacion_electrodos, 0, alto_total_cabezal-(alto_tuerca_M4/2)])
            cube([12, 10, alto_tuerca_M4], center=true);
    cunia();
    //cylinder(r=radio_ubicacion_electrodos+radio_cilindro_EEG-1,h=alto_total_cabezal, $fn=50);
}
marcadores();
trabas();
