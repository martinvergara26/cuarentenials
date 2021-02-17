
# cuarentenials 
Sistema de gestión de regalos y visitas (Challenge técnico Fullstack)
  
# Demo

[Deployado en esta EC2](http://3.86.97.120) 
  
###	Nota importante

A modo de facilitar la prueba del sistema, en los detalles de un nacimiento, se muestra el email de su PMC. Todos los usuarios generados por los seeds, tiene contraseña `123456`  
 
# Stack tecnológico
Opté por desarrollar el sistema con las tecnlogías **deseables**:
Frontend: **Vue.js** (Vue 3)
Backend: **Ruby on Rails** (Rails 6)
La base de datos utilizada es MySQL. 

#### Conocimiento previo de las tecnolgías
Vue: 0%
Rails: 5%
MySQL: 70%

#### ¿Por qué use MySQL? 
Porque buscando ejemplos sobre Rails, mayormente están con MySQL o Postgres. La otra opción soportada (aparentemente) era Mongo, pero no me quise arriesgar a utilizar un lenguaje y framework casi desconocido para mí, con un motor de DB con el cual probablemente me hubiese traído más complicaciones de configuración e investigación (A.K.A. buscar en StackOverflow y demases).

# Objetivos funcionales cumplidos: ""100%""

_Por supuesto que están cumplidos al 100%, según lo que entendí, factores que asumí, y caminos que tomé antes definiciones ambiguas_

## Requerimientos funcionales
  
- [x] Como VDS, podré ver el listado de próximos natalicios. El cual estará confeccionado en
una vista similar la solapa “listado VDS” del archivo de wireframes.
- [x] Como VDS, podré entrar al detalle de un bebé mediante el botón “Programar Interacción”
- [x] Como VDS, podré regalar o programar visita dependiendo de las opciones de mi fase y
de la disponibilidad.
- [x] Como un PMC, podré dar de alta el nacimiento de mi hijx, con los mismos datos que se ofrecen en el listado, sumada la configuración de fase al momento del nacimiento
- [x]  Como un PMC, podré ver la lista de regalos hechos a mi hijx y el calendario
  
## Requerimientos secundarios 

- [x] Como PMC, podré customizar la fase en la que nacerá mi hijx, poniendo mis propias reglas en cuanto a los mecanismos de visita.
- [x] Como PMC, podré actualizar la lista de regalos acorde a la fase seleccionada en la que nacerá mi hijx, sea o no una fase customizada
- [x] Como VDS, podré agregar un regalo o visita, con mis propias normas, que será pendiente de aprobación de lxs PMC
- [x] Como PMC, tendré una lista de regalos custom
- [x] Como PMC, puedo ponerle a mis regalos una prioridad/urgencia para que mis VDS se
concentren en comprar eso.

# DER
_Nota: este DER no refleja todas las columnas y constraints reales_
![IDER](https://cuarentenials.s3.amazonaws.com/cuarentenials-DER.png)  
  
#	Lo que quedó fuera de alcance...
Ahora sí, a empezar a hablar del _lado oscuro del sistema_
No llegué a encargarme de:
1. Validaciones en formularios de ningún tipo
2. Estética general y responsiveness
3. Cobertura de tests:
	* Frontend: empecé a escribir tests. Probé haciendo tests muy sencillos con componentes que no dependan de *Vuex*, y funcionan. Pero con todos/casi todos me fallan con el error `Cannot find module 'vue-template-compiler' from 'vue-test-utils.js'`. Le dediqué un rato a investigar esta cuestión, y no lo pude solucionar, así que prioricé el avance funcional. De todas maneras, dejé escritos tres tests (que rompen)
	* Backend: quedaron muchos tests pendientes, y otros que rompen. Le dediqué un rato a investigar cómo usar *Rspec* y logré escribir algunos specs exitosamente. Pero por supuesto que los tests que definí sólo cubren un pequeño porcentaje del código
4. Auto-refresco de JWT
5. Interceptores de _axios_
6. Paginación en listas
7. Calidad del código. Sobre todo en el Frontend, rompí bastante el principio DRY. Algunos componentes quedaron muy grandes y con muchas responsabilidades. Lo cual, genera una difícil testeabilidad. Y en el Backend, hice cosas que _supongo_ que se pueden hacer mejor. Y ciertas lógicas, creo que se podrían haber puesto en los modelos, antes que cargar de tanta responsabilidad de los controllers.

#	Cómo levantar el proyecto localmente (MacOS o Linux)
### Backend
Instalar ruby y rails siguiendo [estas instrucciones](https://gorails.com/setup/osx/11.0-big-sur)

Luego

`cd cuarentenials/ror-app`

`rake secret`

En `~/.bashrc` o en `~/.zshrc` (según usemos bash o zsh), agregar al  final esta línea:

`export DEVISE_JWT_SECRET_KEY="<clave generada por rake secret>"`

Luego

`bundle exec`

`rake db:create`

`rails db:migrate`

`rails db:seed`

`rails s`

### Frontend

`cd cuarentenials/vue-app`

`yarn install`

`yarn run serve`

## Opción Docker para Backend

`cd cuarentenials/ror-app`

`docker-compose up -d`

