clear all
close all

#cargar datos
datos=load('dataSet_kmeans2D_iris.txt');
x=datos;

#Filas y columnas
[m,n]=size(x);

#Normlizar
x=zscore(x,1);

#Primer figura
figure(1)
plot(x(:,1),x(:,2),'ko','MarkerSize',10)

hold on


#Número de centroides
k=4;


#Centroides iniciales (aleatorios)

#Límites inferior y superior:
lim_inf=min(x);
lim_sup=max(x);


Mu_t=rand(k,n).*(lim_sup-lim_inf)+lim_inf;


Mu_tmas1=zeros(k,n);

plot(Mu_t(:,1),Mu_t(:,2),'kd','MarkerFaceColor','c','MarkerSize',10)

hold off

color=['y','m','g','b','r'];

#Save starting clusters
save = strcat("clustersinicialesk",int2str(k),".jpg");
saveas(figure(1),save)

while(true)

  C=cell(1,k);
  

  for i=1:m
    
      
    for j=1:k
      dist(j)=sum((x(i,:)-Mu_t(j,:)).^2);
    end
    
    [~,ind]=min(dist);
    
    C{ind}=[C{ind};x(i,:)];
    
  end
  
  figure(1)
  plot(x(:,1),x(:,2),'ko','MarkerSize',10)

  hold on
  
  plot(Mu_t(:,1),Mu_t(:,2),'kd','MarkerFaceColor','c','MarkerSize',10)
  
  for j=1:k
    
    if isempty(C{j})
      Mu_tmas1(j,:)=0;
    else
      plot(C{j}(:,1),C{j}(:,2),'ko','MarkerFaceColor',color(j),'MarkerSize',10)
    
      Mu_tmas1(j,:)=mean(C{j});
    end
  end
  #pause(0.5)
  plot(Mu_tmas1(:,1),Mu_tmas1(:,2),'*')
  hold off
  
  for j=1:k
    
    distMu(j)=sqrt(sum((Mu_tmas1(j,:)-Mu_t(j,:)).^2));
    
  
end

  if sum(distMu)<=eps
    break;
    
  end
  
  Mu_t=Mu_tmas1;
end

fprintf("Para k=%i:\n\n",k)

for i=1:size(Mu_t)(1)
  fprintf("Centroide %i =",i);
  disp(Mu_t(i,:));
  fprintf("C%i: %d datos\n\n", i, size(C{i}));
end

#Save figure automatically:
save = strcat("clustersFinalesk",int2str(k),".jpg");
saveas(figure(1),save)

#size(Mu_t)(1)

#C