# Proyecto de ejemplo Webpay para Transbank SDK Java

## Requerimientos

Para poder ejecutar el proyecto de ejemplo necesitas tener instalada las siguientes herramientas
en tu computador:

1. git ([como instalar git][git_install])
2. Java versión 7 u 8.
3. maven ([como instalar maven][maven_install])

[git_install]: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
[maven_install]: https://maven.apache.org/install.html

## Clonar repositorio

Primero deberas clonar este repositorio en tu computador:

````batch
git clone https://github.com/TransbankDevelopers/transbank-sdk-java-webpay-example.git
````


## Ejecutar ejemplo

El ejemplo viene listo para correr usando Jetty, ejecutando:

````batch
mvn jetty:run
````

Si todo ha salido bien deberías poder acceder al ejemplo en la url  `http://localhost:8080/` y probar los distintos productos de Webpay en ambiente de pruebas. Para hacer pruebas en dicho ambiente debes usar los siguientes datos:

- Tarjeta: VISA
- Número: 4051885600446623
- Fecha de Expiración: Cualquiera
- CVV: 123
- RUT autenticación con emisor: 11.111.111-1
- Contraseña autenticación con emisor: 123


