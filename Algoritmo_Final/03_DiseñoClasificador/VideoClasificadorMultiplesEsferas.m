clear all, clc;
load './01_GeneracionMaterial/ImagenesEntrenamiento_Naranja.mat';
load '02_Extraer_Representar_Datos/VariablesGeneradas/ConjuntoDatos.mat';
load '03_DiseñoClasificador/VariablesGeneradas/datosMultiplesEsferas.mat';

titulos(1) = "Imagen original";
titulos(2) = 'Imagen con ruido r1 = ';
titulos(3) = 'Imagen sin ruido r2 = ';
titulos(4) = 'Imagen intermedia r12 = ';

%Por cada frame 
for i=1:size(imagenes_naranja,4)
    
   I = imagenes_naranja(:,:,:,i);
   
   %Representar la imagen
   pause, subplot(2,2,1), imshow(I), title([titulos(1) num2str(i)]);
   

       % Imagen binaria de los puntos detectados como color
       % Por cada radio
       for j=1:3
           
           Ib = calcula_deteccion_multiples_esferas_en_imagen(I, [datosMultiplesEsferas(:,1:3) datosMultiplesEsferas(:,j+3)]);

           % Representar en color verde los pixeles reconocidos como color del
           % objeto de seguimiento
           hold on, subplot(2,2,j+1), funcion_visualiza(I, Ib, [0 255 0]), title(titulos(j+1));

       end
end


close all;