#!/bin/bash

# Verificamos si existe el archivo descargado o se creó en los scripts anteriores; si existe, se descomprime
if [[ -f imagenes.zip ]]; then
        echo "Existe el archivo imagenes.zip"
        if  [[ -d imagenes_descomprimidas ]];
        then
                rm -r imagenes_descomprimidas
        fi

        mkdir imagenes_descomprimidas
# Descomprimir cada archivo dentro de imagenes.zip
	for archivo in imagenes.zip/*; do	
        	unzip imagenes.zip -d imagenes_descomprimidas
	done
        echo "Se descomprimió correctamente."
        
       
else
         echo "El archivo imagenes.zip no existe."
         exit 1
fi



#Elimino el archivo imagenes.zip
rm imagenes.zip

