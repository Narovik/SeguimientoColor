function representa_datos_color_seguimiento(X,Y)

colorClases{1} = '.green';

%% 2.2.1 Representacion en el espacio RGB

figure, hold on;

    
filasClase = (Y==1);

ValoresR = X(filasClase,1);
ValoresG = X(filasClase,2);
ValoresB = X(filasClase,3);

plot3(ValoresR, ValoresG, ValoresB, string('.green'));
    



xlabel('Componente Roja'), ylabel('Componente Verde'), zlabel('Componente Azul');
ValorMin = 0; ValorMax = 255;
axis([ValorMin ValorMax ValorMin ValorMax ValorMin ValorMax]);
legend('Datos Color');


end
