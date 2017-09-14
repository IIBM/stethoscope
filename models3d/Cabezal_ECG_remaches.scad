margen_error=0.5;

//Remache
radio_cuerpo=2.4+(margen_error/2);
alto_cuerpo=12.5;
alto_cabeza=2;
radio_cabeza=4.5+(margen_error/2);

//Tuercas M4 
radio_tuercas_M4=3.85+(margen_error/2);
alto_tuerca_M4=3.1;
//alto_hexagono_tuerca_ciega_M4=5.5;
alto_hexagono_tuerca_ciega_M4=4.5;
radio_tornillo_M4=2+(margen_error/2);

radio_exterior_cabezal=22;
radio_interior_cabezal=20.5;
alto_exterior_cabezal=5;
alto_interior_cabezal=3.5;
alto_total_cabezal=alto_exterior_cabezal+alto_interior_cabezal;

radio_ubicacion_electrodos=16; //Radio en el que van a estar los electrodos respecto del centro del cabezal
separacion_electrodo=7; //Distancia más chica de un electrodo al eje. Poner en 0 para electrodos sobre los ejes
angulo_RL=225;

radio_microfono=5;
alto_microfono=10;
radio_cable_microfono=2.5;

/*
echo("Diametro tuercas",radio_tuercas*2);
*/
module tuerca_M4(){
    cylinder(r=radio_tornillo_M4, h=alto_total_cabezal, $fn=50);
    rotate([0, 0, 30])
        translate([0, 0, alto_total_cabezal-alto_tuerca_M4])
            cylinder(r=radio_tuercas_M4, h=alto_tuerca_M4, $fn=6);
}

module electrodo_M4(){
    rotate([180, 0, 30])
        translate([0, 0, -alto_hexagono_tuerca_ciega_M4])
            tuerca_ciega_M4();
            tuerca_M4();
    tornillo_M4();
}


module remache(){
    cylinder(r=radio_cuerpo, h=alto_cuerpo, $fn=50);
    rotate([180, 0, 0])
            cylinder(r1=radio_cabeza, r2=0, h=alto_cabeza, $fn=50);
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

/*
module grupo_de_electrodos_M4(){
    angulo_electrodo=90;//Electrodos a 90 grados
    //angulo_electrodo=120;//Electrodos a 60 grados
    for(i=[0,-angulo_electrodo, +angulo_electrodo]){
        rotate([0, 0, i])
            translate([radio_ubicacion_electrodos, 0, 0])
               electrodo_M4();
    }
}
*/
//!grupo_de_electrodos_M4();
module grupo_de_electrodos(){
    angulo_electrodo=acos(separacion_electrodo/radio_ubicacion_electrodos);
    //for(i=[angulo_electrodo,90-angulo_electrodo, 90+angulo_electrodo, 360-angulo_electrodo]){
    for(i=[0, 120, 240]){
    //for(i=[angulo_electrodo,90-angulo_electrodo, 90+angulo_electrodo, 360-angulo_electrodo, angulo_RL]){
        rotate([0, 0, i])
            translate([radio_ubicacion_electrodos, 0, 0])
               remache();
    }
}

difference(){
    cabezal();
    microfono();
    #grupo_de_electrodos();
    /*
    rotate([0, 0, angulo_RL])
        //translate([-((radio_exterior_cabezal-radio_microfono)/2+radio_microfono), 0, -alto_cilindro_cabeza_bulon])
        translate([radio_ubicacion_electrodos, 0, 0])
            tuerca_M4();
    */
}

