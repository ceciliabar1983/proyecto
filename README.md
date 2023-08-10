# TUIA - TP ENTORNO DE PROGRAMACION

Baronio Cecilia Florencia

## Descripcion 
El objetivo del trabajo práctico es diseñar y escribir un programa para procesar un lote de imágenes. Este programa consta de cuatro partes principales:

En primer lugar, para obtener un conjunto de imágenes se debe poder elegir entre generar el conjunto descargando las imágenes individualmente o descargarlas desde un servicio web con su suma de verificación, verificando la misma.
Se presentará una opción para descomprimir un archivo con imágenes.
Luego se debe aplicar una transformación solamente a las imágenes de personas.
Finalmente se debe generar un archivo comprimido con las imágenes procesadas y algunos datos extra.

### Explicacion de cada uno de los scripts:

#### generar.sh

Este script de permite generar imágenes aleatorias descargadas de "https://thispersondoesnotexist.com/"

1) Verifica si se ingresaron la cantidad de argumentos necesarios, si no se ingresan argumentos solicita que se ingrese la cantidad de imagenes a generar. 
2) Elimina el archivo imagenes.zip si el mismo existe. 
3) Elimina si existe y crea la carpeta imagenes donde se van a almacenar las imagenes generadas individualmente.
4) Descarga la lista de nombres de "https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv" 
5) Se generan nombres aleatorios a partir del archivo nombres.csv, descargando las imágenes de "https://thispersondoesnotexist.com" utilizando esos nombres y almacenandolos en la carpeta ./imagenes. 
Espera un intervalo de 2 segundos entre la descarga de una imagen y la siguiente. Por ej en la lista aparece Aaron Ariel, 126. Una vez seleccionado aleatoriamente el nombre elimina la coma y toma todo el nombre completo, luego reemplaza el espacio por guion bajo.
6) Comprime las imagenes contenidas en la carpeta imagenes
7) Genera la suma de verificacion de imagenes.zip.

#### descargar.sh

Primeramente se pasan dos argumentos uno correspondiente a la url que contiene las imagenes comprimidas y otra a la suma de verificacion. Para generar la url, cargue los archivos en github, y modifique las url para que me descargue el archivo subido y no el contenido de la url.
Por ejemplo: https://raw.githubusercontent.com/ceciliabar1983/proyecto/main/imagenes.zip  https://raw.githubusercontent.com/ceciliabar1983/proyecto/main/suma_verificacion.txt 
1) Verifica que se ingresen dos argumentos 
2) Elimina los archivos imagenes.zip y suma_verificacion.txt 
3) Descarga el contenido de las url pasadas como argumentos: el archivo suma_verificacion.txt contiene solo el hash SHA-256 del archivo imagenes.zip y no el nombre del archivo; por lo cual para generar la suma de verificacion de imagenes.zip debemos eliminar el espacio y tomar la primera columna. 
4) Se realiza la comparacion de dichas sumas de verificacion

#### descomprimir.sh

1) Verificamos que exista el archivo imagenes.zip; si es asi verificamos si existe la carpeta imagenes_descomprimidas si es asi la eliminamos y la volvemos a crear. 
2) Descomprimos cada foto incluida en imagenes.zip y la guardamos en imagenes_descomprimidas.

#### procesar.sh 
Primero creamos la carpeta imagenes_procesadas para poder guardar alli las imagenes recortadas 
Luego si existe la carpeta imagenes_descomprimidas, procede a iterar sobre los archivos que se encuentran en el directorio, tomando solo el nombre del archivo sin su ruta ni extension(jpg). 
Verifica que el tipo de archivo sea una imagen, y procede a procesar las imagenes con nombres validos, es decir : que comience con una letra mayúscula, seguido de una o más combinaciones de palabras separadas por guiones bajos; cada de palabra comienza con una letra mayúscula y está seguida por letras minúsculas y guiones bajos opcionales.

#### miniaturas.sh
1. Verifico que el archivo imagenes.zip exista y la descomprimo en imagenes_descomprimidas_con_miniatura.
2. Creo la carpeta imagenes_procesadas_con_miniatura, la elimino si existe y la vuelvo a generar. 
3. Modifico el tamaño de las imagenes que se encuentran en la carpeta imagenes_descomprimidas_con_miniatura al tamaño 48 x 48 y las guardo con el nombre de la imagen agregandole el texto con miniatura y la extension jpg en la carpeta imagenes_procesadas_con_miniaturas 
4. Vuelvo a comprimir el contenido de la carpeta imagenes_procesadas_con_miniaturas

#### comprimir.sh

Genera un archivo con los nombres de las imagenes descomprimidas( nombres_imagenes.txt)
Genera un archivo con los nombres validos de las imagenes procesadas, que comiencen en mayuscula y sigan en minuscula
Genera un archivo con los nombres de las imagenes procesadas que terminen en a 
Crea un archivo comprimido con los archivos generados anteriormente eliminando lo que se comprimio.

#### Un menu con los scripts anteriores:
En el menu se ofrecen las opciones para poder ejecutar cada uno de los scripts:
1. Generar
2. Descargar
3. Descomprimir
4. Procesar
5. Procesar miniaturas
6. Comprimir
7. Salir


Creacion del Dockerfile.

FROM ubuntu
Crea la imagen de ubuntu a partir de la ultima version
LABEL maintainer="Cecilia Baronio <baronio_cecilia@hotmail.com>"
Crea una etiqueta con los datos del creador del archivo y la direccion de correo
WORKDIR /home/ceciliabaronio/modificacion/proyecto
Establece la ubicacion del directorio de trabajo,es decir, el directorio en el que se ejecutarán los comandos y se buscarán los archivos por defecto cuando el contenedor esté en funcionamiento.
# Agregar actualización de la lista de paquetes antes de la instalación
RUN apt-get update && apt-get install -y \
        git wget zip imagemagick file && \
        rm -rf /var/lib/apt/lists/*
Utilizo RUN apt-get update && apt-get install -y para garantizar que el Dockerfile instale las últimas versiones del paquete sin más codificación ni intervención manual. Instala en la segunda linea y actualiza los paquetes que se mencionan.
En la tercera linea se limpia el caché de apt eliminándolo,es decir, reduce el tamaño de la imagen, ya que el caché de apt no se almacena en una capa. 
COPY menu.sh ./
COPY generar.sh ./
COPY descargar.sh ./
COPY descomprimir.sh ./
COPY procesar.sh ./
COPY miniaturas.sh ./
COPY comprimir.sh ./
COPY nombres.csv ./
Utilizo COPY ya que solo admite la copia básica de archivos locales en el contenedor, ya que son varios archivos que son necesarios copiar conviene hacerla la copia individualmente.
RUN chmod +x *.sh
Les doy permiso de ejecucion a cada uno de los scripts.
CMD [ "/bin/bash", "menu.sh"]
CMD está configurando el contenedor para que ejecute el script menu.sh usando el intérprete de comandos /bin/bash

Para poder ejecutar el menu desde cualquier ubicacion previamente es necesario hacer los siguientes pasos:

#Crear una carpeta en la ubicacion actual, por ej ceciliab1
#Ir a esa carpeta, ej cd ceciliab1
#Clonar el proyecto
git clone https://github.com/ceciliabar1983/proyecto.git
De esta manera podemos ejecutar el menu:
./menu.sh

Para poder crear y ejecutar el Dockerfile:

Una vez generado el contenido ejecutamos el siguiente comando:  sudo docker build -t tpentorno . 
Verificamos que se haya creado la imagen con el comando docker images , se creo una imagen con el nombre tpentorno con el ID 792154da9200 Corremos el contenedor: sudo docker run -it -v /home/ceciliabaronio/:/modificacion/proyecto tpentorno, en mi caso lo corri de esta manera pero es necesario cambiarlo con la ubicacion actual.
Al ejecutarlo nos aparecera el menu de opciones que nos permiten ejecutar los scripts.
