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
5) Se elimina el archivo suma_verificacion.txt

#### descomprimir.sh

1) Verificamos que exista el archivo imagenes.zip
2) En caso de existir,   si existe la carpeta imagenes_descomprimidas la elimino y la vuelvo a crear. 
3) Descomprimo cada foto incluida en imagenes.zip y la guardo en imagenes_descomprimidas.

#### procesar.sh 

1) Primero creamos la carpeta imagenes_procesadas para poder guardar alli las imagenes recortadas 
2) Luego si existe la carpeta imagenes_descomprimidas, procede a iterar sobre los archivos que se encuentran en el directorio, tomando solo el nombre del archivo sin su ruta ni extension(jpg). 
3) Verifica que el tipo de archivo sea una imagen, y procede a procesar las imagenes con nombres validos, es decir : que comience con una letra mayúscula, seguido de una o más combinaciones de palabras separadas por guiones bajos; cada de palabra comienza con una letra mayúscula y está seguida por letras minúsculas y guiones bajos opcionales.

#### miniaturas.sh
1. Verifico que el archivo imagenes.zip exista, si es asi tambien verifico si existe la carpeta  imagenes_descomprimidas_con_miniaturas, la elimino, y muestro el mensaje por pantalla.
2. Descomprimo imagenes.zip en imagenes_descomprimidas_con_miniatura.
3. Verifico si existe la carpeta imagenes_procesadas_con_miniaturas, si es asi la elimino y muestro el mensaje por pantalla.
4. Creo la carpeta imagenes_procesadas_con_miniatura.
5. Modifico el tamaño de las imagenes que se encuentran en la carpeta imagenes_descomprimidas_con_miniatura al tamaño 48 x 48 y las guardo con el nombre de la imagen agregandole el texto con_miniatura y la extension jpg. Las guardo en la carpeta imagenes_procesadas_con_miniaturas y muestro el mensaje informando que se generaron las imagenes con miniaturas.
6. Si existe la carpeta imagenes_procesadas_con_miniaturas,  comprimo el contenido de la carpeta en imagenes_procesadas_con_miniaturas.zip. Muestro el mensaje por pantalla si la comprension fue exitosa.
7. Elimino los archivos y carpetas imagenes_procesadas_con_miniaturas imagenes_descomprimidas_con_miniaturas imagenes.zip.
8. Sino se pudo realizar la comprension correctamente, muestro el mensaje por pantalla.

#### comprimir.sh

1) Inicialmente verifico si existe el directorio, imagenes_descomprimidas/imagenes, si es asi veo el contenido de dicho directorio con el comando 'ls',aplico una tuberia utilizando el ´cut -d "." -f 1', es decir toma el separador '.' y solo muestra la primera parte de cada archivo.  El resultado anterior se guarda en un archivo 'nombres_imagenes.txt'.
2) Verifica si existe, imagenes_procesadas, si es asi, veo el contenido de la carpeta imagenes_procesadas con el comando 'ls',luego aplico una tuberia para poder obtener la informacion necesaria, de la siguiente manera:   
awk -F '_recortada' '{print $1}'  Lo que efectua este comando es tomar el contenido del nombre con la terminacion '_recortada.jpg', utilizando el separador '_recortada' y muestra solo la primera parte de cada linea . Por ej, Luciano_Domingo_recortada.jpg , obtendre Luciano_Domingo. Genera el archivo lista_de_nombres_validos.txt y emite el mensaje de que se genero el archivo .
4)   Si existe el archivo lista_de_nombres_validos.txt, veo el contenido del archivo con el comando 'cat', aplico una tuberia para poder buscar los nombres que empiecen con mayusculas sigan con una o mas minusculas y guion bajo, siga con un segundo nombre o apellido,y terminen con a( grep -E '^[[:upper:]][[:lower:]_]+(_[[:upper:]][[:lower:]_]+)*[[:lower:]]*a$') .Luego al resultado le aplico otra tuberia para que me cuente las lineas que cumplen esta condicion (wc -l). El resultado de todo esto lo muestra en el archivo total_de_personas_finaliza_con_a.txt. Ademas me mmuestra el mensaje que se creo el archivo
5)   Antes de proceder a comprimir los archivos generados, verifica que existan los mismos. En caso afirmativo genera el archivo comprimido  imagenesdefinitivas.zip incluyendo imagenes_descomprimidas imagenes_procesadas nombres_imagenes.txt lista_nombres_validos.txt total_personas_finaliza_con_a.txt. Me muestra el mensaje de que se comprieron los archivos
6) Borra los archivos incluidos en el archivo comprimido imagenesdefinitivas.zip
7) En caso de no encontrar los archivos : imagenes_descomprimidas imagenes_procesadas nombres_imagenes.txt lista_nombres_validos.txt total_personas_finaliza_con_a.txt. emite el mensaje informando que no se pudieron comprimir los archivos.

#### menu.sh :
En el menu se ofrecen las opciones para poder ejecutar cada uno de los scripts:
1. Generar
2. Descargar
3. Descomprimir
4. Procesar
5. Procesar miniaturas
6. Comprimir
7. Salir


## Creacion del Dockerfile.

#### FROM ubuntu        
Crea la imagen de ubuntu a partir de la ultima version        
#### LABEL maintainer="Cecilia Baronio <baronio_cecilia@hotmail.com>"        
Crea una etiqueta con los datos del creador del archivo y la direccion de correo        
#### WORKDIR /proyecto        
Establece la ubicacion del directorio de trabajo,es decir, el directorio en el que se ejecutarán los comandos y se buscarán los archivos por defecto cuando el contenedor esté en funcionamiento.        
Agregar actualización de la lista de paquetes antes de la instalación        
#### RUN apt-get update && apt-get install -y \        
####     git wget zip imagemagick file && \        
####     rm -rf /var/lib/apt/lists/*        
Utilizo RUN apt-get update && apt-get install -y para garantizar que el Dockerfile instale las últimas versiones del paquete sin más codificación ni intervención manual. Instala en la segunda linea y actualiza los paquetes que se mencionan.        
En la tercera linea se limpia el caché de apt eliminándolo,es decir, reduce el tamaño de la imagen, ya que el caché de apt no se almacena en una capa.         
#### COPY menu.sh ./        
#### COPY generar.sh ./        
#### COPY descargar.sh ./        
#### COPY descomprimir.sh ./        
#### COPY procesar.sh ./        
#### COPY miniaturas.sh ./        
#### COPY comprimir.sh ./        
#### COPY nombres.csv ./        
Utilizo COPY ya que solo admite la copia básica de archivos locales en el contenedor, como son varios archivos que son necesarios copiar conviene hacerla la copia individualmente.        
#### RUN chmod +x *.sh        
Les doy permiso de ejecucion a cada uno de los scripts.        
#### CMD [ "/bin/bash", "menu.sh"]        
CMD está configurando el contenedor para que ejecute el script menu.sh usando el intérprete de comandos /bin/bash        

### Para poder ejecutar el Dockerfile desde cualquier ubicacion  es necesario hacer los siguientes pasos:       
1)  Clonar el proyecto        
git clone https://github.com/ceciliabar1983/proyecto.git         
2) Ubicarse en el directorio que contiene el proyecto        
   cd proyecto
2) Construir el Dockerfile:        
    sudo docker build -t tpentorno .         
2) Verificamos que se haya creado la imagen con el comando:        
   docker images.
4) Corremos el contenedor:        
   sudo docker run -it -v $(pwd):/proyecto tpentorno        
   Este comando ejecuta un contenedor interactivo a partir de la imagen tpentorno con volumen,conectando una carpeta en el directorio actual con una carpeta dentro del contenedor con la ruta "/proyecto".        
5) Al ejecutarlo nos aparecera el menu de opciones que nos permiten ejecutar los scripts.
