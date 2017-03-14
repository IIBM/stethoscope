function muestras = leer_muestras(puerto, cant_muestras)
    cant_bytes=cant_muestras*2;

    datos = leer_bytes(puerto, cant_bytes);
    
    for i=1:2:cant_bytes
       muestras(end+1) = typecast(flip(datos(i:i+1)), 'uint16');
    end
end

