clear all, clc;
%% Captura del v�deo
% Configuraci�n dispositivo de captura
video=videoinput('winvideo',1,'RGB24_640x480'); %30 fps
video.ReturnedColorSpace = 'rgb';

% Forma de trabajo: grabaci�n continua
video.TriggerRepeat=Inf;
video.FrameGrabInterval=3; %30/3=10fps 
preview(video);

% Configuraci�n video de salida
outvideo = VideoWriter('01_ColorNaranja_raw.avi','Uncompressed AVI');
outvideo.FrameRate = 10; %10 fps video de salida

%Grabaci�n del video
open(outvideo);
start(video);
while(video.FramesAcquired < 150) %15s de grabacion
    I=getdata(video,1);         %Obtenemos el frame capturado  
    writeVideo(outvideo, I);    %Guardamos el frame    
end

stop(video);
close(outvideo);

%% Reescalado de video
invideo = VideoReader('01_ColorNaranja_raw.avi');

nFrames = invideo.NumFrames;

outvideo2 = VideoWriter('01_ColorNaranja.avi','Uncompressed AVI');
outvideo2.FrameRate = invideo.FrameRate;


open(outvideo2);
for i=1:nFrames
   IFrame = read(invideo,i);
   IFrame_reescalado = imresize ( IFrame , [240 NaN] );
   writeVideo(outvideo2, IFrame_reescalado);
end
close(outvideo2);


%%Generaci�n del conjunto de datos 
clear


imagenes_naranja=[];



