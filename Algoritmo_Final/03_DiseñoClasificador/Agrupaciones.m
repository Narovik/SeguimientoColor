%% Comparacion kmeans matlab y propio
clear all, clc;
load './02_Extraer_Representar_Datos/VariablesGeneradas/ConjuntoDatos.mat';

valoresY = unique(Y);
FoI = (Y==1); %Filas de interes: objeto
XObjeto = X(FoI, :);

k=4;
idx = funcion_kmeans(XObjeto,k);
idxM = kmeans(XObjeto,k);

%Comprobacion todos los intervalos ok
stats = [];
statsM =[];
for i=1:k
   stats = [stats; i size(find(idx==i),1)];
   statsM = [statsM; i size(find(idxM==i),1)];
end

% Identificador y numero de muestras por agrupacion
stats
statsM





