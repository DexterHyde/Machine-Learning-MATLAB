
clear all
close all

datosEntrenamiento=load('datatest.txt');
x=datosEntrenamiento(:,1:2);%x=[1 2 3];
y=datosEntrenamiento(:,3);%y=[1 2 3];
m=numel(y);
d=size(x);
n=d(2);
%Plot de los datos de entrenamiento
figure(1)
plot3(x(:,1),x(:,2),y,'ko','MarkerFaceColor','blue')
xlabel('x1')
ylabel('x2')
zlabel('y')
title('Datos de entrenamiento')

%Normalizar
media=mean(x);
sigma=std(x,1);
for i=1:n
  xNorm(:,i)=(x(:,i)-media(i))/sigma(i);
end
xNorm
%Plot de los datos de entrenamiento
figure(2)
plot3(xNorm(:,1),xNorm(:,2),y,'ko','MarkerFaceColor','blue')
xlabel('x1')
ylabel('x2')
zlabel('y')
title('Datos de entrenamiento Normalizados')

%Parametros iniciales
n=d(2)+1;
a=ones(n,1);
Beta=1;%factor de aprendizaje
max_iter=200;
iter=1;
convergencia=[];


X=[ones(m,1),xNorm];
for i=1:m
  h(i,1)=a'*X(i,:)';
end
h
J=(1/(2*m))*sum((h-y).^2);

while(iter<=max_iter)
  for j=1:n
    a(j)=a(j)-Beta*((1/m)*sum((h-y).*X(:,j)));
  end
  for i=1:m
    h(i,1)=a'*X(i,:)';
  end
  J = (1/(2*m))*sum((h-y).^2);
  convergencia(iter)=J;
  iter = iter +1; 
end
figure(3)
plot(convergencia)
xlabel('Iteraciones')
ylabel('J')

x1=-3:0.3:4;
x2=-3:0.3:4;
x1Size=numel(x1);
X2=[ones(x1Size,1),x1',x2'];

for i=1:x1Size
  for j=1:x1Size
    h2(i,j)=a'*X2(i,:)';
  end
end

[x2,x1]=meshgrid(x1,x2);
figure(2)
hold on
colormap(white)
surf(x1,x2,h2,'FaceAlpha',0.5)

J
a


indice1=5;
datoPrueba1=datosEntrenamiento(indice1,1:2);
datoPrueba1=(datoPrueba1-media)./sigma;
datoPrueba1=[1 datoPrueba1];
h1=a'*datoPrueba1';
plot3(datoPrueba1(2),datoPrueba1(3),h1,'ok','MarkerFaceColor','g')



