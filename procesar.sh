#!/bin/bash
# Crear la carpeta "imagenes_procesadas" si no existe
mkdir -p imagenes_procesadas

# Verificar si existe el directorio "imagenes_descomprimidas" en la ubicación actual
if [ -d imagenes_descomprimidas ]; then
    # Recortar las imágenes al tamaño deseado y moverlas a "imagenes_procesadas"
    for archivo in ./imagenes_descomprimidas/imagenes/*.jpg ; do
        nombre_archivo=$(basename "$archivo") #extrae solo el nombre del archivo
        nombre_persona="${nombre_archivo%.*}"  # Eliminar extensión del archivo

        # Verificar si el archivo es una imagen JPEG válida
        if file "$archivo" | grep -q "JPEG image data"; then
            # Verificar si el nombre es válido
	    if [[ $nombre_persona =~ ^[[:upper:]][[:lower:]_]+$ ]]; then

           # if [[ $nombre_persona =~ ^[[:upper:]][[:lower:]]+$ ]]; then
                # Recortar la imagen y guardarla en "imagenes_procesadas"
                convert "$archivo" -resize 512x512 "imagenes_procesadas/${nombre_persona}_recortada.jpg"
                echo "Se ha procesado la imagen ${nombre_persona}_recortada.jpg"
            else
                echo "Nombre de archivo no válido: ${nombre_archivo}"
            fi
        else
            echo "Archivo no válido o no es una imagen JPEG: ${nombre_archivo}"
        fi
    done

    echo "Procesamiento completo."
else
    echo "Error: No se encuentra el directorio 'imagenes_descomprimidas' o no existe."
fi



