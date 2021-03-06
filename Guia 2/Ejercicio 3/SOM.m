function [W]=SOM(archivo,matris_som,gamma,vecindad,epocas_etapas,cant_salidas,ini)
    patrones=csvread(archivo);
    patrones=patrones(:,1:end-cant_salidas);
    [n,~]=size(patrones);
    W = inicializarSOM( matris_som , patrones , ini );% pesos para cada neurona
    graphSOM(W);
    pause(1);
    epoca_actual=1;
    while(epoca_actual<sum(epocas_etapas))        
     [gamma,A,vecindad]=etapas(epoca_actual,epocas_etapas,vecindad,gamma);
      W= recorrerPatrones(patrones,vecindad,W,matris_som,gamma,A); 
      if mod(epoca_actual,10) == 0 %grafico cada 5 epocas
      graphSOM( W ) ;
      pause(0.05);
      end
      epoca_actual=epoca_actual+1
    end
    graphSOM(W);
end

function [W] = inicializarSOM( matris_som , patrones , ini )
    switch ini
        case 1
            [~,m] = size( patrones );
            W = cell( matris_som(1) , matris_som(2) );
            for i=1:matris_som(1)
                for j=1:matris_som(2)
                    W{i,j} = -0.5 + rand(1,m); %inicializo al azar los pesos
                end
            end
        case 2
            [n m] = size( patrones );
            W = cell( matris_som(1) , matris_som(2) );
            for i=1:matris_som(1)
                for j=1:matris_som(2)
                    W{i,j} = patrones(round((n-1)*rand(1)+1),:); % patron cualquiera
                end
            end
        otherwise
            disp('Error');
    end
end

function [gamma,A,vecindad]=etapas(epoca_actual,epocas_etapas,vecindad,gamma)

   % Parametros Ordenamiento Global
        if epoca_actual < epocas_etapas(1)
            %mu = gamma
            A = vecindad
        % Parametros Transicion
        elseif epoca_actual < sum(epocas_etapas(1:2))
            gamma = gamma + (0.1-gamma)*(epoca_actual-epocas_etapas(1))/epocas_etapas(2)
            A = vecindad + (1-vecindad)*(epoca_actual-epocas_etapas(1))/epocas_etapas(2)
            vecindad=A;
        % Parametros Ajuste fino
        else
            gamma = 0.01
            A= 0
            vecindad=0
        end
end

function [fila_neurona,col_neurona] = coord_de_ganadora( W , patron )
    D = cellfun( @(x) patron-x , W , 'UniformOutput' , false ); % diferencia a cada elemento de celda
    D = cellfun( @(x) norm(x) , D , 'UniformOutput' , false ); %distancia a cada vector de la celda
    D = cell2mat(D);
    [v,fila_neurona] = min(D); %minimo de la matriz
    [v,col_neurona] = min(v); %minimo del vector
    fila_neurona = fila_neurona(col_neurona);
end

function W= recorrerPatrones(patrones,vecindad,W,matris_som,gamma,A)
        [n,~] = size(patrones);
        for i=1:n %recorro patrones
            patron = patrones(i,:);
            % Cooordenada de ganadora-> mas cercana al patron de entrada
            % actual
            [filaGanadora,colGanadora] = coord_de_ganadora( W , patron );
            %limites
            [ar,ab,iz,de]=Limites( filaGanadora , colGanadora , vecindad , matris_som );
            for fv=ar:ab %vecindad -> radio  A
                for cv=iz:de
                    if abs((filaGanadora-fv))+abs((colGanadora-cv)) <= A  %si esta dentro del radio
                        % Selecciono la neurona vecina
                        nv = W{fv,cv};
                        % Calculo el error con el patron entrante
                        e = patron - nv;
                        W{fv,cv} = W{fv,cv}+gamma*e;%actulizacion pesos
                    end
                end
            end
        end
end


