clear all, clc;
% Cargamos los datos
load './02_Extraer_Representar_Datos/VariablesGeneradas/ConjuntoDatos.mat';

% Representacion de los datos
representa_datos_color_seguimiento_fondo(X,Y);

%% ESTRATEGIA DE CLASIFICACION:
% BASADA EN ESTABLECER UNA REGION DEL ESPACIO DE CARACTERISTICAS
% QUE ENGLOBE A TODAS LAS MUESTRAS DE LA CLASE CORRESPONDIENTE A 
% LOS PIXELES QUE SON DEL COLOR DEL OBJETO DE SEGUIMIENTO

% Datos de la clase de interes

valoresY = unique(Y);
FoI = (Y==1); %Filas de interes: objeto
XClase = X(FoI, :);

valoresMedios = mean(XClase);
valoresMinimos = min(XClase);
valoresMaximos = max(XClase);

%% PRIMERA OPCION
% CARACTERIZACION DE LA REGION DE INTERES BASADA EN UN PRISMA
% RECTANGULAR EN EL ESPACION RGB ASOCIADO AL COLOR DE SEGUIMINETO

% DIMENSIONES DEL PRIMSA EN VALORES MAXIMOS Y MINIMOS PARA QUE ENGLOBE A
% TODOS LOS PIXELES DEL COLOR DE SEGUIMIENTO

Rmin = valoresMinimos(1); RMax = valoresMaximos(1);
Gmin = valoresMinimos(2); GMax = valoresMaximos(2);
Bmin = valoresMinimos(3); BMax = valoresMaximos(3);

% REPRESENTACION DEL PRISMA EN EL ESPACIO DE CARACTERISTICAS RGB
close all;
% figura?

% CLASIFICADOR: un pixel será reconocido como objeto si sus valores RGB
% estan entre el maximo y el minimo del prisma

clear all,clc;
%% SEGUNDA OPCION 
% CARACTERIZACION BASADA EN SUPERFICIE ESFERICA CENTRADA EN COLOR MEDIO

valoresY = unique(Y);
FoI = (Y==1); %Filas de interes: objeto
XClase = X(FoI, :);

% Centro de la esfera: color medio
valoresMedios = mean(XClase);
Rc = valoresMedios(1); Gc = valoresMedios(2); Bc = valoresMedios(3);

% Representar el centroide sobre la nube de puntos del color de seguimiento
close all, representa_datos_color_seguimiento(X,Y);
hold on, plot3(Rc,Gc,Bc, '*k');

% Calcular los datos de la esfera 
% datosEsfera [centroideR centroideG centroideB r1 r2 r12]

datosEsfera = calcula_datos_esfera(X,Y);

centroide = datosEsfera(1:3);
radios = datosEsfera(4:6);
r1 = datosEsfera(4);
r2 = datosEsfera(5);
r12 = datosEsfera(6);

for i=1:length(radios)
   representa_datos_color_seguimiento_fondo(X,Y);
   hold on, representa_esfera(centroide, radios(i)), hold off
   title(['Esdera de Radio: ' num2str(radios(i))])
end





