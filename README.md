<html lang="es">
  <head>
      <meta charset="utf-8" />
  </head>
<h1 align=center>Active Directory Integration Script</h1>
<h2 align=center><strong>josjos</strong></h2>
JOSJOS es un Script de integración de sistemas Ubuntu/Debian en dominios Active Directory

Funciona en Ubuntu 12.04 LTS /14.04 LTS y Debian 7

Con el script se reduce el tiempo de todo el proceso que se tarda en integrar una máquina ubuntu/debian en un dominio active Directory.

Para instalar:
<ul>
<li><p>Empezamos abriendo la terminal si estamos desde un escritorio (Si estamos desde un server empezamos en el paso 2)</p></li>
<li>Tendremos que instalar Git, para ello tecleamos el siguiente comando</li><p style="color: #FFF; background-color: #4e4e4e; width: 400px; padding:5px; padding-left:50px;"><code>sudo apt-get update && sudo apt-get install git</code></p> 
<li>Ahora vamos a clonar el repositorio.Nos vamos al directorio home tecleando <code style="color: #FFF; background-color: #4e4e4e; padding: 5px;">cd</code> y ahí tecleamos</li> <p style="color: #FFF; background-color: #4e4e4e; width: 400px; padding:5px; padding-left:50px;"><code>sudo git clone https://github.com/oblop/josjos.git</code> </p>
<li>Una vez clonado el repositorio nos habrá creado una carpeta llamada josjos, nos movemos a ella</li> <p style="color: #FFF; background-color: #4e4e4e; width: 400px; padding:5px; padding-left:50px;"><code>cd josjos/</code> </p>
<li>Le damos permisos de ejecución al script</li> <p style="color: #FFF; background-color: #4e4e4e; width: 400px; padding:5px; padding-left:50px;"><code> sudo chmod +x JOSJOS.sh</code> </p>
<li>Ejecutamos el script (siempre con sudo o desde root)</li> <p style="color: #FFF; background-color: #4e4e4e; width: 400px; padding:5px; padding-left:50px;"><code>sudo ./JOSJOS.sh</code> </p>
<li>Una vez dentro del script nos aparecerá un menú con 4 opciones, para seleccionar una de ellas tan solo hay que poner el número correspondiente y darle a intro.</li>
<li><p>La primera opción es la de integración en Active Directory, la segunda son opciones de testeo para una vez realizada la integración verificar que se ha integrado correctamente; la tercera sirve para la desintegración del dominio, dejando todos los archivos tal y como estaban y la cuarta y última es salir del script.</p></li>
<li><p>Si seleccionamos la primera opción empezaremos a integrar nuestra máquina en un dominio Active Directory. Nos hará una serie de preguntas necesarias para la correcta integración.</p>
	<ul>
		<li>La primera es que nos aseguremos de haber realizado un update primero, si no lo habéis hecho podéis realizarlo en ese momento pulsando s y después intro</li>
		<li>Una vez realizado el update (aconsejable realizarlo) nos dirá el nombre de nuestro ordenador (hostname), si es ese el que deseamos utilizar seguimos. (Un cambio de hostname posterior a la integración puede causar problemas de conectividad)</li>
		<li>Ahora nos hará unas preguntas sobre el controlador de dominio, el nombre de dominio etc... tan solo tenéis que seguir los pasos en el script. </li>
		<li>Cuando hayamos cubierto todos los campos habrá una verificación</li>
		<li>Tendremos que completar alguna pregunta más sobre los reinos y también, muy importante, os pedirá la contraseña del administrador del controlador del dominio, no la de vuestro ordenador.</li>
		<li>Si nos pregunta que si queremos reiniciar (es recomendable para que se realicen los cambios correctamente) quiere decir que hemos llegado al final.
	</ul>
<li><p>La segunda opción son las opciones de testeo y dentro de ésta habrá otro menú en el que podemos escoger entre:</p></li>
	<ul>
		<li>1 Lista de usuarios AD</li>
		<li>2 Lista grupoas AD</li>
		<li>3 Lista de usuarios de Dominio</li>
		<li>4 Información general AD</li>
		<li>5 Salir</li>
	</ul>
<li><p>La tercera opción sirve para desintegrar el sistema del dominio Active Directory. Es muy sencillo, tan solo hay que proporcionarle los datos que pide como el nombre del dominio y el nombre de usuario del administrador del dominio. Al final, igual que después de integrar es recomendable reiniciar la máquina para que los cambios se apliquen correctamente.</p></li>

</ul>


<p style="padding-right:70px;" align=right ><a href="http://www.gnu.org/licenses/gpl-3.0.html"><img src="http://www.gnu.org/graphics/gplv3-88x31.png"/></a></p>

</html>
