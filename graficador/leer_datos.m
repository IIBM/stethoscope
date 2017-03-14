function datos = leer_bytes(puerto, cant_bytes)
    [datos, bytes_leidos]=srl_read(puerto,cant_bytes);
    
    if bytes_leidos < cant_bytes
        datos = [datos leer_bytes(puerto, cant_bytes-bytes_leidos)];
    end
end

