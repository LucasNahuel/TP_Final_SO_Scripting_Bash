#	!/bin/bash

#	Autores:Erik Ayala, Muñoz Lucas

#	Consigna: Escribir un script que busque de manera recursiva en un directorio ingresado por el usuario todos los 
#	archivos con una determinada extensión, tambien ingresada. El script deberá verificar que sea un 
#	directorio válido, exista y generar un archivo con el listado de los archivos encontrados con su ruta 
#	completa o absoluta.El archivo generado debera llamarse de la siguiente manera: 
#	archivos-<extension>en<directorioBusqueda>


echo -e "Ingrese el directorio donde buscar los archivos \n";

DIR="";

read DIR;
#se comprueba que el directorio exista con el comando test
if !( test -d $DIR )
then
	#si el directorio ingresado no exite o esta mal escrito, se lo muestra por pantalla
	echo "el directorio no existe";
else
	#aqui continua si el directorio existe
	#se solicita la entrada por teclado de la extensión de los archivos que se desean buscar y
	#se lo guarda en una variable
	EXTENSION="";
	echo -e "Ingrese la extension de los archivos que desea buscar: \n";
	read EXTENSION;


	#no sabemos si el usuario ingresa la extensión con un punto, asi que nos aseguramos que lo tiene
	#quitamos el punto si existe y luego lo añadimos
	EXTENSION=`echo "$EXTENSION" | tr -d . `;
	EXTENSION=`echo ".$EXTENSION" `;

	#se guarda en una variable el nombre del archivo que tendra los resultados de la busqueda
	#el comando tr reemplaza los barras diagonales que no se permiten en nombres de archivos por
	#el caracter >
	NOMBRE_DE_ARCHIVO=$(echo "archivos- $EXTENSION en ${DIR}.txt" | tr / ">" );


	
 	#ejecutamos el comando find que realizara una busqueda recursiva en el directorio especificado
 	#incluimos la extensión con el caracter * de comodin para ignorar el inicio del nombre del archivo
 	#se redirige la salida del comando a un archivo nuevo con el nombre deseado
	
	find $DIR -name "*$EXTENSION" >> "${NOMBRE_DE_ARCHIVO}";
	cat "$NOMBRE_DE_ARCHIVO";
	echo -e "\033[0;32m Archivo de reporte creado exitosamente\033[0;0m";
fi

exit 0;