clear all;
close all;
clc
%Inicializacion de parametros
x=5;
% r=[1 2 3 4 5 6 7];%Vector de correlacion. Mapea A--> B
r=[7 6 5 4 3 2 1];%Vector de correlacion. Mapea A--> B

%--------------------------------------------------------------
%Trapecios
%--------------------------------------------------------------

%Matriz de entrada M
M=[-20 -20 -10 -5;
    -10 -5 -5 -2;
    -5 -2 -2 0;
    -2 0 0 2;
    0 2 2 5;
    2 5 5 10;
    5 10 20 20];
%Matriz de salida S
S=[-7 -5 -5 -3 ;
   -5 -3 -3 -1;
   -3 -1 -1 0;
   -1 0 0 1;
    0 1 1 3;
    1 3 3 5;
    3 5 5 7];
%Reordeno en funcion del indice
Mapeo1=index_map(r,M);
%Calculo las activaciones para la matriz de entrada A
a1 = grado_activacion(x,Mapeo1);
%Obtengo la salida del sistema mapeado y la escala de sus conjuntos
salida1=defuzzification(a1,S)


%--------------------------------------------------------------
%g
%--------------------------------------------------------------
M2=[mean(M(1,:)) std(M(1,:));
    mean(M(2,:)) std(M(2,:))
    mean(M(3,:)) std(M(3,:))
    mean(M(4,:)) std(M(4,:))
    mean(M(5,:)) std(M(5,:))
    mean(M(6,:)) std(M(6,:))
    mean(M(7,:)) std(M(7,:))];

S2=[mean(S(1,:)) std(S(1,:));
    mean(S(2,:)) std(S(2,:))
    mean(S(3,:)) std(S(3,:))
    mean(S(4,:)) std(S(4,:))
    mean(S(5,:)) std(S(5,:))
    mean(S(6,:)) std(S(6,:))
    mean(S(7,:)) std(S(7,:))];

%Reordeno en funcion del indice
Mapeo2=index_map(r,M2);
%Calculo las activaciones para la matriz de entrada A
a2 = grado_activacion(x,Mapeo2);
%Obtengo la salida del sistema mapeado y la escala de sus conjuntos
salida2=defuzzification(a2,S2)
