#!/bin/bash
if [ $# -ne 2 ]; then
	echo "Error. Debe ingresar dos argumentos."
	exit 1
fi

if [ -f imagenes.zip ]; then
	rm imagenes.zip
fi
if [ -f suma_verificacion.txt ]; then
        rm suma_verificacion.txt
fi

url_imagenes=$1
url_sumaverificacion=$2

# Verifica si se han proporcionado las dos URLs solicitadas como argumentos
if [ $# -eq 2 ]; then
#Descargar la imagen comprimida y la suma de verificacion

	wget  "$url_imagenes"  -O imagenes.zip
	wget  "$url_sumaverificacion" -O suma_verificacion.txt  
 
   	# Obtenemos la suma de verificacion de las url proporcionadas
	suma_verificacion_imagenes_generadas=$(sha256sum imagenes.zip | cut -d " " -f 1)
	
	suma_verificacion_imagenes_descargadas=$(cat suma_verificacion.txt) 

	#Verificamos que coincidan 

	if [ "$suma_verificacion_imagenes_generadas" == "$suma_verificacion_imagenes_descargadas" ] ; then
    		echo "La suma de verificación es correcta. Descarga exitosa."
	# Elimino el archivo suma_verificacion.txt 
		rm suma_verificacion.txt    
		echo " Se elimino el archivo suma_verificacion.txt "
  	else
    		echo "Error: La suma de verificación no coincide. La descarga puede estar corrupta."
  	fi


	
fi
