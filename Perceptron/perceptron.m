clear all
close all

datosEntrenamiento=load('dataset_Perceptron.txt');
X=datosEntrenamiento(:,1:2);
Y=datosEntrenamiento(:,3);
      
#parámetros iniciales
b=-0.5;
W=[0.2, 0.5];

a=0.03

[m]=size(X);

y=zeros(m,1);

figure(1)
title("Datos RAW")
hold on
clase1=find(Y==1);
claseMenos1=find(Y==0);
plot(X(clase1,1),X(clase1,2),'ko','MarkerFaceColor','y',12)
plot(X(claseMenos1,1),X(claseMenos1,2),'ko','MarkerFaceColor','m',12)

#Normalizacion
XN=zscore(X,1);

#grafica normalizada

figure(2)
title("Datos Normalizados")
hold on
clase1=find(Y==1);
claseMenos1=find(Y==0);
plot(XN(clase1,1),XN(clase1,2),'ko','MarkerFaceColor','y',12)
plot(XN(claseMenos1,1),XN(claseMenos1,2),'ko','MarkerFaceColor','m',12)

#ejes
axis([-2 2 -2 2]);

x1=-2:0.1:2;

#Definimos x2 despejando de la fórmula de pesos
x2=(-b-W(1)*x1)/W(2);

#Graficamos la línea
plot(x1,x2,'r')

#Creamos una variable de iteración
iter=1

while(sum(abs(Y-y)~=0))
  for i=1:m
    #Reajustamos el valor V
    v(i,1)=W*XN(i,:)'+b;
    #Función de activación
    if v(i,1)>0
      y(i,1)=1;
    else
      y(i,1)=0;
    end
    
    if Y(i)~=y(i)
      W=W+a*XN(i,:);
      b=b+a;
    end
    
    x1=-2:0.1:2;

    #Definimos x2 despejando de la fórmula de pesos
    x2=(-b-W(1)*x1)/W(2);

    #Graficamos la línea
    figure(4)
    hold on
    title("convergencia")
    axis([-2 2 -2 2]);
    clase1=find(Y==1);
    claseMenos1=find(Y==0);
    plot(XN(clase1,1),XN(clase1,2),'ko','MarkerFaceColor','y',12)
    plot(XN(claseMenos1,1),XN(claseMenos1,2),'ko','MarkerFaceColor','m',12)
    plot(x1,x2)
    
    conv(iter)=sum(abs(Y-y));
    
    iter=iter+1;
  end
end

W
b


figure(2)
hold on
plot(conv)



figure(3)
hold on

title("Clasificados")

#Dibujamos datos ya encontrados
plot(XN(clase1,1),XN(clase1,2),'ko','MarkerFaceColor','y',12)
plot(XN(claseMenos1,1),XN(claseMenos1,2),'ko','MarkerFaceColor','m',12)

axis([-2 2 -2 2]);

x1=-2:0.1:2;

x2=(-b-W(1)*x1)/W(2);

plot(x1,x2,'r')

disp ("Primer Prueba:")
datoPrueba=1;
y(datoPrueba,1)
 
disp ("Segunda prueba:")
datoPrueba=4;
y(datoPrueba,1)
