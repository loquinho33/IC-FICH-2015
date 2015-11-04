%Funciones: Seleccion el tipo de funcion a aplicar.
function[salida]=aplicar_funcion(imagen, pos)
%for por la cantidad de elementos de pos
for ff=1:length(pos)


%crear los sistema(i) con las pos(i)
%guardar los sistemas en memoria o en un archivo cada uno
crear_sistema...--> debo seguir desde aqui
%debo crear el sistema con los parametros pos(i) y evaluar ese sistema 



%procesar la imagen con el sistema(i)
procesar=imagen;
[n,m]=size(procesar);
tic
[xx yy]=find(procesar==255 | procesar==0); %xx=columnas yy=filas

for i=1:length(xx)
    if(xx(i)~=1 && xx(i)~=256 && yy(i)~=1 && yy(i)~=256)
        rect=[yy(i)-1 xx(i)-1 2 2];
        recorte = imcrop(procesar,rect); % rect [xmin ymin width height]
        DP1 = median(recorte(:)');
            %pixel - norte - sur
            s1=[double(recorte(1,2)) double(recorte(3,2))];
            %pixel - oeste - este
            s2=[double(recorte(2,1)) double(recorte(2,3))];
            %pixel - noroeste - sureste
            s3=[double(recorte(1,1)) double(recorte(3,3))];
            %pixel - suroeste - noreste
            s4=[double(recorte(1,3)) double(recorte(3,1))];
            %
            ss1=evalfis(s1,a);
            ss2=evalfis(s2,a);
            ss3=evalfis(s3,a);
            ss4=evalfis(s4,a);
            NS1=evalfis([ss1 ss2],a);
            NS2=evalfis([ss3 ss4],a);
            DP2=evalfis([NS1 NS2],a);
            f=evalfis([double(DP1) double(DP2)],a);
            A=uint8(f);
            procesar(xx(i),yy(i))=A;
 
    end
end

salida(i)= psnr(imagen,procesar); 
end % en for por cada particula


end %end function