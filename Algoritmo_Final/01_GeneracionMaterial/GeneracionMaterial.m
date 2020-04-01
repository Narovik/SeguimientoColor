%% Captura del v�deo
% Configuraci�n dispositivo de captura
video=videoinput('winvideo',1,'RGB24_640x480'); %30 fps
video.ReturnedColorSpace = 'rgb';

Resolucion = video.videoResolution;
NumFilas = Resolucion(2);
NumColumnas = Resolucion(1);

% Forma de trabajo: grabaci�n continua
video.TriggerRepeat=Inf;
video.FrameGrabInterval=3; %30/3=10fps 

% Configuraci�n video de salida
outvideo = VideoWriter('01_ColorNaranja.avi');
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

%%Generaci�n del conjunto de datos 
clear
video = VideoReader('01_ColorNaranja.avi');

imagenes_naranja=[];




