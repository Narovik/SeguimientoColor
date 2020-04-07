% Cargamos los datos
load 'VariablesGeneradas/ConjuntoDatos_naranja.mat';

% Representacion
representa_datos_color_seguimiento_fondo(X,Y);

XClase = X(Y==1,:); %Valores RGB del color de seguimiento

numDatos = size(XClase, 1);
numAtributos = size(XClase, 2);

%% explicacion del criterio
datosAtributos=[];
for i=1:numAtributos
    
    x = double(XClase(:,i)); % dato del atributo
    
    valor_medio = mean(x);
    desv_tipica = std(x);
    mediana = median(x);
    x_ord = sort(x);
    Q1 = x_ord(round(0.25*numDatos));
    Q3 = x_ord(round(0.75*numDatos));
    
    % rango intercuartilico = Q3-Q1
    datos = [valor_medio; desv_tipica; Q1; mediana; Q3; min(x); max(x)];
    datosAtributos =[datosAtributos datos];
    
    figure,
    subplot(1,2,1), hist(x),
    subplot(1,2,2), boxplot(x);
    %sgtitle(nombreAtributos(i));
    
    
    
end

datosAtributos

% Rango de variación de los valores
%f1 = Q1 - 1.5*(Q3-Q1);
%f2 = Q3 + 1.5*(Q3-Q1);

rangoOutliersAtributos1=[];
rangoOutliersAtributos2=[];
for i=1:numAtributos
    
    x = double(XClase(:,i)); % dato del atributo
    
    valor_medio = mean(x);
    desv_tipica = std(x);

    x_ord = sort(x);
    Q1 = x_ord(round(0.25*numDatos));
    Q3 = x_ord(round(0.75*numDatos));
    rango_intercuartilico = Q3 - Q1;
    
    f1 = Q1-1.5*rango_intercuartilico;
    f2 = Q3+1.5*rango_intercuartilico;
    
    rangoOutliersAtributos1 = [rangoOutliersAtributos1 [f1;f2]];
    
    f1 = valor_medio - 3*desv_tipica;
    f2 = valor_medio + 3*desv_tipica;
    
    rangoOutliersAtributos2 = [rangoOutliersAtributos2 [f1;f2]];
    
end

rangoOutliersAtributos1
rangoOutliersAtributos2

%% Detecciñon de outliers - criterio: media + 3 * desviación

clear all, clc

% Cargamos los datos
load 'VariablesGeneradas/ConjuntoDatos_naranja.mat';
X = double(X);

valoresY = unique(Y);

R = X(:,1);
G = X(:,2);
B = X(:,3);

FoI = (Y==valoresY(2)); % Filas de la clase de interes


% Calculo de media y desviacion

medias = mean(X(FoI,:)); desv = std(X(FoI,:)); 
Rmean = medias(1); Rstd = desv(1);
Gmean = medias(2); Gstd = desv(2);
Bmean = medias(3); Bstd = desv(3);

factor_outlier = 1.75; % Segun el criterio, si queremos datos mas o menos dispersos
% Consideramos valor atipico u outlier si es cualquiera de sus atributos
% el valor está fuera del rango:
% [media - 3*desv , media + 3*desv]
outR = (R > Rmean + factor_outlier * Rstd) | (R < Rmean - factor_outlier * Rstd);
outG = (G > Gmean + factor_outlier * Gstd) | (G < Gmean - factor_outlier * Gstd);
outB = (B > Bmean + factor_outlier * Bstd) | (B < Bmean - factor_outlier * Bstd);

% Nos quedamos con los valores de outlier de mis filas de interes (clase
% del objeto)
outR = and(FoI,outR);
outG = and(FoI,outG);
outB = and(FoI,outB);

% Un outlier es una instancia que tiene un 1 binario en cualquiera de esos
% canales
out_RGB = or(or(outR, outG),outB);

% Calculamos los indices de posiciones de los outliers detectados
pos_outliers = find(out_RGB);

%% REPRESENTACION DE DATOS Y OUTLIERS

representa_datos_color_seguimiento_fondo(X,Y);
hold on, plot3(R(pos_outliers),G(pos_outliers),B(pos_outliers), 'ok');

% Eliminar de la representacion los outliers
X(pos_outliers,:) = [];
Y(pos_outliers) = [];
representa_datos_color_seguimiento_fondo(X,Y);

