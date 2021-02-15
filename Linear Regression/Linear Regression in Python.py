import pandas as pd
import numpy as np
#Initial values
a0 = 0
a1 = 0
beta = 0.023
itera = 600

#Read and save data into numpy vectors
data = pd.read_csv("dataset_RegresionLineal.txt", header=None).values
vectorX = data[:,0]
vectorY = data[:,1]
h = a0 + a1*vectorX
m = vectorX.shape[0]
#Algorithm:
for i in range(itera):
    a0-= beta*(1/m) * sum(h - vectorY)
    a1-= beta*(1/m) * sum((h - vectorY) * vectorX)
    h = a0 + a1 * vectorX
    errorJ = (1/(2*m)) * sum(np.power(h - vectorY, 2))

#Testing:
datoPrueba = 9.7687
hPrueba = a0 + a1*datoPrueba

#Print:
print(f"J= {errorJ}, a0= {a0}, a1= {a1}")
print(f"Dato de prueba x= {datoPrueba}, predicciónh= {hPrueba}")