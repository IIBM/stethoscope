// Éste lo uso para que forme parte de: Cabezal para ECG(Parte de abajo, con 8 electrodos)

radio_base_electrodo=4.30;//radio de la base
radio_arriba_electrodo=1.5;//es el radio de la parte de arriba del electrodo
radio_esfera=2.35; //es el radio de la esfera de la punta del electrodo
altura_electrodo=4.30;
altura_abajo_electrodo=1.20+0.1; //la altura de la base del electrodo
altura_arriba_electrodo=altura_electrodo-altura_abajo_electrodo+0.2;
altura_arriba=(altura_abajo_electrodo/2)+altura_arriba_electrodo;
fn1=100;

  module electrodo() 
  translate([0,0,-0.1])
   {
    translate([0,0,altura_abajo_electrodo/2])
     union() //esta union se utiliza para el hueco en donde va el electrodo
     {
      cylinder(r=radio_base_electrodo,h=altura_abajo_electrodo,$fn=fn1,center=true);//cilindro en la base
   
      translate([0,0,altura_abajo_electrodo/2])
       cylinder(r=radio_arriba_electrodo,h=(altura_arriba_electrodo-radio_esfera),$fn=fn1);
  
      translate([0,0,altura_arriba-radio_esfera])
       sphere(r=radio_esfera,$fn=fn1);//la esfera que esta en del electrodo
     }
    }
