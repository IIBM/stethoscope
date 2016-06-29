//cyntia vilte 13 de Junio version 3.0 Cabezal para ECG(Parte de abajo, con 8 electrodos)

use <electrodo.scad>
fn1=20;
radio_base=20;   
radio_techo=12.1; // radio de la parte de arriba de la base
altura_techo=11;//altura del cilindro de la parte de arriba(techo) 
altura_base=10; //altura del cilindro de la parte de abajo(base)
radio_adentro_base=5.14;//del cilindro con el cual lo diferencio con el cilindro de la base
radio_adentro_techo=3.5;//del cilindro con el cual lo diferencio con el cilindro del techo
radio_cable=1.15; // radio del espacio en donde ira el cable 
altura_electrodo=4.30; //medicion del electrodo eje z

desplazamiento_electrodo=5;// la distancia que se desplaza el electrodo del borde de la base 
desplazamiento2=(radio_techo-radio_adentro_base)/2; //lo uso en la ecuacion del angulo_desplazamiento para desplazar el espacio del cable en el medio
desplazamiento_cable=radio_base-desplazamiento_electrodo; //la distancia que toma el espacio en donde va el cable


echo("desp=",desplazamiento_cable);

angulo_desplazamiento=atan((altura_base-altura_electrodo)/(desplazamiento_cable-radio_adentro_base-desplazamiento2)); //angulo que toman los espacios en donde iran los cables de los electrodos

echo("angulo=",angulo_desplazamiento);

largo_cable=((radio_base-desplazamiento_electrodo)/(cos(angulo_desplazamiento)));//es lo que mide el espacio en donde ira el cable, desde el electrodo hasta el radio_adentro_techo

union() //une la base con las dos patitas
 {
  difference() //diferencia entre la pieza y el espacio en donde van los electrodos
   { 
    difference() //la diferencia entre el cilindro(donde van los cables)y la union del cilindro de arriba con el de abajo
     {
      union() //une el cilindro de arriba con el de abajo
       {
        difference() //forma el agujero en el cilindro(techo)
         {
          translate([0,0,altura_base])
           cylinder(r=radio_techo,h=altura_techo,$fn=fn1);// cilindro de la parte de arriba
          translate([0,0,altura_base-0.5]) 
           cylinder(r=radio_adentro_techo,h=altura_techo+1.1,$fn=fn1);//utilizo este cilindro para hacer un hueco
           }
        difference()//forma el agujero en la base  
         {
          cylinder(r=radio_base,h=altura_base,$fn=fn1);// cilindro de la base
          translate([0,0,-1]) 
           cylinder(r=radio_adentro_base,h=altura_base+1.1,$fn=fn1);//utilizo este cilindro para hacer un hueco
           }
        }
    //los 8 espacios en donde iran los cables
    
      for(i=[1:8])
       rotate([0,0,45*i])
        translate([-desplazamiento_cable,0,altura_electrodo])
         rotate([0,90-angulo_desplazamiento,0])
          cylinder(r=radio_cable,h=largo_cable,$fn=fn1);
       }
    for(j=[1:8]) //es el espacio en donde ira el electrodo
     rotate([0,0,45*j])
      translate([-desplazamiento_cable,0,0])
   electrodo();
  }
 for(k=[1:30])//para las dos ramificaciones que tendrá para poder sujetarse a la parte de arriba
   rotate([0,0,k*3])
    translate([-radio_techo+2.25,0,altura_techo+altura_base])
     cylinder(r=1.2,h=3.5,$fn=fn1);
 
 rotate([0,0,180])
  for(k=[1:30])//para las dos ramificaciones que tendrá para poder sujetarse a la parte de arriba
   rotate([0,0,k*3])
    translate([-radio_techo+2.25,0,altura_techo+altura_base])
     cylinder(r=1.2,h=3.5,$fn=fn1);
  }
