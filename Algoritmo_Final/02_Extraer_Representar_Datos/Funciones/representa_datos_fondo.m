function representa_datos_fondo(X,Y)

colorClases{1} = '.red';

%% 2.2.1 Representacion en el espacio RGB

figure, hold on;

    
filasClase = (Y==0);

ValoresR = X(filasClase,1);
ValoresG = X(filasClase,2);
ValoresB = X(filasClase,3);

plot3(ValoresR, ValoresG, ValoresB, string('.red'));
    

xlabel('Componente Roja'), ylabel('Componente Verde'), zlabel('Componente Azul');
ValorMin = 0; ValorMax = 255;
axis([ValorMin ValorMax ValorMin ValorMax ValorMin ValorMax]);
legend('Datos Fondo');


end
