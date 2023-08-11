#Imagen de Ubuntu
FROM ubuntu
#Genero la etiqueta maintainer

LABEL maintainer="Cecilia Baronio <baronio_cecilia@hotmail.com>"
# Establezco el directorio de trabajo
WORKDIR /proyecto

#Instalo los programas necesarios para la ejecucion

RUN apt-get update && apt-get install -y \
        git wget zip imagemagick file && \
        rm -rf /var/lib/apt/lists/*

# Agrego los scripts necesarios y archivos 
COPY menu.sh ./
COPY  generar.sh ./
COPY  descargar.sh ./
COPY  descomprimir.sh ./
COPY  procesar.sh ./
COPY  miniaturas.sh ./
COPY  comprimir.sh ./ 
COPY nombres.csv ./

# Habilitar permisos de ejecución en los archivos .sh
RUN chmod +x *.sh

#Ejecutamos el menu.sh
CMD [ "/bin/bash", "menu.sh"]
