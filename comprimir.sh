#!/bin/bash

# Generar archivo con la lista de nombres de todas las imágenes
if [ -d imagenes_descomprimidas/imagenes ] ; then
	ls imagenes_descomprimidas/imagenes |cut -d "." -f 1 > nombres_imagenes.txt
	echo " Se creo el archivo nombres_imagenes.txt"
fi
# Generar una lista con los nombres válidos
if [ -d imagenes_procesadas ] ; then
	ls imagenes_procesadas |cut -d '_' -f 1,2 | cut -d '.' -f1  > lista_nombres_validos.txt
	echo " Se creo el archivo lista_nombres_validos.txt"
fi
# Generar archivo con el total de personas cuyo nombre finaliza con la letra 'a'
if [ -f lista_nombres_validos.txt ]; then
	cat lista_nombres_validos.txt | grep -E '^[[:upper:]][[:lower:]_]+(_[[:upper:]][[:lower:]_]+)*[[:lower:]]*a$' | wc -l > total_personas_finaliza_con_a.txt
	echo " Se creo el archivo total_de_personas_finaliza_con_a.txt "	
fi

# Verificar si los archivos existen antes de crear el archivo comprimido
if [ -f nombres_imagenes.txt ] && [ -f lista_nombres_validos.txt ] && [ -f total_personas_finaliza_con_a.txt ]; then
# Crear archivo comprimido que incluya todos los archivos generados y las imágenes procesadas
	zip -r imagenesdefinitivas.zip imagenes_descomprimidas imagenes_procesadas nombres_imagenes.txt lista_nombres_validos.txt total_personas_finaliza_con_a.txt;
    echo "Se comprimieron las imágenes"
    # Borrar los archivos y directorios generados después de la compresión exitosa
    rm -r imagenes_descomprimidas imagenes_procesadas nombres_imagenes.txt lista_nombres_validos.txt total_personas_finaliza_con_a.txt
else    
	echo "No se pudieron comprimir las imágenes"
	exit 1
fi


