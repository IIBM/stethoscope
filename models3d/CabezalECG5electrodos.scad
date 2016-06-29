//cyntia vilte 10 de Junio version 4.0 Cabezal para ECG(Parte de abajo, con 5 electrodos)

fn1=20;
radio_base=22;   
radio_techo=12.1; // radio de la parte de arriba de la base
altura_techo=11;//altura del cilindro de la parte de arriba(techo) 
altura_base=10; //altura del cilindro de la parte de abajo(base)
radio_adentro_base=5.14;//del cilindro con el cual lo diferencio con el cilindro de la base
radio_adentro_techo=3.5;//del cilindro con el cual lo diferencio con el cilindro del techo
radio_cable=1.15; // radio del espacio en donde ira el cable 

                 //para un electrodo mas grande
                 
 radio_electrodo2=6.4;
 altura_electrodo2=2.6;
 radio_esfera=2.5; 
 altura_electrodo=radio_esfera+altura_electrodo2; //medicion del electrodo eje z
 
desplazamiento_electrodo=3;// la distancia que se desplaza el electrodo del borde de la base 
desplazamiento2=(radio_techo-radio_adentro_base)/2; //lo uso en la ecuacion del angulo_desplazamiento para desplazar el espacio del cable en el medio
desplazamiento_cable=radio_base-desplazamiento_electrodo; //la distancia que toma el espacio en donde va el cable


echo("desp=",desplazamiento_cable);

angulo_desplazamiento=atan((altura_base-altura_electrodo)/(desplazamiento_cable-radio_adentro_base-desplazamiento2-5.2)); //angulo que toman los espacios en donde iran los cables de los electrodos

echo("angulo=",angulo_desplazamiento);

largo_cable=((desplazamiento_cable-radio_adentro_base)/(cos(angulo_desplazamiento)));//es lo que mide el espacio en donde ira el cable, desde el electrodo hasta el radio_adentro_techo

      //esta parte pertence al espacio en donde ira el electrodo
 
radio_base_electrodo=4.20;//radio de la base
radio_arriba_electrodo=1.5;//es el radio de la parte de arriba del electrodo
radio_esfera=2; //es el radio de la esfera de la punta del electrodo
altura_abajo_electrodo=1.20; //la altura de la base del electrodo
altura_arriba_electrodo=altura_electrodo-altura_abajo_electrodo+0.2; 
altura_arriba=(altura_abajo_electrodo/2)+altura_arriba_electrodo; //lo utilizo para la posicion de la esfera

union()
 {
  difference()//hace los espacios para que pasen los cables
  {
   difference()//hace los espacios en donde iran los electrodos
    {
     union() //une el cilindro de arriba con el de abajo
      {
       difference() //forma el agujero en el cilindro(techo)
        {
         translate([0,0,altura_base])
          cylinder(r=radio_techo,h=altura_techo,$fn=fn1);// cilindro de la parte de arriba
         translate([0,0,altura_base-0.5]) 
          cylinder(r=radio_adentro_techo,h=altura_techo+1.1,$fn=fn1);//utilizo este cilindro para hacer un hueco en la parte de arriba
         }
       difference()//forma el agujero en la base  
        {
         cylinder(r=radio_base,h=altura_base,$fn=fn1);// cilindro de la base
         translate([0,0,-1]) 
          cylinder(r=radio_adentro_base,h=altura_base+1.1,$fn=fn1);//utilizo este cilindro para hacer un hueco en la parte de la base
        }
       }
  // esta parte hace el electrodo que esta solo a 225
     translate([desplazamiento_electrodo/10,0,(altura_electrodo2/2)-0.2])
      rotate([0,0,225])
       translate([radio_base-radio_electrodo2-(desplazamiento_electrodo/2),0,0])
        union()
         {
          cylinder(r=radio_electrodo2,h=altura_electrodo2,center=true,$fn=fn1);//espacio para que entre el electrodo
          translate([0,0,radio_esfera])
           sphere(r=radio_esfera,$fn=fn1);
          }  
    // esta parte hace los dos electrodos que estan en el eje y
     translate([0.8,0,(altura_electrodo2/2)-0.2])//mueve los dos electrodos en el eje x
      for(j=[0.5:1.5])
       translate([radio_electrodo2/2,0,0])
        rotate([0,0,180*j])
         translate([radio_base-radio_electrodo2-(desplazamiento_electrodo/2),0,0])
          union()
           {
            cylinder(r=radio_electrodo2,h=altura_electrodo2,center=true,$fn=fn1);//espacio para que entre el electrodo
             translate([0,0,radio_esfera])
              sphere(r=radio_esfera,$fn=fn1);
            }      
       // esta parte hace los dos electrodos que estan en el eje x
     translate([0,0.3,(altura_electrodo2/2)-0.2])//mueve los dos electrodos en el eje y
      for(i=[1:2])
       translate([0,radio_electrodo2/2,0])
        rotate([0,0,180*i])
         translate([radio_base-radio_electrodo2-(desplazamiento_electrodo/2),0,0])
          union()
           {
            cylinder(r=radio_electrodo2,h=altura_electrodo2,center=true,$fn=fn1);//espacio para que entre el electrodo
            translate([0,0,radio_esfera])
             sphere(r=radio_esfera,$fn=fn1);
            }
    }
    //el espacio en donde ira un cable,este ira en el electrodo que esta a 225grados
      rotate([0,0,405])
        translate([-radio_base+radio_electrodo2+1,0,altura_electrodo])
         rotate([0,90-angulo_desplazamiento,0])
          cylinder(r=radio_cable,h=largo_cable,$fn=fn1);
    //los espacios en donde ira un cable, estos iran en los electrodos que estan en el eje x
    translate([0,radio_electrodo2/2,0])
    for(i=[1:2])
     rotate([0,0,180*i])
        translate([-radio_base+radio_electrodo2+1,0,altura_electrodo])
         rotate([0,90-angulo_desplazamiento,0])
          cylinder(r=radio_cable,h=largo_cable,$fn=fn1);
   //los espacios en donde ira un cable, estos iran en los electrodos que estan en el eje y
    translate([radio_electrodo2/2,0,0])
    for(j=[0.5:1.5])
     rotate([0,0,180*j])
       translate([-radio_base+radio_electrodo2+1,0,altura_electrodo])
        rotate([0,90-angulo_desplazamiento,0])
         cylinder(r=radio_cable,h=largo_cable,$fn=fn1);
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
