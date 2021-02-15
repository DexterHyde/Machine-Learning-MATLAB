
clear all
close all

datosEntrenamiento=load('dataset_RegresionLineal.txt');
x=datosEntrenamiento(:,1);%x=[1 2 3];
y=datosEntrenamiento(:,2);%y=[1 2 3];
m=numel(x);

%Parametros iniciales
a0= 1;
a1= 0;
Beta=0.0026;%factor de aprendizaje
max_iter=600;
iter=1;
convergencia=[];

h=a0 + a1*x;
J=(1/(2*m))*sum((h-y).^2);
J
%Dibujar
figure(1)
plot(x,y,'k o','MarkerFaceColor','y','MarkerSize',5);
xlabel('x')
ylabel('y')
hold on
plot(x,h,'m')

%% Grafica del error
min_a=-5;
max_a=5;
eje_a0=linspace(min_a,max_a,50);
eje_a1=linspace(min_a,max_a,50);
eje_J=[];

for i=1:numel(eje_a0)
  for j=1:numel(eje_a1)
     h = eje_a0(i) + eje_a1(j)*x;
     eje_J(i,j) = (1/(2*m))*sum((h-y).^2);
  end
end
[eje_a1_,eje_a0_]=meshgrid(eje_a0,eje_a1);
figure(4)
surf(eje_a0_,eje_a1_,eje_J);
hold on
xlabel('a0')
ylabel('a1')
zlabel('J')
h = a0 + a1*x;
J = (1/(2*m))*sum((h-y).^2);
J
plot3(a0,a1,J,'ko','MarkerFaceColor','m','MarkerSize',5)


while(iter<=max_iter)
  a0 = a0 - Beta*((1/m)*sum(h-y));
  a1 = a1 - Beta*((1/m)*sum((h-y).*x));
  h = a0 + a1*x;
  J = (1/(2*m))*sum((h-y).^2);
  #figure(1)
  #plot(x,h)
  #figure(4)
  #plot3(a0,a1,J,'ko','MarkerFaceColor','m','MarkerSize',5)
  
  convergencia(iter)=J;
  #figure(2)
  #plot(iter,J,'*')
  #hold on
  iter = iter +1; 
end
figure(3)
plot(x,y,'k o','MarkerFaceColor','r','MarkerSize',5); 
hold on 
plot(x,h)

J
a0 
a1

datoPrueba=9.7687;
h=a0 + a1*datoPrueba;
h
figure(3)
plot(datoPrueba,h,'k o','MarkerFaceColor','g','MarkerSize',5);



