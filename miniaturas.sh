#!/bin/bash

# Verificar si existe la carpeta "imagenes.zip" en la ubicación actual
if [ -f imagenes.zip ]; then
    # Descomprimir el archivo imagenes.zip en la carpeta "imagenes_descomprimidas_con_miniaturas"
	if [ -d imagenes_descomprimidas_con_miniaturas ]; then
        
    		rm -rf  imagenes_descomprimidas_con_miniaturas  2>/dev/null
		unzip imagenes.zip -d imagenes_descomprimidas_con_miniaturas
    	fi
    # Crear la carpeta "imagenes_procesadas_con_miniaturas"
	 if [ -d imagenes_procesadas_con_miniaturas ]; then

		rm  -rf imagenes_procesadas_con_miniaturas 2>/dev/null
	    	mkdir -p imagenes_procesadas_con_miniaturas
	fi
    # Modificar el tamaño a miniatura
    for archivo in imagenes_descomprimidas_con_miniaturas/imagenes/*.jpg ; do
        nombre_archivo=$(basename "$archivo")
        nombre_persona="${nombre_archivo%.*}"

        # Redimensionar la imagen a 48x48 y guardarla en la carpeta "imagenes_procesadas_con_miniaturas"
        convert "$archivo" -resize 48x48 "imagenes_procesadas_con_miniaturas/${nombre_persona}_imagen_con_miniaturas.jpg"
    done

    # Comprimir las imágenes procesadas en un nuevo archivo "imagenes_procesadas_con_miniaturas.zip"
    zip -r imagenes_procesadas_con_miniaturas.zip imagenes_procesadas_con_miniaturas

 fi
