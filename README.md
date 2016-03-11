<!DOCTYPE html>
<html lang="es">
  <head>
      <meta charset="utf-8" />
  </head>
<h1 align=center>Active Directory Integration Script</h1>
<h2 align=center><strong>josjos</strong></h2>
josjos Script de integración de sistemas Ubuntu/Debian en dominios Active Directory

Funciona en Ubuntu 12.04/14.04 y Debian 7

Con el script se reduce el tiempo de todo el proceso que se tarda en integrar una máquina ubuntu/debian en un dominio active Directory.

Para instalar:
<ul>
<li>1º Abrimos la terminal si estamos desde un escritorio (Si estamos desde un server empezamos en el paso 2)</li>
<li>2º Tendremos que instalar Git, para ello tecleamos el siguiente comando</li><p style="color: #FFF; background-color: #4e4e4e; width: 400px; padding:5px; padding-left:50px;"><code>sudo apt-get update && sudo apt-get install git</code></p> 
<li>3º Ahora vamos a clonar el repositorio.Nos vamos al directorio home tecleando <code style="color: #FFF; background-color: #4e4e4e; padding: 5px;">cd</code> y ahí tecleamos</li> <p style="color: #FFF; background-color: #4e4e4e; width: 400px; padding:5px; padding-left:50px;"><code>sudo git clone https://github.com/oblop/josjos.git</code> </p>
<li>4º Una vez clonado el repositorio nos habrá creado una carpeta llamada josjos, nos movemos a ella</li> <p style="color: #FFF; background-color: #4e4e4e; width: 400px; padding:5px; padding-left:50px;"><code>cd josjos/</code> </p>
<li>5º Le damos permisos de ejecución al script</li> <p style="color: #FFF; background-color: #4e4e4e; width: 400px; padding:5px; padding-left:50px;"><code> sudo chmod +x JOSJOS.sh</code> </p>
<li>6º Ejecutamos el script (siempre con sudo o desde root)</li> <p style="color: #FFF; background-color: #4e4e4e; width: 400px; padding:5px; padding-left:50px;"><code>sudo ./JOSJOS.sh</code> </p>
<li>7º Una vez dentro del script nos aparecerá un menú con 4 opciones, para seleccionar una de ellas tan solo hay que poner el número correspondiente y darle a intro.</li>



</html>
