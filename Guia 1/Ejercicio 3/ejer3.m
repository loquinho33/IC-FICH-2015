clear all;
close all;
cp=1; % cantidad de particiones

 archivo='concentlite';
%   path_archivo=strcat('../Datos/',archivo,'.csv');  
%   path_salida=strcat('../Datos/particiones/',archivo);
%   particionar_ejer3(path_archivo,path_salida,cp,0.8);
neuronas=[8 1];

archivo='concentlite';
path_entrada_e = strcat('../Datos/particiones/',archivo,'_e_1','.csv');
path_entrada_t = strcat('../Datos/particiones/',archivo,'_t_1','.csv');
   
%Entrenamiento
%------------------------------------(archivo,criterio,gamma,alpha,tasa_max,epoca_max,neuronas)
%[tasa_e,epoca_ac,W]=mlp_ejer3_e(path_entrada_e,2,0.1,1,300,0.05,neuronas);
[tasa_e,tasa_a,cep,W]=mlp_ejer3_e(path_entrada_e,2,0.1,1,0.05,300,neuronas);
% 
% %%Prueba test  
 Err_t=mlp_ejer3_t(path_entrada_t,W,neuronas); %Error en la etapa test
%         