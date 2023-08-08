#!/bin/bash
#Obtener la cantidad de imágenes a generar como argumento
if [ $# -ne 1 ]; then   
    echo "Debe pasar la cantidad de imágenes necesarias para generar como argumento"
    exit 1
fi
if [ -f imagenes.zip ];
then
        rm -rf imagenes.zip 2>/dev/null 
fi
#Crear la carpeta para el almacenamiento de las imagenes y eliminarla por si existe
rm -rf imagenes 2>/dev/null
mkdir -p imagenes

cant_imagenes=$1
sleep_interval=2
# Descargar la lista de nombres
wget -O "nombres.csv" "https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv"


# Crear una matriz para almacenar los nombres de las imágenes generadas
nombres_imagenes=() # para almacenar los nombres de las imagenes generadas


# Generar imágenes
for ((i=1; i<=cant_imagenes; i++)); do
  
    nombre_imagen=$(sort -R "nombres.csv" | tail -n 1 | cut -d "," -f 1 | tr ' ' '_')
    wget -O "./imagenes/$nombre_imagen.jpg" "https://thispersondoesnotexist.com"
    nombres_imagenes+=("./imagenes/$nombre_imagen.jpg") # Agregar el nombre a la matriz
    sleep $sleep_interval
done

# Comprimir las imagenes

zip  imagenes.zip  imagenes/*.jpg

# Calcular la suma de verificación de imagenes.zip
sha256sum imagenes.zip > suma_verificacion.txt
awk '{print $1}' suma_verificacion.txt > tmp_suma_verificacion.txt
mv tmp_suma_verificacion.txt suma_verificacion.txt

#Eliminamos las imagenes individuales
rm -rf imagenes
echo "Se completo el proceso de  generacion de imagenes"

