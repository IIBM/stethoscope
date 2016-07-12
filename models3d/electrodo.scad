// Éste lo uso para que forme parte de: Cabezal para ECG(Parte de abajo, con 8 electrodos)
 
radio_base_electrodo=4.30;//radio de la base
radio_arriba_electrodo=1.5;//es el radio de la parte de arriba del electrodo
radio_esfera=2.35; //es el radio de la esfera de la punta del electrodo
altura_electrodo=4.30;
altura_abajo_electrodo=1.20+0.1; //la altura de la base del electrodo
altura_arriba_electrodo=altura_electrodo-altura_abajo_electrodo+0.2;
altura_arriba=(altura_abajo_electrodo/2)+altura_arriba_electrodo;
fn1=100;
rad1=2;
alt1=2;

module electrodo() 
  translate([0,0,-0.1])
 {
  union()
  {   
  translate([0,0,altura_abajo_electrodo/2])
   union() //esta union se utiliza para el hueco en donde va el electrodo
    {
     cylinder(r=radio_base_electrodo,h=altura_abajo_electrodo,$fn=fn1,center=true);//cilindro en la base
     translate([0,0,altura_abajo_electrodo/2])      
      cylinder(r=radio_arriba_electrodo,h=(altura_arriba_electrodo-radio_esfera),$fn=fn1);  
     translate([0,0,altura_arriba-radio_esfera])
      sphere(r=radio_esfera,$fn=fn1);//la esfera que esta en la punta del electrodo
    }
   translate([0.40,0,0.85])
     rotate([0,45,0])
      rotate([90,0,0])
       difference()
        {
         translate([0,rad1-0.5,0])   
          cube([rad1+2,rad1+1,rad1+0.25],center=true); 
         cylinder(r1=rad1,r2=rad1,h=alt1+0.25,$fn=4,center=true);
        } 
   } 
  }
electrodo();
