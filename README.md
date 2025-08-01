# Introducción a Julia - Curso Completo

[![Julia](https://img.shields.io/badge/Julia-1.9+-9558B2?style=flat&logo=julia&logoColor=white)](https://julialang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Status](https://img.shields.io/badge/Status-Completo-brightgreen)](/)

Un curso completo y práctico para aprender Julia desde cero hasta nivel avanzado. Este repositorio contiene ejercicios progresivos, ejemplos prácticos y notebooks interactivos diseñados para llevarte desde los conceptos básicos hasta implementaciones avanzadas.

## 📚 ¿Qué es Julia?

Julia es un lenguaje de programación de alto nivel y alto rendimiento diseñado para computación científica, análisis de datos, machine learning y computación de alto rendimiento. Combina la facilidad de Python con la velocidad de C.

### 🚀 Características principales:
- **Velocidad**: Compilación Just-In-Time (JIT) que alcanza velocidades de C
- **Facilidad**: Sintaxis simple y expresiva
- **Científico**: Diseñado específicamente para computación técnica
- **Interoperable**: Integración nativa con C, Python, R, y más
- **Composable**: Excelente para programación genérica

## 📖 Estructura del Curso

### � **Notebooks Interactivos** (`Notebooks/`)
Guías interactivas para aprender Julia de forma práctica:

- **`beginner.ipynb`** - Tutorial Jupyter tradicional con ejercicios básicos
- **`beginner_pluto.jl`** - Notebook Pluto.jl reactivo (¡RECOMENDADO!)

> 💡 **Recomendación**: Usa el notebook de Pluto.jl para una mejor experiencia de aprendizaje

### �📁 **Ejercicios Básicos** (`Ejercicios/`)
Fundamentos esenciales de Julia - 13 ejercicios progresivos:

1. **Variables y Tipos** - Tipos de datos básicos y declaración de variables
2. **Operaciones** - Operadores matemáticos, lógicos y de comparación  
3. **Strings** - Manipulación y procesamiento de cadenas de texto
4. **Vectores** - Arrays unidimensionales y operaciones
5. **Tuplas** - Estructuras inmutables y uso práctico
6. **Sets** - Conjuntos y operaciones de teoría de conjuntos
7. **Diccionarios** - Mapas clave-valor y estructuras de datos
8. **Condicionales** - Control de flujo con if/else
9. **Bucles** - Iteración con for y while
10. **Funciones** - Definición y uso de funciones
11. **Structs** - Tipos de datos personalizados
12. **Manejo de Errores** - Try/catch y gestión de excepciones
13. **Módulos** - Organización y reutilización de código

### 🔧 **Ejercicios Intermedios** (`Ejercicios_intermedios/`)
Proyectos prácticos que combinan múltiples conceptos - 6 aplicaciones:

1. **Calculadora Avanzada** - Con historial y operaciones científicas
2. **Contador de Palabras** - Análisis de texto y estadísticas
3. **Conversor de Temperatura** - Múltiples escalas con validación
4. **Generador de Primos** - Algoritmos de números primos optimizados
5. **Juego de Adivinanza** - Juego interactivo con lógica de juego
6. **Calculadora de Interés** - Matemáticas financieras aplicadas

### 🚀 **Ejercicios Avanzados** (`Ejercicios_avanzados/`)
Implementaciones sofisticadas y algoritmos complejos - 4 proyectos:

1. **Calculadora de Matrices** - Álgebra lineal avanzada con descomposiciones
2. **Algoritmos Genéticos** - Optimización evolutiva completa
3. **Conversión JSON** - Sistema type-safe de conversión con macros
4. **Web Scraper HTTP** - Cliente HTTP con parsing HTML básico

### 📓 **Notebooks Interactivos** (`Notebooks/`)
Experiencia de aprendizaje interactiva:

- **`intro_julia.ipynb`** - Tutorial completo interactivo con ejemplos ejecutables
- **`graficos_con_plots.ipynb`** - Guía completa de visualización con Plots.jl

### 🌐 **Tutoriales Web** (`site/es-419/tutorials/quickstart/`)
Material complementario para diferentes audiencias:

- **`beginner.ipynb`** - Guía rápida para principiantes absolutos

## 🛠 Instalación y Configuración

### 1. Instalar Julia
```bash
# Descargar desde https://julialang.org/downloads/
# O usar un gestor de paquetes:

# macOS (Homebrew)
brew install julia

# Ubuntu/Debian
sudo apt install julia

# Windows (Chocolatey)
choco install julia
```

### 2. Verificar Instalación
```bash
julia --version
```

### 3. Clonar el Repositorio
```bash
git clone https://github.com/tuusuario/introduccion-julia.git
cd introduccion-julia
```

## 🚀 Cómo Usar Este Curso

### 🌟 Opción 1: Pluto.jl (RECOMENDADO)
```bash
# Abrir Julia e instalar Pluto.jl
julia
julia> using Pkg; Pkg.add("Pluto")
julia> using Pluto; Pluto.run()

# Luego abre beginner_pluto.jl en tu navegador
```

> 📖 Ver guía completa en [`PLUTO_SETUP.md`](PLUTO_SETUP.md)

### Opción 2: Ejercicios Paso a Paso
```bash
# Empezar con ejercicios básicos
julia Ejercicios/#001_variables_y_tipos.jl

# Continuar en orden
julia Ejercicios/#002_operaciones.jl
# ... y así sucesivamente
```

### Opción 3: Notebooks Jupyter Tradicionales
```bash
# Instalar IJulia (una sola vez)
julia -e 'using Pkg; Pkg.add("IJulia")'

# Abrir notebook
jupyter notebook Notebooks/intro_julia.ipynb
```

### Opción 3: REPL Interactivo
```bash
# Iniciar Julia REPL
julia

# Cargar ejemplos
julia> include("Ejercicios/#001_variables_y_tipos.jl")
```

## 📋 Prerrequisitos

- **Nivel**: Principiante (no se requiere experiencia previa)
- **Tiempo estimado**: 15-20 horas para curso completo
- **Software**: Julia 1.6+ (recomendado 1.9+)

**Conocimientos opcionales que ayudan:**
- Conceptos básicos de programación (cualquier lenguaje)
- Matemáticas de bachillerato
- Experiencia con terminal/línea de comandos

## � ¿Por qué Pluto.jl?

Recomendamos usar **Pluto.jl** en lugar de Jupyter porque:

### ✅ Ventajas de Pluto.jl:
- **🔄 Reactividad**: Los cambios se propagan automáticamente
- **🎯 Orden automático**: No importa el orden de ejecución de celdas
- **📦 Gestión de dependencias**: Package manager integrado
- **🌐 Exportación HTML**: Comparte como páginas web estáticas
- **🔒 Variables únicas**: Una variable por celda (evita errores)
- **✨ Interfaz moderna**: Diseño limpio y responsivo
- **🚀 Nativo Julia**: Diseñado específicamente para Julia

### 📊 Comparación:

| Característica | Pluto.jl | Jupyter |
|---------------|----------|---------|
| Reactividad | ✅ Automática | ❌ Manual |
| Orden de celdas | ✅ Automático | ❌ Dependiente del usuario |
| Gestión de paquetes | ✅ Integrada | ❌ Manual |
| Variables por celda | ✅ Una por celda | ❌ Global |
| Exportación HTML | ✅ Nativa | ⚠️ Requiere nbconvert |
| Interfaz | ✅ Moderna | ⚠️ Tradicional |

## �🎯 Objetivos de Aprendizaje

Al completar este curso, serás capaz de:

✅ **Fundamentos**
- Entender la sintaxis y filosofía de Julia
- Manejar tipos de datos y estructuras básicas
- Escribir funciones y controlar el flujo del programa

✅ **Intermedio**
- Crear aplicaciones prácticas combinando múltiples conceptos
- Manejar entrada/salida y validación de datos
- Implementar algoritmos básicos

✅ **Avanzado**
- Desarrollar sistemas complejos con múltiples módulos
- Utilizar metaprogramación y macros
- Optimizar código para rendimiento
- Integrar con sistemas externos (HTTP, JSON)

## 📊 Ruta de Aprendizaje Sugerida

```
Semana 1: Fundamentos
├── Día 1-2: Variables, tipos, operaciones
├── Día 3-4: Strings, arrays, estructuras
├── Día 5-6: Control de flujo y funciones
└── Día 7: Structs, errores, módulos

Semana 2: Aplicaciones Prácticas
├── Día 8-9: Proyectos intermedios 1-3
├── Día 10-11: Proyectos intermedios 4-6
├── Día 12-13: Notebooks y visualización
└── Día 14: Repaso y práctica libre

Semana 3: Nivel Avanzado
├── Día 15-16: Álgebra lineal y matrices
├── Día 17-18: Algoritmos genéticos
├── Día 19-20: JSON y metaprogramación
└── Día 21: Web scraping y proyecto final
```

## 🔗 Recursos Adicionales

### Documentación Oficial
- [Julia Documentation](https://docs.julialang.org/) - Documentación completa
- [Julia Manual](https://docs.julialang.org/en/v1/manual/) - Manual de referencia
- [Standard Library](https://docs.julialang.org/en/v1/stdlib/) - Biblioteca estándar

### Comunidad
- [Julia Discourse](https://discourse.julialang.org/) - Foro principal de la comunidad
- [Julia Slack](https://julialang.org/slack/) - Chat en tiempo real
- [Julia Zulip](https://julialang.zulipchat.com/) - Chat alternativo

### Paquetes y Ecosistema
- [JuliaHub](https://juliahub.com/) - Plataforma de desarrollo Julia
- [Julia Packages](https://juliapackages.com/) - Explorador de paquetes
- [General Registry](https://github.com/JuliaRegistries/General) - Registro oficial

### Aprendizaje Adicional
- [Julia Academy](https://juliaacademy.com/) - Cursos gratuitos oficiales
- [Exercism Julia](https://exercism.org/tracks/julia) - Ejercicios guiados
- [Julia Tutorials](https://julialang.org/learning/) - Lista curada de tutoriales

### Libros Recomendados
- **"Think Julia"** por Ben Lauwens - Excelente para principiantes
- **"Julia High Performance"** por Avik Sengupta - Optimización avanzada
- **"Hands-On Design Patterns in Julia"** por Tom Kwong - Patrones de diseño

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Puedes ayudar de varias formas:

### Reportar Problemas
- 🐛 Bugs en el código
- 📝 Errores de documentación
- 💡 Sugerencias de mejora

### Contribuir Código
```bash
# 1. Fork el repositorio
# 2. Crear una rama para tu feature
git checkout -b feature/nueva-funcionalidad

# 3. Hacer cambios y commit
git commit -m "Agregar nueva funcionalidad"

# 4. Push y crear Pull Request
git push origin feature/nueva-funcionalidad
```

### Tipos de Contribuciones Deseadas
- 📚 Nuevos ejercicios o ejemplos
- 🔧 Mejoras en código existente
- 📖 Mejor documentación
- 🌍 Traducciones a otros idiomas
- 🎨 Mejoras en notebooks

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

```
MIT License

Copyright (c) 2024 Introducción a Julia

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

## 🙏 Reconocimientos

- **Julia Computing** - Por crear este increíble lenguaje
- **Comunidad Julia** - Por su apoyo y recursos
- **Contribuidores** - Por mejorar continuamente este material

## 📞 Soporte

¿Tienes preguntas o necesitas ayuda?

- 📧 **Email**: [tu-email@ejemplo.com]
- 💬 **Discussions**: Usa las GitHub Discussions de este repo
- 🐦 **Twitter**: [@tu_usuario]
- 💼 **LinkedIn**: [Tu perfil de LinkedIn]

## 🌟 ¡Dale una Estrella!

Si este curso te resulta útil, ¡no olvides darle una ⭐ en GitHub! Ayuda a que más personas descubran este recurso.

---

### 📈 Estadísticas del Proyecto

- **📁 Archivos**: 25+ archivos de ejercicios
- **📝 Líneas de código**: 3000+ líneas comentadas
- **⏱️ Tiempo estimado**: 15-20 horas
- **🎯 Nivel**: Principiante a Avanzado
- **🔄 Última actualización**: Diciembre 2024

### 🚀 ¡Comienza Ahora!

```julia
println("¡Bienvenido al mundo de Julia! 🎉")
println("Tu viaje hacia la computación científica de alto rendimiento comienza aquí.")
```

**Siguiente paso**: Ejecuta `julia Ejercicios/#001_variables_y_tipos.jl` y ¡comienza a aprender!
