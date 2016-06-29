//cyntia vilte 6 de Junio version 3.0 Cabezal para ECG(Parte de arriba)

use <electrodo.scad>
fn1=20;
radio_base=20;   
radio_techo=12.1; // radio de la parte de arriba de la base
altura_techo=11;//altura del cilindro de la parte de arriba(techo) 
altura_base=10; //altura del cilindro de la parte de abajo(base)
radio_adentro_base=5.14;//del cilindro con el cual lo diferencio con el cilindro de la base
radio_adentro_techo=3.5;//del cilindro con el cual lo diferencio con el cilindro del techo

      //esto pertenece a la parte en donde iran los cables,abajo de la plaqueta
      
radio_adentro2_techo=8; // radio de la parte de arriba en donde iran cables
altura_techo2=19; // la altura de la parte en donde iran cables
 //utilizo las siguientes variables para formar un hueco en forma de cubo
x_hueco=11.5;
x_hueco2=(radio_techo*2)-3.5; //lo utilizo para el hueco cubico de la parte de arriba
y_hueco=5.45;
z_hueco=16;
            //esta parte es en donde esta el hueco rectangular en la parte de arriba
            
altura2_techo=9.7; //la parte de arriba del techo
ancho_rectangulo=1.8; //el rectangulo que uso para hacer el hueco

union()
 {
  difference()// agujero en la parte de abajo, mas los dos huecos en donde se lo enganchara con la base
     {   
      difference()
       {
        translate([0,0,altura_base+altura_techo]) //aca iran adentro en el hueco cables 
         difference()
          {
           cylinder(r=radio_techo,h=altura_techo2,$fn=fn1); //cilindro de arriba(la parte de afuera)
           translate([0,0,-0.1])
            cylinder(r1=radio_adentro2_techo,r2=(x_hueco/1.75),h=altura_techo2-z_hueco+0.2,$fn=fn1); //cilindro de la parte de adentro
           }  
          translate([-(x_hueco/2),-(y_hueco/2),(altura_base+altura_techo)+altura_techo2-z_hueco]) 
           cube([x_hueco,y_hueco,z_hueco+1]);  //hueco cubico
         }
      translate([0,0,-0.2])
       for(k=[1:30])//para las dos ramificaciones que tendrá para poder sujetarse a la parte de arriba
        rotate([0,0,k*3])
         translate([-radio_techo+2.15,0,altura_techo+altura_base],$fn=fn1)
          cylinder(r=1.31,h=3.7,$fn=fn1);
   
      translate([0,0,-0.2])
       rotate([0,0,180])
        for(k=[1:30])//para las dos ramificaciones que tendrá para poder sujetarse a la parte de arriba
         rotate([0,0,k*3])
          translate([-radio_techo+2.15,0,altura_techo+altura_base])
           cylinder(r=1.31,h=3.7,$fn=fn1);
      }
  //parte en donde ira la plaqueta
    
  difference()
  {    
   difference()
    {
     translate([0,0,altura_techo/2+altura_techo2])
      difference() //la parte de arriba del techo, va a tener un hueco rectangular
       {
        translate([0,0,(altura_techo/2)+altura_base])
         cylinder(r=radio_techo,h=altura2_techo,$fn=fn1); //la parte de arriba de altura_adentro_techo
        translate([-radio_techo,-(ancho_rectangulo/2),altura_base+(altura_techo/2)])
         cube([radio_techo*2,ancho_rectangulo,altura2_techo+0.5]);  //es el hueco rectangular
       }
       
   //este hueco se encuentra en la parte de arriba(en el hueco en donde ira la plaqueta)
   
     translate([-(x_hueco/2),-(ancho_rectangulo/2),altura_base+altura_techo2+altura_techo-0.2])
      cube([x_hueco,ancho_rectangulo,1]);
    }
    translate([-radio_techo+1.75,-(y_hueco/2),(altura_base+altura_techo)+altura_techo2-0.2]) 
     cube([x_hueco2,y_hueco,altura2_techo+0.5]);  //hueco cubico
  }
 }
