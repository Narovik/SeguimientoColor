
% Devuelve CENTROIDE_R CENTROIDE G_ CENTROIDE_B, RADIO1, RADIO2, RADIO12
% RADIO1: engloba TODOS los valores del color de objeto
function datosMultiplesEsferas = calcula_datos_esfera_agrupacion(X,Y)

    FoI = (Y==1); %Filas de interes: objeto
    XObjeto = X(FoI, :);
    XFondo = X(Y==0, :);

    k=4; % Numero de agrupaciones
    idx = funcion_kmeans(XObjeto,k);
    numAgrupaciones = length(unique(idx)); 


    datosMultiplesEsferas = zeros(numAgrupaciones, 6);
    for i=1:numAgrupaciones
 
        XAgrupacion = XObjeto(idx==i,:);

        %Nuevo conjunto de datos X
        X_new = [XAgrupacion ; XFondo];

        %Nuevo conjunto de datos Y
        Y_new = [ones(size(XAgrupacion,1),1) ; zeros(size(XFondo,1),1)];

        % Calcular datos de esa agrupacion
        datosEsfera = calcula_datos_esfera(X_new, Y_new);

        % Añadirla a la solucion
        datosMultiplesEsferas(i,:) = datosEsfera;

    end
end

function datosEsfera = calcula_datos_esfera(X,Y)

    %% 1 Calcular el centroide de la nube de puntos del color de seguimiento
    XObjeto = X(Y==1, :);
    XFondo = X(Y==0, :);

    numDatosObjeto = size(XObjeto,1);
    numDatosFondo = size(XFondo, 1);

    % Centro de la esfera: color medio
    valoresMedios = mean(XObjeto);
    Rc = valoresMedios(1); Gc = valoresMedios(2); Bc = valoresMedios(3);
    % Lo asignamos a la variable de retorno
    datosEsfera = [Rc Gc Bc];

    %% 2 Calcular Radio1 que englobe todos los puntos del color de seguimiento
    % Calculamos todas las Distancias euclídeas del centroide a los puntos del
    % objeto de seguimiento y nos qudamos con la mayor

    centroideT = valoresMedios';

    % FORMA 1: CON BUCLE FOR DATO A DATO
    % Inicializamos la distancia al primero
    % distanciaMax = sqrt(sum( XObjeto(1,:)' - centroideT ).^2);
    % 
    % for i=1:numDatosObjeto
    %     datoT = XObjeto(i,:)';
    %     distancia = (sqrt(sum(datoT - centroideT).^2));
    %     
    %     if  distancia > distanciaMax
    %         distanciaMax = distancia;
    %     end   
    % end
    % 
    % r1 = distanciaMax;
    % datosEsfera = [datosEsfera r1];

    % FORMA 2:
    datosT = XObjeto';
    % Repite el centroide para poder hacer la resta uno a uno
    centroideAmp = repmat(centroideT, 1, size(datosT,2)); 

    vectorDistancia = sqrt(sum(( datosT - centroideAmp ).^2));

    distanciaMax = max(vectorDistancia);
    r1 = distanciaMax;
    datosEsfera = [datosEsfera r1];

    %% 3 Calcular Radio2 que no detecte ningun ruido de fondo
    datosFondoT = XFondo';
    centroideAmpFondo = repmat(centroideT, 1, size(datosFondoT,2)); 
    vectorDistanciaFondo = sqrt(sum((datosFondoT - centroideAmpFondo ).^2));

    r2 = min(vectorDistanciaFondo);
    datosEsfera = [datosEsfera r2];

    %% 4 Calcular Radio12 que es un radio de compromosio entre r1 y r2
    % Valor medio de los radios anteriores

    r12 =(r1+r2)/2;
    datosEsfera = [datosEsfera r12];

end


