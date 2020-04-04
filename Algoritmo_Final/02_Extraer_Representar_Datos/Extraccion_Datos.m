clear all, clc;

%Cargamos las variables generadas en la etapa uno
load('./01_GeneracionMaterial/ImagenesEntrenamiento_Naranja.mat');

[alto ancho nComp nImag] = size(imagenes_naranja);
%Visualizar las imagenes de calibracion
for i=1:nImag
    imshow(imagenes_naranja(:,:,:,i)), title(num2str(i));
    pause;
end


%2.1.1 Almacenar en DatosColor id imagen y sus valores RGB
% El objeto aparece a partir de la img. nº 11
DatosColor=[];
for i=12:nImag
    I = imagenes_naranja(:,:,:,i);
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);

    ROI = roipoly(I);

    DatosColor = [DatosColor; i*ones(length(R(ROI)),1) R(ROI), G(ROI), B(ROI)];    
end

save('./02_Extraer_Representar_Datos/DatosColor_naranja.mat', 'DatosColor');


%2.1.1 Almacenar en DatosFondo id imagen y sus valores RGB
% El fondo aparece hasta la imagen 11
DatosFondo=[];
for i=1:11
    I = imagenes_naranja(:,:,:,i);
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);

    ROI = roipoly(I);

    DatosFondo = [DatosFondo; i*ones(length(R(ROI)),1) R(ROI), G(ROI), B(ROI)];    
end



