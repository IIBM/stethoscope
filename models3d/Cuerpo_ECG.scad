margen_error=0.7;

radio_exterior_cabezal=22;
radio_interior_cabezal=20.5;
alto_exterior_cabezal=5;
alto_interior_cabezal=7;
alto_total_cabezal=alto_exterior_cabezal+alto_interior_cabezal;

alto_traba=2;
radio_traba=1.5;



module traba(){
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

//!traba();

//Trabas
module grupo_trabas(){
    //for(i=[0, 120, 240]){
    for(i=[0, 90, 180, 270]){
        rotate([0, 0, i])
            traba();
    }
}

//!grupo_trabas();

difference(){
    cylinder(r=radio_exterior_cabezal, h=alto_interior_cabezal, $fn=50);
    cylinder(r=radio_interior_cabezal, h=alto_interior_cabezal, $fn=50);
    grupo_trabas();
}

