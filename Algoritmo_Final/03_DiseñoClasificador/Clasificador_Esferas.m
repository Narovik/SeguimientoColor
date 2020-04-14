
clear all, clc;
load './02_Extraer_Representar_Datos/VariablesGeneradas/ConjuntoDatos.mat';

valoresY = unique(Y);
FoI = (Y==1); %Filas de interes: objeto
XObjeto = X(FoI, :);

k=4; % Numero de agrupaciones
idx = funcion_kmeans(XObjeto,k);

%Representacion
representa_datos_fondo(X,Y), hold on
representa_datos_color_seguimiento_por_agrupacion(XObjeto,idx);

