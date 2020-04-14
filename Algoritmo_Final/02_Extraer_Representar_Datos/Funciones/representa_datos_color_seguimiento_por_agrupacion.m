function representa_datos_color_seguimiento_por_agrupacion(XObjeto,idx)

numAgrupaciones = length(unique(idx));
colores = [".b" ".m" ".c" ".g" ".y" ".k"];
for i=1:numAgrupaciones
    hold on;

    filasClase = idx==i;

    ValoresR = XObjeto(filasClase,1);
    ValoresG = XObjeto(filasClase,2);
    ValoresB = XObjeto(filasClase,3);

    plot3(ValoresR, ValoresG, ValoresB,colores(i));
end
end
