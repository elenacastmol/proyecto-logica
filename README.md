# 📊 Proyecto Lógica: SQL con PostgreSQL y DBeaver

## 📌 Índice

- 📄 [Descripción del proyecto](#descripción-del-proyecto)
- 🗂️ [Estructura del proyecto](#estructura-del-proyecto)
- ⚙️ [Instalación y requisitos](#instalación-y-requisitos)
- 🚀 [Pasos seguidos durante el proyecto](#pasos-seguidos-durante-el-proyecto)
- 🎯 [Resultado y conclusiones](#resultado-y-conclusiones)


## Descripción del proyecto

Este proyecto consiste en la resolución de consultas SQL sobre una base de datos, utilizando PostgreSQL como sistema gestor de bases de datos y DBeaver como entorno de trabajo.

A lo largo del proyecto se han aplicado consultas básicas y avanzadas para demostrar dominio de una sola tabla, relaciones entre tablas, subconsultas, vistas, buenas prácticas, entre otros.

## Estructura del Proyecto

proyecto-logica/
├── esquema-vista.png
│ └── Esquema de la base de datos con vista incluida
│
├── esquema.png
│ └── Esquema de la base de datos del proyecto
│
├── proyecto-logica.sql
│ └── Archivo con todas las consultas SQL resueltas.
│ Cada consulta está identificada con su número y su enunciado en forma de comentario.
│
└── README.md


## Instalación y Requisitos

- PostgreSQL como sistema gestor de bases de datos.
- DBeaver como herramienta para la conexión, exploración del esquema, ejecución de consultas y validación de resultados.

## Pasos seguidos durante el proyecto

### 1. Preparación del entorno
Se instaló y configuró PostgreSQL como motor de base de datos, y DBeaver como cliente para gestionar la conexión y ejecutar consultas.


### 2. Análisis inicial del esquema
Se estudió el esquema entregado para identificar tablas, claves primarias, claves foráneas y relaciones entre entidades.

### 3. Resolución de consultas 
Se trabajó con consultas sobre una sola tabla, utilizando `SELECT`, `WHERE`, `ORDER BY` y funciones de agregación como `COUNT`, `SUM`, `AVG`, `MIN` y `MAX`. Se desarrollaron consultas que requerían relaciones entre varias tablas mediante `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN` , `FULL JOIN`. 

Se resolvieron ejercicios que requerían obtener primero un valor intermedio para utilizarlo en la consulta principal, subconsultas. 

El proyecto también incluye el uso de vistas como recurso para agrupar consultas reutilizables y mejorar la organización del trabajo, que permiten simplificar la lectura y obtener estructuras reutilizables.

Se crearon tablas temporales para almacenar resultados intermedios. Este tipo de estructuras resulta útil para trabajar durante una sesión concreta sin modificar de forma permanente la base de datos.

### 8. Verificación 
Cada consulta fue ejecutada, revisada y corregida en DBeaver para asegurar que la sintaxis fuera válida y que los resultados coincidieran con lo solicitado en cada ejercicio.

En esta fase se detectaron y corrigieron errores de agrupación, duplicados, uso incorrecto de join, entre otros.



## Resultado y Conclusiones

El proyecto ha permitido reforzar la comprensión y la capacidad de interpretar correctamente un enunciado antes de escribir una consulta SQL.

Uno de los aprendizajes más costoso ha sido distinguir cuándo un ejercicio requiere una relación y qué tipo (‘JOIN’) entre varias tablas, o una subconsulta. 

También se ha comprobado que una misma consulta puede resolverse de varias maneras. 

Además, se ha priorizado una escritura clara y ordenada. El uso de DBeaver ha facilitado esto y ha sido muy útil para trabajar y comprobar resultados rápidamente y depurar errores con mayor agilidad.


## 👩🏻 Autora 

Elena Castañeda
•	[@elenacastmol]{https://github.com/elenacastmol]