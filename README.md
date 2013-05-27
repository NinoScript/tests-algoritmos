tests-algoritmos
================
Aquí vamos a hacer pruebas para los algoritmos para resolver la competencia
robótica.

Rationale
---------
Vamos a conseguir un [BeagleBone Black][BBB], así que ahí
vamos a tener procesamiento _infinito_ para desperdiciar. Y qué mejor forma de
desperdiciar procesamiento, que ocupando código interpretado digo yo.

Por ahora JavaScript suena como una buena idea. Podemos hacer cosas y probarlas
en el browser, y después **ejecutarlas en el perrito directamente con
[Node.js][node]**… aunque otra forma sería instalar [ROS][ROS] y ver que cosas
ya hay hechas, pero casi todas las cosas bknes de ahí requieren sensores láser
que valen de dos palos pa arriba… pero por mientras veamos con JavaScript,
porque lo otro es más complicado.

Entonces, como todavía no tenemos el robot hecho, e incluso cuando lo tengamos
no vamos a poder ocuparlo todos al mismo tiempo, vamos a partir simulando el
escenario y el robot en JavaScript. Pero como igual no es algo totalmente
trivial, una buena orientación a objetos simplificaría las cosas y haría más
fácil el reparto de trabajos; aparte javascript es un engendro del mal, así que
**vamos a ocupar [CoffeeScript][coffee]**, que es un lenguaje que compila a JS.

**Para dibujar la simulación en pantalla, escogimos [Processing.js][p5js]**
principalmente porque ya varios de nosotros tienen algo de experiencia con eso,
aunque habían varias otras alternativas! como [raphael.js][raph] o [d3.js][d3]
(este me gusta harto).

[BBB]:    http://beagleboard.org/Products/BeagleBone+Black
[ROS]:    http://www.ros.org/
[node]:   http://nodejs.org
[coffee]: http://coffeescript.org
[p5js]:   http://processingjs.org
[raph]:   http://raphaeljs.com
[d3]:     http://d3js.org

En este momento, necesitamos 4 cosas:

1. Un robotito que se mueva y que "sense" entregando los puntos (x,y) donde se
encuentran sus sensores, al que sea fácil meterle código desde afuera.

2. Un modelo del escenario, que se genere aleatoriamente y sea capaz de entregar
si un punto (x,y) es piso o no.

3. Investigar acerca de soluciones conocidas a este problema, no me atrevería a
pedir el estado del arte… somos muy pencas todavía para algo así, pero acá hay
material para empezar a leer:
	* [(1996) Integrating Grid-Based and Topological Maps for Mobile Robot Navigation](http://www.ri.cmu.edu/pub_files/pub1/thrun_sebastian_1996_8/thrun_sebastian_1996_8.pdf)
	* [(2002) Robotic Mapping: A Survey](http://robots.stanford.edu/papers/thrun.mapping-tr.pdf)
	* [Modern Robot Mapping Techniques, A broad mini-survey in outline form!](http://cs.krisbeevers.com/research/rqnotes_jan06.pdf)


Pseudocódigo
------------
	clase robotito:
		referencias: escenario, algoritmo
		variables: x, y, ángulo
		constantes: rapidez, velocidad de giro
		funciones: avanzar, girar, dibujar en pantalla
		loop principal:
			valores = sensar escenario
			ejecutar algoritmo con valores sensados
			dibujar en pantalla con nueva posición

	clase escenario:
		variables: mapa
		constantes: tamaño cuadrilla
		funciones: sensar punto
		loop principal:
			dibujar en pantalla
			
	algoritmo:
		referencias: robotito
		entrada: valores sensores
		efecto: mover y/o girar robotito

Software
--------
Para trabajar todos en harmonía y ser productivos, propongo estandarizar el
software que vamos a ocupar

### Git GUI
1. [SourceTree](http://sourcetreeapp.com)

	Este es el que vamos a ocupar, lamentablemente no está para linux todavía

2. [SmartGit/Hg](http://www.syntevo.com/smartgithg/index.html)

	Es la mejor alternativa que hay a SourceTree, la interfaz es un poco confusa
	pero es bueno

### Editor de texto
* [Sublime Text 2](http://www.sublimetext.com)

	TextMate y Vim también son bienvenidos, pero este voy a estar ocupando yo
	para ayudarlos si les pasa algo

### Browser
1. [Chrome](https://www.google.com/chrome)

	En el inspector, hay que habilitar los source maps!

2. [Firefox+firebug](http://getfirebug.com)

### Lenguaje
* [CoffeeScript][coffee]

	Este es el lenguaje que quiero ocupar, compila a javascript, vamos a estar
	ocupando node.js si podemos en el BeagleBone Black

### Librería
* [Processing.js API][p5js]

	Nótese que es solo la librería, no el lenguaje completo.

Preparando el entorno de trabajo
--------------------------------
Según el sistema operativo que ocupen, puede que necesiten instalar cosas
distintas; pero la idea general es simple:

* Instalar Node.js (este paso incluye NPM, el gestor de packetes de node)
* Instalar un compilador de CoffeeScript con NPM (este paso incluye cake)
* Ejecutar el cakefile
* Abrir el index.html

### Instalando Node.js
La parte que más varía, es como instalar [Node.js][node], aunque en verdad
todos pueden ocupar el método para *Windows*, solo que considero que los otros
métodos son mejores porque ofrecen actualizaciones automáticas.

#### Mac OS X
En mac vamos a ocupar el gestor de paquetes [Homebrew][brew] para instalar
[Node.js][node], es importante **no** ocupar _sudo_ al usarlo y asegurarse
de que `brew doctor` diga que el sistema está en buenas condiciones.

Homebrew, luego de instalar node, te aconsejará anteponer el path donde quedan
los binarios de los packetes que instales con npm a tu variable de entorno
PATH, pondré un ejemplo de como hacer esto en Bash, aunque yo personalmente
ocupo Fish.

```Shell
brew install node
echo "export PATH=/usr/local/share/npm/bin:$PATH" >> ~/.bash_profile
```

[brew]: http://brew.sh

#### Linux
En linux vas a ocupar el gestor de paquetes recomendado para tu distro, en el
caso de Ubuntu este es apt-get

```Shell
sudo apt-get install node
```

#### Windows
Aquí simplemente vamos a bajar un instalador, cosa también funciona en las
otras plataformas, pero no lo recomiendo porque se pierden las
actualizaciones.

Para esto vamos a ir a [la página oficial de Node.js][node] y vamos a hacer
click en Install, debería automáticamente detectar el sistema operativo y
bajar la versión apropiada para este.

### Instalando [CoffeeScript][coffee]
Una vez instalado node, de ahora en adelante debería ser todo hermoso!

```Shell
npm install -g coffee-script
cd a/la/carpeta/del/proyecto
cake build
```

Ahora que todo funcionó, es importante que revises las otras tareas que tiene
el _cakefile_, esto es fácil, solo tienes que escribir `cake` solo.

### Troubleshooting
Obviamente el mundo no es perfecto y todo falló xD, veamos que se puede hacer…

#### Mac OS X
Nada debiese haber fallado, revisa tu instalación de HomeBrew, ejecuta `brew
doctor`, actualiza el sistema, arregla las cosas. Si aún así no funciona, me
avisas.

#### Windows
Puede que haya fallado mi cakefile, es un error conocido, por ahora vas a
tener que ocupar el siguiente comando para compilar:

```Shell
coffee --bare --watch --compile --map src
```

Por favor recuérdame revisar y arreglar esto.
Gracias Karen por encontrar este bug.

#### Linux
Corre en círculos, rueda, llora y luego me avisas. Los consejos para los otros
sistemas operativos pueden ser aplicables, es decir: actualiza todo, compila a
mano si el error es en el cakefile.
