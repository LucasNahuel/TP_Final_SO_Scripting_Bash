#	!/bin/bash

#	Autores: Erik Ayala, Muñoz Lucas

#	Consigna: Escribir un script que reciba por entrada estandar un nombre de proceso (comando o script) y determine 
#	si dicho proceso se encuentra en ejecución, mostrando informacion detallada sobre el mismo a partir de
#	informacion almacenada en el directorio proc.
#	ademas ofrecer la posibilidad de cerrar el proceso (matarlo)


#pide el nombre del proceso a buscar y lo guarda en una variable

echo -e "Ingrese el nombre del proceso a tratar:";

NOMBRE_PROC="";

PID="";

read NOMBRE_PROC;

#se asegura que el proceso exista

COINCIDENCIAS=` ps -A | grep -c $NOMBRE_PROC `;


#vuelve a pedir el nombre del proceso hasta que se ingrese uno existente
while (( $COINCIDENCIAS == 0 )); do
	echo -e "Error: no hay ningun proceso con ese nombre \n Ingresa un nombre de proceso válido";

	read NOMBRE_PROC;

	COINCIDENCIAS=` ps -A | grep -c $NOMBRE_PROC `;
done

	#si hay varios procesos con el mismo nombre se pide elegir el correcto con un nro
	if(( COINCIDENCIAS > 1 ))
	then
		echo -e "Hay varios procesos con ese nombre: \n";

		TABLA=`ps -A | grep $NOMBRE_PROC`;

		NRO=0;

		echo "$TABLA" | while read -r linea; do
		    let NRO++;
		    echo "$NRO) $linea";
		done

		echo -e "ingresa el nro de el proceso especifico \n";


		read NRO;

		#itera hasta que se ingrese un nro correcto

		while (( $NRO<1 || $NRO>$COINCIDENCIAS )); do
			echo "Error: nro incorrecto. Ingresa un nro de proceso correcto";
			read NRO;
		done

			PROC=( ` echo "$TABLA" | sed -n ${NRO}p ` );
		else
			PROC=( ` ps -A | grep $NOMBRE_PROC ` );
	fi;



PID=${PROC[0]};

echo -e "Aqui tienes información del status del proceso obtenida del directorio /proc \n";


#se muestra por pantalla el status del proceso
cat "/proc/$PID/status";

echo -e "\n\n\n\n\nDeseas terminar el proceso? (y/n si o no)"

OPCION="";

#se ingresa 'y' para matar el proceso, 'n' para terminar
read OPCION;
#se itera hasta que se ingrese una opcion correcta
while [[ "$OPCION" != 'y' && "$OPCION" != 'n' ]] ; do
	echo "Error: opcion incorrecta. Ingrese 'y' para terminar el proceso o 'n' para terminar este script";

	read OPCION;
done;

#si se elige 'y', se utiliza el comando kill para matar el proceso
if [[ "$OPCION" == 'y' ]]; then
	kill $PID;
	echo -e "\033[0;32m Proceso terminado exitosamente \033[0;0m";
fi;

exit 0;
