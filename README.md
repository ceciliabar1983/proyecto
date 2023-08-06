TUIA - TP ENTORNO DE PROGRAMACION

Integrantes:
Baronio Cecilia Florencia

Descripcion
El objetivo del trabajo práctico es diseñar y escribir un programa para procesar
un lote de imágenes. Este programa consta de cuatro partes principales:
1. En primer lugar, para obtener un conjunto de imágenes se debe poder
elegir entre generar el conjunto descargando las imágenes individualmente o
descargarlas desde un servicio web con su suma de verificación, verificando
la misma.
2. Se presentará una opción para descomprimir un archivo con imágenes.
3. Luego se debe aplicar una transformación solamente a las imágenes de
personas.
4. Finalmente se debe generar un archivo comprimido con las imágenes
procesadas y algunos datos extra.

Explicacion de cada uno de los scripts:

1) generar.sh
   
   Este script de  permite generar imágenes aleatorias descargadas de "https://thispersondoesnotexist.com/"
   1°) Verifica si se ingresaron la cantidad de argumentos necesarios, si no se ingresan argumentos solicita que se ingrese la cantidad de imagenes a generar.
   2°) Elimina el archivo imagenes.zip si el mismo existe.
   3°) Elimina si existe y crea la carpeta imagenes  donde se van a almacenar las imagenes generadas individualmente.
   4°) Descarga la lista de nombres de "https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv"
   5°) Se generan nombres aleatorios a partir del archivo nombres.csv, descargando las imágenes de "https://thispersondoesnotexist.com" utilizando esos     nombres  y almacenandolos en la carpeta ./imagenes. Espera un intervalo de 2 segundos entre la descarga de una imagen y la siguiente. Por ej en la lista aparece  Aaron Ariel, 126. Una vez seleccionado aleatoriamente el nombre elimina la coma y toma todo el nombre completo, luego reemplaza el espacio por guion bajo.
   6°) Comprime las imagenes contenidas en la carpeta imagenes
   7°) Genera la suma de verificacion de imagenes.zip.
   
 2) descargar.sh
  
    Primeramente se pasan dos argumentos uno correspondiente a la url que contiene las imagenes comprimidas y otra a la suma de verificacion.
    Para generar la url, cargue los archivos en github, y modifique las url para que me descargue el archivo subido y no el contenido de la url. Por ejemplo:
    https://raw.githubusercontent.com/ceciliabar1983/proyecto/main/imagenes.zip         
    https://raw.githubusercontent.com/ceciliabar1983/proyecto/main/suma_verificacion.txt
    1°) Verifica que se ingresen dos argumentos
    2°) Elimina los archivos imagenes.zip y suma_verificacion.txt
    3°) Descarga el contenido de las url pasadas como argumentos: el archivo suma_verificacion.txt contiene solo el hash SHA-256 del archivo imagenes.zip y 
    no el nombre del archivo; por lo cual para generar la suma de verificacion de imagenes.zip debemos eliminar el espacio y tomar la primera columna.
    4°) Se realiza la comparacion de dichas sumas de verificacion
    
3) descomprimir.sh
   
   Primero verificamos que exista el archivo imagenes.zip; si es asi verificamos si existe la carpeta imagenes_descomprimidas si es asi la eliminamos y la 
   volvemos a crear.
   Luego descomprimos cada foto incluida en imagenes.zip y la guardamos en imagenes_descomprimidas.
   Posteriormente elimino el archivo imagenes.zip
   
4) procesar.sh
   Primero creamos la carpeta imagenes_procesadas para poder guardar alli las imagenes recortadas
   Luego si existe la carpeta imagenes_descomprimidas, procede a iterar sobre los archivos que se encuentran en el directorio, tomando solo el nombre del archivo sin su ruta ni extension(jpg).
   Verifica que el tipo de archivo sea una imagen, y  procede a procesar las imagenes con nombres validos, es decir que empiecen con mayuscula sigan con minuscula o guion bajo?
   
5) comprimir.sh
   
   Genera un archivo con los nombres de las imagenes descomprimidas( nombres_imagenes.txt)
   Genera un archivo con los nombres validos de las imagenes procesadas, que comiencen en mayuscula y sigan en minuscula
   Genera un archivo con los nombres de las imagenes procesadas que terminen en a
   Crea un archivo comprimido con los archivos generados anteriormente eliminando lo que se comprimio.
6) Un menu con los scripts anteriores

Creacion del Dockerfile.

Una vez generado el contenido ejecutamos el siguiente comando:
sudo docker build -t tpentorno /home/ceciliabaronio/ProyectoEntorno o bien sudo docker build -t tpentorno .
Verificamos que se haya creado la imagen con el comando docker images , se creo una imagen con el nombre tpentorno con la ID b44b5005cf16
Corremos el contenedor:
sudo docker run -it -v /home/ceciliabaronio/:/ProyectoEntorno tpentorno

Posteriormente en la pagina de docker hub, realizo el registro para poder generar un repositorio remoto:
usuario:ceciliabaronio; contraseña:
1)   En la terminal utilizo el comando "docker login" para poder acceder a docker hub
2)   Creo un repositorio remoto llamado trabajoentorno en docker hub
3)   Lo genero en la terminal: docker push ceciliabaronio/trabajoentorno:v.1
4)   Creo una etiqueta para el repositorio
5)   Genero la etiqueta en la consola: docker tag tpentorno ceciliabaronio/trabajoentorno:v.1

Para poder ejecutar el contenedor desde cualquier ubicacion una opcion es: 
crear la imagen  ejecutando:  sudo docker build -t tpentorno .
Luego ejecutar la imagen:
sudo docker run -it -v /ubicacion_ejecucion/:/home/ceciliabaronio/ProyectoEntorno tpentorno

Otra opcion es ejecutar la imagen de docker hub:
1) Hacer un pull de la imagen : sudo docker pull ceciliabaronio/trabajoentorno:v.1
2) Ejecutar la imagen: sudo docker run -it -v /ubicacion_actual/:/home/ceciliabaronio/ceciliabaronio/trabajoentorno:v.1
Se ejecutara el Docker mostrando el menu de opciones








   
   
   
   
    
    
    

