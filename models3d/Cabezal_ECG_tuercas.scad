margen_error=0.5;

radio_tuercas=3+(margen_error/2);
alto_hexagono_tuerca_ciega=4.5;
radio_tornillo=1.5+(margen_error/2);

radio_exterior_cabezal=22;
radio_interior_cabezal=20;
alto_exterior_cabezal=5;
alto_interior_cabezal=7;
alto_total_cabezal=alto_exterior_cabezal+alto_interior_cabezal;

radio_ubicacion_electrodos=16; //Radio en el que van a estar los electrodos respecto del centro del cabezal
separacion_electrodo=7; //Distancia más chica de un electrodo al eje
angulo_RL=225;

radio_microfono=5;
alto_microfono=10;
radio_cable_microfono=2.5;


echo("Diametro tuercas",radio_tuercas*2);
echo("Diametro tornillo",radio_tornillo*2);
echo("altura total del cabezal=",alto_total_cabezal);

module tuerca(){
    cylinder(r=radio_tuercas, h=2.3, $fn=6);
}

module tuerca_ciega(){
    cylinder(r=radio_tuercas, h=alto_hexagono_tuerca_ciega, $fn=6);
    translate([0, 0, alto_hexagono_tuerca_ciega]) cylinder(r1=2.5, r2=1.5, h=3, $fn=50);
}

module tornillo(){
    cylinder(r=radio_tornillo, h=25, $fn=50);
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

module electrodo(){
    rotate([180, 0, 30])
        translate([0, 0, -alto_hexagono_tuerca_ciega])
            tuerca_ciega();
    rotate([0, 0, 30])
        translate([0, 0, alto_total_cabezal-2.3])
            tuerca();
    tornillo();
}

module grupo_de_electrodos(){
    angulo_electrodo=acos(separacion_electrodo/radio_ubicacion_electrodos);
    for(i=[angulo_electrodo,90-angulo_electrodo, 90+angulo_electrodo, angulo_RL, 360-angulo_electrodo]){
        rotate([0, 0, i])
            translate([radio_ubicacion_electrodos, 0, 0])
               electrodo();
    }
}

//difference(){
    %cabezal();
    microfono();
    grupo_de_electrodos();
//}
