function pos_outliers = funcion_detecta_outliers_clase_interes(X,Y)
%% Deteccion de outliers - criterio: media + 3 * desviación
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

end
