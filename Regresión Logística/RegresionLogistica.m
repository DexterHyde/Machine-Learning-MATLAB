  clear all
  close all

  function h=g(z)
    h=1/(1+exp(-z));
  end

  datos=load('datasetExamen.txt');
  x=datos(:,1:2);
  y=datos(:,3);

  #Separar las clases
  clase1=find(y==1);
  clase0=find(y==0);

  figure(1)
  hold on

  plot(x(clase1,1),x(clase1,2),'k+','MarkerSize',7);
  plot(x(clase0,1),x(clase0,2),'ko','MarkerFaceColor','m','MarkerSize',7);
  hold off

  #Normalizados:
  
  #X=zscore(x,1);
  X = x;

  #Graficas normalizadas
  figure(2)
  hold on
  plot(X(clase1,1),X(clase1,2),'k+','MarkerSize',7);
  plot(X(clase0,1),X(clase0,2),'ko','MarkerFaceColor','m','MarkerSize',7);
  hold off

  #Número de filas y columnas
  [m n]=size(X);
  X=[ones(m,1) X];
  n=n+1;

  #el vector a, si x tiene dos caracterísitcas, tenemos que añadir la columna de zeros, por ende a será un vector de 3.
  a=zeros(n,1);

  J=0;

  #Número máximo de iteraciones:
  iter_max=1;

  Beta=0.9;

  #vector de convergencia:
  convergencia=zeros(iter_max,1);

  #h la encontraremos al multiplicar a transpuesta por x | Calculado por cada dato de entrenamiento.

  #h será igual a 'a' transpuesta por X normalizada, en la fila, por todas las columnas que tenga esa fila.
  #Z = función sigmoide

  for i=1:m
    z=a'*X(i,:)';
    ha(i,1)=g(z);
    ha(i,1) = 0.3;
    #Calculamos J (función de costo)
    J(i)=-y(i)*log(ha(i))-(1-y(i))*log(1-ha(i));
  end

  J=(1/m)*sum(J);
  J



  for iter=1:iter_max
    
    #J tiene que recorrer todos los valores (n) para actualizar a0, a1 y a2.
    for j=1:n
      a(j)=a(j)-Beta*((1/m)*sum((ha-y).*X(:,j)));
    end
    
    a = [1  1 1]';
    
    
    for i=1:m
      z=a'*X(i,:)';
      z = 0.1
      ha(i,1)=g(z);
      
      #Calculamos J (función de costo)
      J(i)=-y(i)*log(ha(i))-(1-y(i))*log(1-ha(i));
    end
    
    J=(1/m)*sum(J);
    convergencia(iter)=J;
    
  end

  figure(3)
  plot(convergencia)
  X
  ha
  J
  a
  
  x1=-2:0.1:1.4;
  x2=(-a(1)-a(2)*x1)/a(3);
  
  #Dibujaremos las rectas x1 y x2
  figure(2)
  hold on
  plot(x1,x2,'r')
  hold off
  
  #Indices escogidos de prueba:
  
  indices = [1 4 80];
  
  for i = 1:length(indices)
    indice = indices(i);
    datoPrueba = X(indice, :);
    z = a'*datoPrueba';
    h_prueba = g(z)
    
    if h_prueba >= 0.5
      clasePrueba = 1;
    else
      clasePrueba = 0;
    end
    
    clasePrueba
    
    disp('');
  end  








