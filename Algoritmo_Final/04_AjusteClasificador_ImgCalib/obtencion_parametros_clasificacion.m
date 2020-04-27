clear all, clc;
load './01_GeneracionMaterial/ImagenesEntrenamiento_Naranja.mat';
load '03_DiseñoClasificador/VariablesGeneradas/datosMultiplesEsferas.mat';

titulos(1) = "Imagen original";
titulos(2) = 'Imagen con ruido r1';
titulos(3) = 'Imagen sin ruido r2';
titulos(4) = 'Imagen compromiso r12';

%% REPRESENTACION DE LA DETECCION CON LOS 3 RADIOS 
numImagenes = size(imagenes_naranja,4);
%Por cada frame 
for i=1:numImagenes
    
   I = imagenes_naranja(:,:,:,i);
   
   %Representar la imagen
   figure,subplot(2,2,1), imshow(I), title([titulos(1) num2str(i)]);
   

       % Imagen binaria de los puntos detectados como color
       % Por cada radio
       for j=1:3
           
           Ib = calcula_deteccion_multiples_esferas_en_imagen(I, [datosMultiplesEsferas(:,1:3) datosMultiplesEsferas(:,j+3)]);

           % Representar en color verde los pixeles reconocidos como color del
           % objeto de seguimiento
           hold on, subplot(2,2,j+1), funcion_visualiza(I, Ib, [0 255 0]), title(titulos(j+1));

       end
end


%% ELECCION DE RADIO EN BASE AL ANALISIS DE LAS IMAGENES ANTERIORES
% Nos quedamos conl radio de compromiso
datosMultiplesEsferas_clasificador = datosMultiplesEsferas(:,[1:3 6]);

%% CALIBREACION DE PARAMETRO DE CONECTIVIDAD numPix

I_objeto_pos_mas_alejada = imagenes_naranja(:,:,:, 24);
Ib = roipoly(I_objeto_pos_mas_alejada);
numPixReferencia = sum(Ib(:)); %Numero total de pixeles del objeto mas pequeño

numPixAnalisis = round([0.25 0.5 0.75] *numPixReferencia);

% Visualizamos 4 graficas por imagen:
% 1. Imagen de calibraicon con la deteccion por distnacia sin eliminar nada
% 2,3,4 eliminando las componentes conectadas de tamaño menor a los tres
% valores de prueba de numPixAnalisis

color = [255 0 0];
valoresConectividad{1} = ['numPix = ' num2str(numPixAnalisis(1))];
valoresConectividad{2} = ['numPix = ' num2str(numPixAnalisis(2))];
valoresConectividad{3} = ['numPix = ' num2str(numPixAnalisis(3))];

close all;
for i=1:numImagenes
    I = imagenes_naranja(:,:,:,i);
   
    Ib_original = calcula_deteccion_multiples_esferas_en_imagen(I, datosMultiplesEsferas_clasificador);
    Ib1 = bwareaopen(Ib_original, numPixAnalisis(1));
    Ib2 = bwareaopen(Ib_original, numPixAnalisis(2));
    Ib3 = bwareaopen(Ib_original, numPixAnalisis(3));
    
    figure,subplot(2,2,1), funcion_visualiza(I, Ib_original, color), title(['Deteccion original img:' num2str(i)]),
    hold on, subplot(2,2,2), funcion_visualiza(I, Ib1, color), title(valoresConectividad{1}),
    hold on, subplot(2,2,3), funcion_visualiza(I, Ib2, color), title(valoresConectividad{2}),
    hold on, subplot(2,2,4), funcion_visualiza(I, Ib3, color), title(valoresConectividad{3});
    
end

% Elegimos el segundo valor en base a las imagenes anteriores
numPix = numPixAnalisis(2);

%% GUARDAMOS PARAMETROS PARA LA APLICACION DEL CLASIFICADOR

save('04_AjusteClasificador_ImgCalib/VariablesGeneradas/parametros_clasificador.mat', 'datosMultiplesEsferas_clasificador', 'numPix');

