#!/bin/bash

#Autores: Muñoz Lucas, Erik Ayala

#Consigna: Escribir un script que se ejecute en segundo plano y verifique continuamente,
#cada cierto tiempo, la conectividad con un determinado host mediante el comando ping.
#Tanto el host como el tiempo entre verificación deberan ser ingresados por el usuario.
#El script debera generar un archivo llamado ping-<host> con informacion resultante.
#hora,fecha, host y si se realizo la conexion.-

#Recibe la ip como primer argumento
IP=$1;
#Recibe el tiempo de delay en segundos como segundo argumento
DELAY=$2;

#Realiza un bucle infinito probando el ping
while [[ true ]]; do
	#si ping retorna '1 received' de un paquete enviado, la conexion fue exitosa
	if ((`ping -c1 $IP | grep -c "1 received"` == "1"))
	then
		echo -e `date '+%d-%m-%Y %H:%M:%S'`"====> $IP ====> \033[0;32m se realizó la conexión\033[0;0m" >> "ping-$IP";
	else
		echo -e `date '+%d-%m-%Y %H:%M:%S'`"====>  $IP ====> \033[0;31m no completó la conexión\033[0;0m">> "ping-$IP";
	fi
	#se pausa la ejecucion por el tiempo del delay
	sleep $DELAY ;
done

exit 0;
