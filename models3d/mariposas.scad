margen_error=0.7;

//Tuercas M3
radio_tuercas_M3=3+(margen_error/2);
alto_tuerca_M3=2.3;
alto_hexagono_tuerca_ciega_M3=3;
radio_tornillo_M3=1.5+(margen_error/2);


//Tuerca, tuerca ciega y tornillo M3
module tuerca_M3(){
    cylinder(r=radio_tuercas_M3, h=alto_tuerca_M3, $fn=6);
}


module tornillo_M3(){
    cylinder(r=radio_tornillo_M3, h=25, $fn=50);
}

difference(){
    cylinder(r=4.5, h=3, $fn=50);
    translate([0, 0, 3-alto_tuerca_M3])
        tuerca_M3();
    tornillo_M3();
}
    
    
