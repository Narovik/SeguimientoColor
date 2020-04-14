
clear all, clc;
load './02_Extraer_Representar_Datos/VariablesGeneradas/ConjuntoDatos.mat';

valoresY = unique(Y);
FoI = (Y==1); %Filas de interes: objeto
XObjeto = X(FoI, :);
XFondo = X(Y==0, :);

k=4; % Numero de agrupaciones
idx = funcion_kmeans(XObjeto,k);
numAgrupaciones = length(unique(idx)); 


datosMultiplesEsferas = zeros(numAgrupaciones, 6);
for i=1:numAgrupaciones
 
    XAgrupacion = XObjeto(idx==i,:);
    
    %Nuevo conjunto de datos X
    X_new = [XAgrupacion ; XFondo];
    
    %Nuevo conjunto de datos Y
    Y_new = [ones(size(XAgrupacion,1),1) ; zeros(size(XFondo,1),1)];
    
    % Calcular datos de esa agrupacion
    datosEsfera = calcula_datos_esfera(X_new, Y_new);
    
    % Añadirla a la solucion
    datosMultiplesEsferas(i,:) = datosEsfera;
    
    
end

save('03_DiseñoClasificador/VariablesGeneradas/datosMultiplesEsferas.mat', 'datosMultiplesEsferas');


%Representacion
coloresEsferas = [".g" ".m" ".y"];

for r=4:6
    representa_datos_fondo(X,Y), hold on
    representa_datos_color_seguimiento_por_agrupacion(XObjeto,idx), hold on
    for i=1:numAgrupaciones
        representa_esfera(datosMultiplesEsferas(i,1:3), datosMultiplesEsferas(i,r), coloresEsferas(r-3)), hold on;
    end
end

% for i=1:length(radios)
%    representa_datos_color_seguimiento_fondo(X,Y);
%    hold on, , hold off
%    title(['Esfera de Radio: ' num2str(radios(i))])
% end

