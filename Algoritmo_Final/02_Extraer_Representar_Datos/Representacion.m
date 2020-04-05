clear all, clc;

% Cargar el conjunto de datos de forma variable
Color = 'naranja';
sentenciaTexto = ['load ConjuntoDatos_' Color '.mat']; %Concatena
eval(sentenciaTexto); %Ejecuta

numDatos = size(X,1);
numClases = length(unique(Y));

nombreClases{1} = {'Muestras del color de fondo de la escena'};
nombreClases{2} = {'Muestras del color de seguimiento'};
colorClases{1} = '.black'; colorClases{2} = '.r';

%% 2.2.1 Representacion en el espacio RGB

figure, hold on;
for clase=1:numClases
    
    filasClase = (Y==clase-1);

    ValoresR = X(filasClase,1);
    ValoresG = X(filasClase,2);
    ValoresB = X(filasClase,3);

    plot3(ValoresR, ValoresG, ValoresB, string(colorClases{clase}));
    
end


xlabel('Componente Roja'), ylabel('Componente Verde'), zlabel('Componente Azul');
ValorMin = 0; ValorMax = 255;
axis([ValorMin ValorMax ValorMin ValorMax ValorMin ValorMax]);
legend('Datos Fondo', 'Datos Color');



