clear all, clc;

%% CARGAR LOS PARAMETROS DE CLASIFICACION
load '04_AjusteClasificador_ImgCalib/VariablesGeneradas/parametros_clasificador.mat';

%% Captura del vídeo
% Configuración dispositivo de captura
% videoIn=videoinput('winvideo',1,'RGB24_640x480'); %30 fps
% videoIn.ReturnedColorSpace = 'rgb';
% % Forma de trabajo: grabación continua
% videoIn.TriggerRepeat=Inf;
% videoIn.FrameGrabInterval=1; %30/3=10fps 
% preview(videoIn);

%% LECTURA DEL VIDEO DE ENTRADA
nombreEntrada = '01_ColorNaranja.avi';
videoIn = VideoReader(nombreEntrada);
[numFrames, numFilasFrame, numColFrame, FPS] = carga_video_entrada(videoIn);

%% GENERACION VIDEO DE SALIDA
nombreSalida = 'video_salida_naranja.avi';
videoOut = VideoWriter(nombreSalida);
videoOut.FrameRate = FPS;
open(videoOut);

color = [255 255 255]; % color del punto de seguimiento

figure, hold on;
start(videoIn);
for frame=1:numFrames
    I = getdata(videoIn, 1);
    
    % Calcular matricesde distancias y 
    % Detectar aquellos píxeles cuyo color se considere que sea del color del seguimiento
    IbDeteccionEsferas = calcula_deteccion_multiples_esferas_en_imagen(I, datosMultiplesEsferas_clasificador);
     
    % Eliminar las componentes conexas más pequeñas.
    Ib = bwareaopen(IbDeteccionEsferas, numPix);
    
    if(sum(Ib(:)) > 0)
        % Calcular centroides de los objetos detectados
        [Ietiq numObjetos] = bwlabel(Ib);

        stats = regionprops(Ietiq, 'Centroid');
        
        for i=1:numObjetos
            centroide_objeto = int64(stats(i).Centroid);
            fila = centroide_objeto(2);
            col = centroide_objeto(1);
            
            %Comprobar si hay espacio para pintar los 3x3 pixeles dentro de
            %los bordes de la imagen
            if (fila>0 & fila < numFilasFrame & col>0 & col<numColFrame)
            
                % Pintar los vecinos8 y el centro del color
                I(fila, col, :) = color;
                I(fila+1, col, :) = color;
                I(fila-1, col, :) = color;
                I(fila, col+1, :) = color;
                I(fila, col-1, :) = color;
                I(fila+1, col+1, :) = color;
                I(fila-1, col-1, :) = color;
                I(fila+1, col-1, :) = color;
                I(fila-1, col+1, :) = color;

            else % Solo pinta el pixel del centroide
                I(fila, col, :) = color;
            end
        end
    end
    % Grabamos el frame en el video de salida
    writeVideo(videoOut, I);
    
   imshow(I);
end

%stop(videoIn)

close(videoOut);
implay(nombreSalida)
