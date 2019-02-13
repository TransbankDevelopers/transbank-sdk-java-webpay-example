[![Build Status](https://travis-ci.org/TransbankDevelopers/transbank-sdk-java-webpay-example.svg?branch=master)](https://travis-ci.org/TransbankDevelopers/transbank-sdk-java-webpay-example)

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

## Ejecutar ejemplo apuntando a producción

Debes inyectar el código de comercio, certificado público y llave privada a través de variables de entorno.

Según el producto, debes ingresar las siguientes variables de entorno:

- Webpay Plus Normal: PLUS_NORMAL_COMMERCE_CODE, PLUS_NORMAL_PRIVATE_KEY, PLUS_NORMAL_PUBLIC_CERT
- Webpay Plus Mall: PLUS_MALL_COMMERCE_CODE, PLUS_MALL_PRIVATE_KEY, PLUS_MALL_PUBLIC_CERT
- Webpay Plus Captura Diferida: PLUS_CAPTURE_COMMERCE_CODE, PLUS_CAPTURE_PRIVATE_KEY, PLUS_CAPTURE_PUBLIC_CERT
- Oneclick Normal: ONECLICK_NORMAL_COMMERCE_CODE, ONECLICK_NORMAL_PRIVATE_KEY, ONECLICK_NORMAL_PUBLIC_CERT

y luego ejecutar:

````batch
mvn jetty:run
````

## Ejecutar tests automáticos

Debes tener corriendo el servidor web (según lo indicado más arriba) y luego
ejecutar:

```
mvn test -Dselenide.headless=false
```

Nota: debes tener Google Chrome instalado en tu computador.
