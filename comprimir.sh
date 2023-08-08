#!/bin/bash

# Generar archivo con la lista de nombres de todas las imágenes
ls imagenes_descomprimidas > nombres_imagenes.txt

# Generar una lista con los nombres válidos
ls imagenes_procesadas | grep -oE '^[A-Z][a-z]+$' > lista_nombres_validos.txt

# Generar archivo con el total de personas cuyo nombre finaliza con la letra 'a'
ls imagenes_procesadas | grep -c '^[A-Z][a-z][a]$' > total_personas_finaliza_con_a.txt

# Crear archivo comprimido que incluya todos los archivos generados y las imágenes procesadas
if zip -r imagenesdefinitivas.zip imagenes_descomprimidas imagenes_procesadas nombres_imagenes.txt lista_nombres_validos.txt total_personas_finaliza_con_a.txt; then
    echo "Se comprimieron las imágenes"
    
    # Borrar los archivos y directorios generados después de la compresión exitosa
    rm -r imagenes_descomprimidas imagenes_procesadas nombres_imagenes.txt lista_nombres_validos.txt total_personas_finaliza_con_a.txt
else
    echo "No se pudieron comprimir las imágenes"
    exit 1
fi


