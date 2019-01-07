#!/bin/bash

#**************************************************************************************
#autores: Erik Ayala, Muñoz Lucas
#
#enunciado: 
#Escribir un script que genere un menu interactivo donde el usuario podrá seleccionar mediante un número las diferentes opciones del mismo. Las opciones del menú serán ejecutar los siguientes scripts del práctico.
#El mismo deberá capturar la opción elegida por el usuario, lanzar el script correspondiente, mostrar los resultados, realizar una pausa o esperar ingreso de tecla y nuevamente mostrar opciones del menú. 
#Incluir ademas una opción para terminar o salir.
#
#**************************************************************************************


#hacemos un array con las opciones del menu
declare -a OPCIONES=("(1) informacion del sistema" "(2) probar la conexion a host" "(3) buscar archivos por extensión" "(4) informacion sobre un proceso" "(5) Salir");


#declaramos una variable que mantiene el nro de opción seleccionada
OPCION_SELECCIONADA=0;


#se hace un bucle infinito para que luego de elegir las opciones en el menu, se vuelva a este
while true
do
	#se limpia la pantalla para una presentación mas prolija
	clear
	#se muestra el menu en consola
	echo "***********************************************************";
	echo -e "\t Menu Principal";

	#se itera por el array para mostrar las opciones
	for i in {0..5}
	do
		#se resalta la opción seleccionada con rojo, las demas en blanco
		if ((OPCION_SELECCIONADA == i));
		then
			echo -e  '\033[0;31m' ">" ${OPCIONES[$i]};
		else
			echo -e '\033[0m' ${OPCIONES[$i]};
		fi
	

	done
	echo "***********************************************************";

	#se lee por teclado el nro elegido o el desplazamiento entre las opciones
	read -n3 NUEVA_OPCION;


	if [ "$NUEVA_OPCION" = '' ]
	then
		NUEVA_OPCION=$(($OPCION_SELECCIONADA + 1));
	fi

	#se hace un switch por el valor de la entrada por teclado
	case $NUEVA_OPCION in
	1) ./informacion_de_sistema.sh ; read ;;

	2) echo "Ingrese la ip del host a comprobar";
		IP="";
		read IP;

		echo "Ingrese el intervalo de tiempo en segundos entre los que se probará la conexión";
		DELAY="";
		read DELAY;

		./test_host.sh $IP $DELAY &
		 read ;;

	3) ./buscar_arch_por_extension.sh ; read ;;

	4) ./informacion_de_proceso.sh ; read ;;

	5) exit 0;;	
#en caso que se presione el boton "arriba"
	$'\e[A')
		#se comprueba que no pueda desplazarse fuera de las opciones
		if ((OPCION_SELECCIONADA > 0))
		then
			#se disminuye la opcion seleccionada
			let OPCION_SELECCIONADA--;
		fi;;
	#en caso que se presione el boton "abajo"
	$'\e[B')
		#se comprueba que no se pueda desplazar mas alla de las opciones 
		if(( OPCION_SELECCIONADA < 4))
		then
			#se aumenta la opcion seleccionada
			let OPCION_SELECCIONADA++;
		fi
		;;
	#en caso que se haya apretado solamente intro, 
	#solo se ejecuta la opcion que esta remarcada
	
	#caso por defecto, cuando se ingresa una opcion inexistente
	*) echo -e "\n opcion incorrecta, presione una tecla"; read;;
	esac
	

	done
