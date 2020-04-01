clear all, clc;
%% Captura del vídeo
% Configuración dispositivo de captura
video=videoinput('winvideo',1,'RGB24_640x480'); %30 fps
video.ReturnedColorSpace = 'rgb';

% Forma de trabajo: grabación continua
video.TriggerRepeat=Inf;
video.FrameGrabInterval=3; %30/3=10fps 
preview(video);

% Configuración video de salida
outvideo = VideoWriter('01_ColorNaranja_raw.avi','Uncompressed AVI');
outvideo.FrameRate = 10; %10 fps video de salida

%Grabación del video
open(outvideo);
start(video);
while(video.FramesAcquired < 150) %15s de grabacion
    I=getdata(video,1);         %Obtenemos el frame capturado  
    writeVideo(outvideo, I);    %Guardamos el frame    
end

stop(video);
close(outvideo);

%% Reescalado de video
invideo = VideoReader('01_ColorNaranja_raw.avi');  %Video a 640x480

nFrames = invideo.NumFrames;

outvideo2 = VideoWriter('01_ColorNaranja.avi','Uncompressed AVI');
outvideo2.FrameRate = invideo.FrameRate;


open(outvideo2);
for i=1:nFrames
   IFrame = read(invideo,i);
   IFrame_reescalado = imresize ( IFrame , [240 NaN] ); %Se reescala a 240x320
   writeVideo(outvideo2, IFrame_reescalado);
end
close(outvideo2);


%%Generación del conjunto de datos 
clear all, clc;

video = VideoReader('01_ColorNaranja.avi');
nFrames = video.NumFrames; %150 frames

% Generaremos un conjunto de 25 muestras
imagenes_naranja=uint8(zeros(240,320,3,25)); 
numImagen=1; %Contador
for i=1:6:nFrames
    imagenes_naranja(:,:,:,numImagen) = read(video,i);  
    imshow(imagenes_naranja(:,:,:,numImagen));
    pause;
    numImagen=numImagen+1;
end

size(imagenes_naranja)







