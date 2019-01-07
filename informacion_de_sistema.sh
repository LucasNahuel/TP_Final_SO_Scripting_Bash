#!/bin/bash

#
#	Autores: Muñoz Lucas, Erik Ayala
#
#
#	Consigna: Escribir un script que muestre por pantalla informacion del sistema donde se ejecuta.
#	El informe debe incluir la siguiente información, delimitada por titulos descriptivos.-
#
#	Fecha del reporte. 
#	Version del equipo y kernel 
#	version del S.O.
#	Hardware: Procesador, memoria y perifericos. 
#	Espacio de disco y particiones montadas 

echo -e "\033[0;34mFecha del reporte\033[0;0m \n ";
echo -e "\t" `date '+%Y-%m-%d %H:%M:%S'` "\n";


echo -e "\033[0;34mVersión del equipo y kernel\033[0;0m";

echo -e "\t" `uname -n`;
echo -e "\t" `uname -m`;
echo -e "\t" `uname -v`;


echo -e "\033[0;34m Sistema Operativo y Version \033[0;0m"

#se muestra el nombre del sistema operativo
echo -e "\t" `uname -o`;

#se guarda la información de la version del sistema opertivo en una variable
DESCRIPCION=$(lsb_release -d);

#muestra la version del sistema operativo
echo -e "$DESCRIPCION" | cut -d: -f2-;

#información del procesador, memoria y perifericos

echo -e "\033[0;34m Información del procesador, memoria y perifericos \033[0;0m";

#procesador
lscpu | while IFS= read -r line; do
	echo -e "\t $line";
done

echo -e "\t\t\t\t";
#memmoria
cat /proc/meminfo | while IFS= read -r line; do
	echo -e "\t $line";
done
echo -e "\t\t\t\t";


#perifericos
lspci | while IFS= read -r line; do
	echo -e "\t $line";
done
echo -e "\t\t\t\t";






echo -e "\033[0;34mEspacio de disco y particiones montadas \n\033[0;0m";
#se utiliza el comando df para listar las particiones y sus tamaños, sumando las columnas para 
#determinar cada valor (espacio libre y usado)
ESPACIO_LIBRE=`df -B G | awk 'NR>2{sum+=$2}END{print sum}'`;
ESPACIO_USADO=`df -B G | awk 'NR>2{sum+=$3}END{print sum}'`;

#se muestra por pantalla los valores de uso y espacio libre de disco 
echo -e "\t Tienes utilizados $ESPACIO_USADO GB de tus $ESPACIO_LIBRE GB totales \n";
#se muestran todas las particionesw
echo -e "\033[0;34mTus particiones son: \n\033[0;0m";

lsblk | while IFS= read -r line; do
	echo -e "\t $line";
done
echo -e "\t\t\t\t";


exit 0;
