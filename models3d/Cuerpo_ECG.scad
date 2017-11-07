margen_error=0.7;

/* Sector que engancha con el cabezal */
radio_exterior_cabezal=22.25;
radio_interior_cabezal=20.75;
alto_interior_cabezal=7;
alto_cabezal=20; //Alto del cilindro donde engancha el cabezal
alto_traba=2;
radio_traba=1.6;

alto_cono=10;

/* Sector donde va la placa */
radio_interior_cuerpo=15;
radio_exterior_cuerpo=18; //3mm de ancho de pared
alto_cuerpo=100-alto_cabezal-alto_cono;

radio_prensacable=8.5; //MEDIR BIEN

radio_esfera_marcador=0.5;

module enganche(){
    for(i=[-15:0]){
        rotate([0, 0, i]){
            translate([radio_interior_cabezal-0.5, 0, alto_interior_cabezal/2])
                rotate([0, 90, 0])
                    cylinder(r=radio_traba, h=alto_traba, $fn=50);
        }    
    }
    
    rotate([0, 0, -15]){
        hull(){
            translate([radio_interior_cabezal-0.5, 0, 0])
                rotate([0, 90, 0])
                    cylinder(r=radio_traba, h=alto_traba, $fn=50);
            translate([radio_interior_cabezal-0.5, 0, alto_interior_cabezal/2])
                rotate([0, 90, 0])
                    cylinder(r=radio_traba, h=alto_traba, $fn=50);
        }
    }
}


module grupo_enganches(){
    //for(i=[0, 120, 240]){
    for(i=[0, 90, 180, 270]){
        rotate([0, 0, i])
            enganche();
    }
}

module guia_placa(){
    translate([0, -3.5, 0]){ 
        difference(){
            cube([5, 7, alto_cuerpo]);
            translate([0, 2, 0])
                cube([2, 3, alto_cuerpo]);
        }
    }   
}

//!guia_placa();

/* Regleta de ángulos */
module regleta(){
    for(i=[0:30:330]){
        rotate([0, 0, i]){
            hull(){
                translate([radio_exterior_cabezal, 0, alto_interior_cabezal+6])
                    sphere(r=radio_esfera_marcador, $fn=50);
                translate([radio_exterior_cabezal, 0, alto_interior_cabezal])
                    sphere(r=radio_esfera_marcador, $fn=50);
            }
        }
    }
    for(i=[0:10:350]){
        rotate([0, 0, i]){
            hull(){
                translate([radio_exterior_cabezal, 0, alto_interior_cabezal+3])
                    sphere(r=radio_esfera_marcador, $fn=50);
                translate([radio_exterior_cabezal, 0, alto_interior_cabezal])
                    sphere(r=radio_esfera_marcador, $fn=50);
            }
        }
    }
}
regleta();

/* Enganche con el cabezal */
difference(){
    cylinder(r=radio_exterior_cabezal, h=alto_cabezal, $fn=50);
    cylinder(r=radio_interior_cabezal, h=alto_cabezal, $fn=50);
    grupo_enganches();
}

/* Transición entre el cabezal y donde va la placa */
translate([0, 0, alto_cabezal]){
    difference(){
        cylinder(r1=radio_exterior_cabezal, r2=radio_exterior_cuerpo, h=alto_cono, $fn=50);
        cylinder(r1=radio_interior_cabezal, r2=radio_interior_cuerpo, h=alto_cono, $fn=50);
    }
}

/* Sector donde va la placa */
translate([0, 0, alto_cabezal+alto_cono]){
    difference(){
        cylinder(r=radio_exterior_cuerpo, h=alto_cuerpo, $fn=50);
        cylinder(r=radio_interior_cuerpo, h=alto_cuerpo, $fn=50);
    }
}

/* Guías para la placa */
translate([radio_interior_cuerpo-4, 0, alto_cabezal+alto_cono])
    guia_placa();
rotate([0, 0, 180]){
    translate([radio_interior_cuerpo-4, 0, alto_cabezal+alto_cono])
        guia_placa();
}

/* Transición entre donde va la placa y el cierre*/
translate([0, 0, alto_cabezal+alto_cono+alto_cuerpo]){
    difference(){
        cylinder(r1=radio_exterior_cuerpo, r2=13, h=5, $fn=50);
        cylinder(r1=radio_interior_cuerpo, r2=10, h=5, $fn=50);
    }
}

/* Cierre con agujero para el prensacables */
translate([0, 0, alto_cabezal+alto_cono+alto_cuerpo+2]){
    difference(){
        cylinder(r=13, h=3, $fn=50);
        cylinder(r=radio_prensacable, h=3, $fn=50);
    }
}
