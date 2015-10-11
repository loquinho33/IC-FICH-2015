clear all
close all

M=[-20 -20 -10 -5;
    -10 -5 -5 -2;
    -5 -2 -2 0;
    -2 0 0 2;
    0 2 2 5;
    2 5 5 10;
    5 10 20 20];

M2=[mean(M(1,:)) std(M(1,:));
    mean(M(2,:)) std(M(2,:))
    mean(M(3,:)) std(M(3,:))
    mean(M(4,:)) std(M(4,:))
    mean(M(5,:)) std(M(5,:))
    mean(M(6,:)) std(M(6,:))
    mean(M(7,:)) std(M(7,:))];

[n,m]=size(M2);
s=-20:0.5:20;
graficar_conjunto(s,M2);