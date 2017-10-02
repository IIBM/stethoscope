margen_error=0.7;

/* Sector que engancha con el cabezal */
radio_exterior_cabezal=22;
radio_interior_cabezal=20.5;
alto_interior_cabezal=7;
alto_cabezal=10; //Alto del cilindro donde engancha el cabezal
alto_traba=2;
radio_traba=1.5;

alto_cono=10;

/* Sector donde va la placa */
radio_interior_cuerpo=15;
radio_exterior_cuerpo=15+radio_exterior_cabezal-radio_interior_cabezal;
alto_cuerpo=105-alto_cabezal-alto_cono;

radio_prensacable=8; //MEDIR BIEN


module enganche(){
    for(i=[-10:0]){
        rotate([0, 0, i]){
            translate([radio_interior_cabezal-0.5, 0, alto_interior_cabezal/2])
                rotate([0, 90, 0])
                    cylinder(r=radio_traba, h=alto_traba, $fn=50);
        }    
    }
    
    rotate([0, 0, -10]){
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
    translate([0, -2.5, 0]){ 
        difference(){
            cube([5, 5, alto_cuerpo]);
            translate([0, 1, 0])
                cube([2, 3, alto_cuerpo]);
        }
    }   
}

//!guia_placa();

difference(){
    cylinder(r=radio_exterior_cabezal, h=alto_cabezal, $fn=50);
    cylinder(r=radio_interior_cabezal, h=alto_cabezal, $fn=50);
    grupo_enganches();
}

translate([0, 0, alto_cabezal]){
    difference(){
        cylinder(r1=radio_exterior_cabezal, r2=radio_exterior_cuerpo, h=alto_cono, $fn=50);
        cylinder(r1=radio_interior_cabezal, r2=radio_interior_cuerpo, h=alto_cono, $fn=50);
    }
}

translate([0, 0, alto_cabezal+alto_cono]){
    difference(){
        cylinder(r=radio_exterior_cuerpo, h=alto_cuerpo, $fn=50);
        cylinder(r=radio_interior_cuerpo, h=alto_cuerpo, $fn=50);
    }
}

translate([0, 0, alto_cabezal+alto_cono+alto_cuerpo]){
    difference(){
        cylinder(r=radio_exterior_cuerpo, h=3, $fn=50);
        cylinder(r=radio_prensacable, h=3, $fn=50);
    }
}

translate([radio_interior_cuerpo-4, 0, alto_cabezal+alto_cono])
    guia_placa();

rotate([0, 0, 180]){
    translate([radio_interior_cuerpo-4, 0, alto_cabezal+alto_cono])
        guia_placa();
}

