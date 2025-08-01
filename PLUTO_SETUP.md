# Guía de Instalación y Uso de Pluto.jl

## ¿Qué es Pluto.jl?

Pluto.jl es un entorno de notebook reactivo para Julia que ofrece una experiencia moderna e interactiva para aprender y desarrollar en Julia.

**🎯 Perfecto para principiantes:** Si es tu primera vez con Julia, Pluto.jl es la mejor opción para empezar.

## Instalación (Paso a Paso)

### 1. Instalar Julia
Si no tienes Julia instalado:
- Ve a [julialang.org](https://julialang.org/downloads/)
- Descarga e instala Julia para tu sistema operativo
- **Importante:** Asegúrate de marcar "Add Julia to PATH" durante la instalación

### 2. Verificar que Julia funciona
Abre tu terminal/línea de comandos y escribe:
```bash
julia --version
```
Deberías ver algo como: `julia version 1.9.x`

### 3. Instalar Pluto.jl
Abre Julia escribiendo `julia` en tu terminal, luego ejecuta:

```julia
using Pkg
Pkg.add("Pluto")
```

**💡 Tip:** La primera vez puede tardar unos minutos en descargar e instalar.

### 4. Ejecutar Pluto.jl
En Julia, ejecuta:

```julia
using Pluto
Pluto.run()
```

Esto abrirá Pluto.jl en tu navegador web en `http://localhost:1234`

**🎉 ¡Listo!** Ya tienes Pluto.jl funcionando.

## Cómo usar el notebook de este tutorial

### 🚀 Inicio Rápido (Recomendado)
1. **Abrir Pluto.jl:** En Julia escribe `using Pluto; Pluto.run()`
2. **En tu navegador:** Ve a `http://localhost:1234`
3. **Abrir tutorial:** Haz clic en "Open from file" y selecciona `beginner_pluto.jl`
4. **¡A aprender!** Las celdas se ejecutan automáticamente

### Opción alternativa: Crear nuevo y copiar
1. Abre Pluto.jl
2. Crea un nuevo notebook ("Create a new notebook")
3. Copia y pega el contenido de `beginner_pluto.jl`

**💡 Consejo:** La primera opción es más fácil y mantiene mejor la estructura.

## Ventajas de Pluto.jl sobre Jupyter

### 🔄 Reactividad Automática
- Los cambios en una celda se propagan automáticamente
- No necesitas ejecutar celdas manualmente en orden
- El notebook siempre está en un estado consistente

### 🎯 Gestión de Dependencias
- Package manager integrado
- Instala automáticamente las dependencias necesarias
- Versiones consistentes para todos los usuarios

### 🌐 Exportación y Compartición
```julia
# Para exportar como HTML estático
using Pluto
Pluto.export_notebook("beginner_pluto.jl", "tutorial.html")
```

### 📱 Interfaz Moderna
- Diseño responsivo
- Funciona bien en móviles y tablets
- Interfaz limpia y minimalista

### 🔒 Seguridad de Variables
- Una variable por celda (evita conflictos)
- Scope automático y seguro
- Detecta automáticamente dependencias entre celdas

## Comandos Útiles

### Atajos de Teclado en Pluto.jl
- `Ctrl + Enter`: Ejecutar celda
- `Shift + Enter`: Ejecutar celda y crear nueva abajo
- `Ctrl + M`: Cambiar a Markdown
- `Ctrl + /`: Comentar/descomentar
- `Ctrl + Z`: Deshacer
- `Ctrl + Shift + Z`: Rehacer

### Comandos de Julia para Pluto
```julia
# Iniciar Pluto
using Pluto
Pluto.run()

# Iniciar en puerto específico
Pluto.run(port=8000)

# Abrir notebook específico
Pluto.run(notebook="beginner_pluto.jl")

# Exportar a HTML
Pluto.export_notebook("notebook.jl", "output.html")
```

## Estructura del Tutorial

El notebook `beginner_pluto.jl` incluye:

1. **Conceptos Básicos**: Variables, tipos, operaciones
2. **Estructuras de Control**: if/else, bucles
3. **Funciones**: Definición y uso
4. **Proyectos Prácticos**: Calculadora, analizador, juegos
5. **Ejercicios Interactivos**: Con soluciones

## Tips para Mejor Experiencia

### 1. Usa `begin...end` para múltiples líneas
```julia
begin
    x = 5
    y = 10
    println("Suma: $(x + y)")
end
```

### 2. Evita variables globales
- Define variables dentro de `begin...end` o funciones
- Una variable por celda para mejor reactividad

### 3. Usa `with_terminal()` para output largo
```julia
with_terminal() do
    for i in 1:100
        println("Número: $i")
    end
end
```

### 4. Instala paquetes en celdas separadas
```julia
# Celda para instalar paquetes
begin
    using Pkg
    Pkg.add("Plots")
end
```

```julia
# Celda para usar paquetes
using Plots
```

## Solución de Problemas Comunes

### ❌ Error: "Cannot assign to variable"
**Solución:** Asegúrate de que cada variable se define en solo una celda
```julia
# ✅ Correcto - todo en una celda
begin
    x = 5
    y = 10
    resultado = x + y
end

# ❌ Incorrecto - variables repetidas en diferentes celdas
```

### 🌐 Pluto no se abre en el navegador
**Soluciones:**
1. Verifica que no haya firewall bloqueando el puerto
2. Intenta con otro puerto: `Pluto.run(port=8080)`
3. Abre manualmente: `http://localhost:1234`
4. Reinicia Julia e intenta de nuevo

### 🐌 Rendimiento lento
**Soluciones:**
- Evita bucles muy largos en celdas reactivas
- Usa `@time` para medir performance: `@time mi_función()`
- Para output extenso, usa `with_terminal()`:
```julia
with_terminal() do
    for i in 1:1000
        println("Número: $i")
    end
end
```

### 📦 Problemas con paquetes
**Solución:** Instala paquetes en celdas separadas:
```julia
# Celda 1: Instalar
begin
    using Pkg
    Pkg.add("NombrePaquete")
end

# Celda 2: Usar (en celda diferente)
using NombrePaquete
```

## 🚀 Primeros Pasos con el Tutorial

### 1. Primer contacto
1. Abre `beginner_pluto.jl` en Pluto.jl
2. Lee la introducción (celdas de texto)
3. Ejecuta la primera celda de código haciendo clic en el ícono ▶️

### 2. Experimentar
- **Modifica valores:** Cambia números en las celdas y ve cómo se actualiza todo
- **Agrega código:** Puedes editar las celdas existentes
- **Crea celdas nuevas:** Usa el botón `+` entre celdas

### 3. Completar ejercicios
- Busca las secciones marcadas como "EJERCICIO"
- Completa el código faltante
- ¡Las soluciones están más abajo si te atascas!

### 4. Guardar tu progreso
- Pluto.jl guarda automáticamente
- Para exportar: `File > Export > Static HTML`

## Recursos Adicionales

📚 **Documentación y Tutoriales:**
- [Documentación oficial de Pluto.jl](https://plutojl.org/) - Guía completa
- [Galería de notebooks](https://plutojl.org/en/docs/sample-notebooks/) - Ejemplos inspiradores
- [Julia Documentation](https://docs.julialang.org/) - Referencia completa de Julia

🛠️ **Desarrollo y Comunidad:**
- [GitHub de Pluto.jl](https://github.com/fonsp/Pluto.jl) - Código fuente y issues
- [Julia Discourse](https://discourse.julialang.org/) - Foro de la comunidad
- [Julia Zulip](https://julialang.zulipchat.com/) - Chat en tiempo real

🎥 **Videos y Cursos:**
- [Julia Academy](https://juliaacademy.com/) - Cursos gratuitos oficiales
- [YouTube: Julia Language](https://www.youtube.com/c/TheJuliaLanguage) - Conferencias y tutoriales

## 💭 ¿Necesitas ayuda?

Si tienes problemas con la instalación o el tutorial:

1. **Revisa esta guía** - La mayoría de problemas están cubiertos aquí
2. **Busca en GitHub Issues** - [Pluto.jl Issues](https://github.com/fonsp/Pluto.jl/issues)
3. **Pregunta en Julia Discourse** - La comunidad es muy amigable
4. **Revisa la documentación** - [docs.julialang.org](https://docs.julialang.org/)

## 🎉 ¡Empezar es lo más difícil!

No te preocupes si al principio parece complicado. Julia y Pluto.jl son herramientas poderosas que se vuelven más naturales con la práctica.

**🎯 Consejos finales:**
- **Experimenta libremente** - No puedes "romper" nada
- **Lee los mensajes de error** - Julia da mensajes muy informativos
- **Empieza simple** - Construye conocimiento paso a paso
- **Divierte** - ¡Programar debería ser divertido!

¡Disfruta aprendando Julia con Pluto.jl! 🚀
