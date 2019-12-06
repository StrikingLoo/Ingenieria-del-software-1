Para iniciar el servidor se deben importar en Cuis:
TusLibros-Server.st
TusLibros-Model.st
TusLibros-Tests.st

Y luego iniciar un server en el puerto 8082 como dice la consigna.

Por otro lado se debe levantar el cliente y el servidor de frontend.

En la pantalla de login se puede acceder con:
user: Caro
password: cosasDeCaro
(todo esto es case sensitive obviamente).

En comunicación directa con el backend se puede acceder a checkout y a history para un usuario, pero desde el frontend no.
Desde el frontend se puede acceder a la vista de catálogo, la de carrito, la de detalles, y usar la navbar para navegar por varias de esas views.
Desde todas se puede agregar o sacar elementos del carrito.
