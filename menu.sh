#!/bin/bash
# Menú de opciones
while true; do
	echo "===== MENÚ ====="
	echo "1. Generar imágenes"
	echo "2. Descargar imágenes"
	echo "3. Descomprimir imágenes"
	echo "4. Procesar imágenes"
	echo "5. Procesar miniaturas"
	echo "6. Comprimir archivos"
	echo "7. Salir"

    read -p "Ingrese el número de opción: " opcion

    case $opcion in
        1)
		read -p "Ingrese la cantidad de imágenes a generar: " cantidad
		source generar.sh "$cantidad"
            	;;
        2)
           	read -p "Ingrese por argumentos dos URL (una para las imágenes y otra para la suma de verificación): " url_imagenes url_sumaverificacion
            	source descargar.sh "$url_imagenes" "$url_sumaverificacion"
            	;;
        3)
            	source descomprimir.sh
           	;;
        4)
           	 source procesar.sh
            	;;
        5)
            	source comprimir.sh
            	;;
	6) 
	   	source miniaturas.sh
		;;
        7)
           	 echo "Saliendo..."
            	break
           	 ;;
        *)
            echo "Opción inválida. Intente nuevamente."
            ;;
    esac
done
