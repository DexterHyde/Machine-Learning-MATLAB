#REGRESION POLINOMIAL

clear all

data = load('dataset_RegresionRegularizacion2.txt');
x=data(:,1);
y=data(:,2);

x=zscore(x,1);
[m,n]=size(x);

#Definimos el grado del polinomio
grado = 8
for i=1:grado
  x(:,i)=x(:,1).^i;
end

x = [ones(m,1), x];
[m,n]=size(x);

a=zeros(n,1);
beta = 0.019;
iter_max=500000;

for i=1:m
    h(i,1)=a'*x(i,:)';
end
J = (1/(2*m))*sum((h-y).^2);
J_conver=zeros(iter_max,1);

for iter=1:iter_max
    J_conver(iter)=J;
    for j=1:n
       a(j) = a(j) - beta*(1/m)*sum((h-y).*x(:,j));
    end
    for i=1:m
        h(i,1)=a'*x(i,:)';
    end
    J = (1/(2*m))*sum((h-y).^2);
end

figure(3)
plot(J_conver,'r')


x2=min(x(:,2)):0.01:max(x(:,2));
m2=numel(x2);
x2=x2';

for i=1:grado
  x2(:,i)=x2(:,1).^i;
end

x2=[ones(m2,1) x2];

for i=1:m2
   h2(i,1)=a'*x2(i,:)';
end

figure(2)
plot(x2(:,2),h2,'r','LineWidth',2)

saveas(figure(2), "datosPolinomial.jpg")

J
a

#CALCULO DE ERRORES
MAE=sum(abs(h-y))/m
MSE=sum((h-y).^2)/m
R2= (sum((y-mean(y)).^2) - sum((y-h).^2))/sum((y-mean(y)).^2)