#Imagen de Ubuntu
FROM ubuntu

VOLUME /home/ceciliabaronio/ProyectoEntorno

#Instalamos los programas necesarios para la ejecucion

RUN apt-get update && apt-get install -y git wget zip imagemagick file

#Agregamos los scripts 

ADD menu.sh /home/ceciliabaronio/ProyectoEntorno/menu.sh
ADD generar.sh /home/ceciliabaronio/ProyectoEntorno/generar.sh
ADD descargar.sh /home/ceciliabaronio/ProyectoEntorno/descargar.sh
ADD descomprimir.sh /home/ceciliabaronio/ProyectoEntorno/descomprimir.sh
ADD procesar.sh /home/ceciliabaronio/ProyectoEntorno/procesar.sh
ADD comprimir.sh /home/ceciliabaronio/ProyectoEntorno/comprimir.sh
ADD nombres.csv /home/ceciliabaronio/ProyectoEntorno/nombres.csv

#Cambiamos la ubicacion de trabajo del Proyecto

WORKDIR /home/ceciliabaronio/ProyectoEntorno
#Ejecutamos el menu.sh
CMD [ "bash", "/home/ceciliabaronio/ProyectoEntorno/menu.sh"]
