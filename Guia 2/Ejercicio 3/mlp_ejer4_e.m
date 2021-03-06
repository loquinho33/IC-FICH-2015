function [tasa_e,tasa_a,epoca_actual,W]= mlp_ejer4_e(archivo,criterio,gamma,alpha,tasa_e_max,epoca_max,neuronas)
   
    epoca_actual=1; %Contador de épocas 
    cant_salidas=neuronas(end); %cantidad de neuronas de la última capa son las salidas que tengo en mi red
    patrones_entr=load(archivo);
    [n,m]=size(patrones_entr);
    entradas=m-cant_salidas;
    nodos=[entradas neuronas(1:end-1)]; %cantidad de entradas por cada neurona;
    W=pesosW(nodos,neuronas); %pesos al asar
    capas=length(neuronas); %cantidad de capas
    deltaW_n=W; %iniciaclización del delta W del momento deinercia
    bandera=1;
    while(bandera)
        for i= 1:n % recorrida de patrones
            %forward
            Y=forward(W,patrones_entr,capas,cant_salidas,i);
            %back
            Delta=back(Y,W,patrones_entr,capas,cant_salidas,i);        
            %Ajuste de Pesos
            [W,deltaW_n]=ajusteW(Y,W,Delta,deltaW_n,patrones_entr,capas,cant_salidas,gamma,alpha,i);            
        end % fin de epoca 
        
      %Calculo  de tasa error de entrenamiento
      [tasa_e,tasa_a,Yp,V]=calc_error_ejer4(W,patrones_entr,capas,cant_salidas);    
      bandera=corte(criterio,epoca_actual,epoca_max,tasa_e,tasa_e_max,bandera);        
      %Calculo la tasa de error por epoca
      error_tasa(epoca_actual)=tasa_e;
      
      %Actualizo el contador de epocas
      epoca_actual=epoca_actual+1 
      
    end
    
    %figure('Name','Salidas','NumberTitle','off')
    %plot(error_epoca);
    %xlabel('epoca');
    %ylabel('error');
    %title('Entrenamiento/single');
    
    figure('Name','Tasa de error - MLP','NumberTitle','off')
    plot(error_tasa);
    xlabel('epoca');
    ylabel('Tasa');
    title('Tasa de error - MLP');
    
    %Graficamos clasificacion con los patrones de Entrenamiento
    %graph_mlp_ejer4(V,patrones_entr,'Graficamos clasificacion con los patrones de Entrenamiento');
    
    
    end


function [W]=pesosW(nodos,neuronas)
	for i=1:length(nodos)
		W{i}=randn(neuronas(i),nodos(i)+1)-0.5;
	end
end

function [Y]=forward(W,patrones_entr,capas,cant_salidas,index_patron)
 X=[-1 patrones_entr(index_patron,1:end-cant_salidas)]'; %obtengo un patron i 
        for k=1:capas
            V=W{k}*X;
            Y{k}=(sigmoidea_ejer4(V,1)); 
            X=[-1; Y{k}];
        end
end

function [Delta]=back(Y,W,patrones_entr,capas,cant_salidas,index_patron)
        % 1ro -> Delta para la capa de salida
        derivada=(1/2)*(1+Y{capas}).*(1-Y{capas});
        error=patrones_entr(index_patron,end-cant_salidas+1:end)'-Y{capas}; %forma general para mas de una salida
        Delta{capas}=error.*derivada;
        %2do -> Delta para las capas ocultas
        for k=capas-1:-1:1
            derivada=(1/2)*(1+Y{k}).*(1-Y{k});
            Delta{k}=(W{k+1}(:,2:end)'*Delta{k+1}).*derivada;
        end
end

function [W,deltaW_n]=ajusteW(Y,W,Delta,deltaW_n,patrones_entr,capas,cant_salidas,gamma,alpha,index_patron)
           X=[-1 patrones_entr(index_patron,1:end-cant_salidas)]; %Entradas al patron i     
        for k=1:capas
            dW=gamma*Delta{k}*X;
            W{k}=W{k}+dW+alpha*deltaW_n{k};% momento de inercia,  acelera la convergencia cuando el gradiente sigue un sentic;
            deltaW_n{k}=dW; %Guardo lo que tenia antes de sumar dW 
            X=[-1; Y{k}]';
        end
end

function [bandera]= corte(criterio,epoca_ac,epoca_max,tasa_e,tasa_max,bandera)
        switch criterio
            case 1
                if (epoca_ac>epoca_max)
                    bandera=0;
                end
            case 2
                if (tasa_e<=tasa_max)
                    bandera=0;
                end
            case 3
                if (tasa_e<=tasa_max ||epoca_ac>epoca_max  ) % el que se cumple primero
                    bandera=0;
                end
            otherwise
                print('criterio no contemplado');
                bandera=0;
        end       

end