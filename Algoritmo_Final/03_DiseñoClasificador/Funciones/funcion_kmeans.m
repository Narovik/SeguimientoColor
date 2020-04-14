% X: Matriz RGB de cada muestra
% K: numero de agrupaciones
% idx: identificador de la agrupacion a la que pertenece cada muestra

function idx = funcion_kmeans(X, k)

    idx = funcion_agrupa_por_desviacion(X,k);
    
    M_iguales = false;
    while not(M_iguales)
       
        centroides = funcion_calcula_centroides(X,idx);
        
        idx_new = funcion_calcula_agrupacion(X,centroides);
        
        M_iguales = funcion_compara_matrices(idx, idx_new);
        
        idx = idx_new;
        
    end

end

function idx = funcion_agrupa_por_desviacion(X,k)

    desviaciones = std(X); % Desviacion estandar de cada atributo
    CoI = max(find(desviaciones)); % Columna de interes: mayor desviacion
    numDatos = size(X,1);
    idx = zeros(numDatos,1); % Inicializamos el vector columna de las etiquetas

    valorMax = max(X(:,CoI))+0.1; %Para que el valor max entre en la ultima agrupacion
    valorMin = min(X(:,CoI));
    
    LonIntervalo = (valorMax - valorMin) / k;
    
    valorInicial = valorMin;
    valorFinal = valorMin + LonIntervalo;
    
    for i=1:k
        idx(X(:,CoI) >= valorInicial & X(:,CoI) < valorFinal) = i;
        
        valorInicial = valorFinal;
        valorFinal = valorFinal + LonIntervalo;
    end
    
    % Comprobacion todos los intervalos ok
%     unique(idx)
%     for i=1:k
%        [i size(find(idx==i),1)] 
%     end
    
end

function centroides = funcion_calcula_centroides(X,idx)

    numAgrupaciones = length(unique(idx));
    centroides = zeros(numAgrupaciones,3);
    
    for i=1:numAgrupaciones
        centroides(i,:) = mean(X(idx==i,:));
    end

end

function idx = funcion_calcula_agrupacion(X,centroides)

    numCentroides = size(centroides,1);
    datosT = X';
    idx = zeros(size(X,1),1);
    
    % En cada fila, la distancia de ese dato (col) al centroide de la agrupacion
    distancias = zeros(size(centroides,1), size(X,1));
    
    
    for i=1:numCentroides
        
        % Matriz ampliada repitiendo el valor del centroide i en columnas
        centroideAmp = repmat(centroides(i,:)', 1, size(datosT,2));
        
        % Calculo de la distancias de cada dato a ese centroide
        distancias(i,:) = sqrt(sum(( datosT - centroideAmp ).^2));
        
    end
   
    % Asignar cada dato al centroide de menor distancia
    for j=1:length(idx)
        idx(j) = find(distancias(:,j) == min(distancias(:,j)));
    end
    
%Comprobacion todos los intervalos ok
%     unique(idx)
%     for i=1:k
%        [i size(find(idx==i),1)] 
%     end
end

function varLogica = funcion_compara_matrices(matriz1, matriz2)

    varLogica = matriz1==matriz2;
end

