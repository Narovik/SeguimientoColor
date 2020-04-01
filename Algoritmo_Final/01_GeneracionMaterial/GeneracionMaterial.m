% Configuración dispositivo de captura
video=videoinput('winvideo',1,'RGB24_640x480'); %30 fps
video.ReturnedColorSpace = 'rgb';

Resolucion = video.videoResolution;
NumFilas = Resolucion(2);
NumColumnas = Resolucion(1);

% Forma de trabajo: grabación continua
video.TriggerRepeat=Inf;
video.FrameGrabInterval=3; %30/3=10fps 

% Configuración video de salida
outvideo = VideoWriter('01_ColorNaranja.avi');
outvideo.FrameRate = 10; %10 fps video de salida