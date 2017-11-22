function e = hp_aptado(ecg, alfa)
% filtro pasa-altos adaptado, para la línea de base

    w = randn;
    x = 1;
    for k = 1:length(ecg)
        y = w * x;
        e(k) = ecg(k) - y;
        w = w + alfa * e(k) * x;
    end;

    escala = 2/(2-alfa);
    e = e / escala;

endfunction
