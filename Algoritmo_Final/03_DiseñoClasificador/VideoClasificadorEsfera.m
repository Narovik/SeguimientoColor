clear all, clc;
load './01_GeneracionMaterial/ImagenesEntrenamiento_Naranja.mat';
load '02_Extraer_Representar_Datos/VariablesGeneradas/ConjuntoDatos.mat';

datosEsfera = calcula_datos_esfera(X,Y);

% Cargar en variables los datos de la esfera
Rc = datosEsfera(1); Gc = datosEsfera(2); Bc = datosEsfera(3);
r1 = datosEsfera(4); r2 = datosEsfera(5); r12 = datosEsfera(6);
radios = datosEsfera(4:6);

titulos(1) = "Imagen original";
titulos(2) = ['Imagen con ruido r1 = ' num2str(r1)];
titulos(3) = ['Imagen sin ruido r2 = ' num2str(r2)];
titulos(4) = ['Imagen intermedia r12 = ' num2str(r12)];

%Por cada frame 
for i=1:size(imagenes_naranja,4)
    
   IColor = imagenes_naranja(:,:,:,i);
   
   %Representar la imagen
   figure, subplot(2,2,1), imshow(IColor), title([titulos(1) num2str(i)]);
   
   %Deteccion por distancia
   R = double(IColor(:,:,1)); 
   G = double(IColor(:,:,2));
   B = double(IColor(:,:,3));
   
   % Matriz distancia del color de cada pixel al centroide
   MD = sqrt ( (R-Rc).^2 + (G-Gc).^2 + (B-Bc).^2 );
   
   % Imagen binaria de los puntos detectados como color
   % Por cada radio
   for j=1:length(radios)
       Ib = MD < radios(j);
       
       % Representar en color verde los pixeles reconocidos como color del
       % objeto de seguimiento
       hold on, subplot(2,2,j+1), funcion_visualiza(IColor, Ib, [0 255 0]), title(titulos(j+1));
           
   end
end

close all;