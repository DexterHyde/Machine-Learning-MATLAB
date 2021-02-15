
clear all
close all

x = [2 3 4 10 11 12 20 25 30];

m=numel(x);

figure(1)
plot(x,zeros(1,m),'ko','MarkerSize',10)

axis([0 31 -1 1]);

hold on


k=2;

#Definimos los valores iniciales de Mu_t:
Mu_t=[2 10];
Mu_tmas1=zeros(1,k);


#Grafica con nuestros valores de centroides iniciales
plot(Mu_t,ones(1,k)*0.1,'*')

hold off

color=['y','m','r'];


#algoritmo:
while(true)
  C=cell(1,k);
  

  
  for i=1:m
    
    for j=1:k
      

      dist(j)=(x(i)-Mu_t(j))^2;
    end
    

    [~,ind]=min(dist);
    
    C{ind}=[C{ind};x(i)];
  end
  
  figure(1)
  
  plot(x,zeros(1,m),'ko','MarkerSize',10)
  
  hold on

  axis([0 31 -1 1]);

  plot(Mu_t,ones(1,k)*0.1,'*')
  
  for j=1:k
    plot(C{j},zeros(numel(C{j})),'ko','MarkerFaceColor',color(j),'MarkerSize',10)
    
    Mu_tmas1(j)=mean(C{j});
  end
  #pause(0.5)
  plot(Mu_tmas1,ones(1,k)*0.1,'*')
  hold off
  
  if sum(sqrt((Mu_t-Mu_tmas1).^2))<=eps
    break;
  end
  Mu_t=Mu_tmas1;
end

Mu_t

fprintf('Para K = %d:\n', k);

for i = 1:numel(C)
  fprintf('Centroide %d = %d\n', i, Mu_t(i));
  fprintf('C%d: \n', i);
  disp(C{1,i});
end  
