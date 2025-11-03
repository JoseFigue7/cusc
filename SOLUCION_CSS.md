# Solución: CSS no se reconoce en servidor en línea

## Problemas Comunes y Soluciones

### 1. **Case Sensitivity (Mayúsculas/Minúsculas)**
Los servidores Linux son case-sensitive. Asegúrate de que:
- El directorio se llama exactamente `css` (minúsculas)
- La ruta en el HTML es `css/style.css` (minúsculas)
- El archivo se llama exactamente `style.css` (minúsculas)

**Solución:**
```bash
# En el servidor, verifica el nombre del directorio:
ls -la | grep css

# Si el directorio se llama CSS (mayúsculas), renómbralo:
mv CSS css
```

### 2. **Verificar Rutas en el HTML**
Asegúrate de que en `index.html` la línea 32 tenga:
```html
<link rel="stylesheet" href="css/style.css">
```

Si el proyecto está en un subdirectorio (ej: `/public_html/mi-sitio/`), usa rutas absolutas:
```html
<link rel="stylesheet" href="/css/style.css">
```

### 3. **Permisos de Archivo**
Los archivos CSS deben tener permisos de lectura:
```bash
# En el servidor, verifica permisos:
ls -la css/style.css

# Si no tiene permisos de lectura, cambia:
chmod 644 css/style.css
chmod 755 css/
```

### 4. **Cache del Navegador**
Limpia la caché del navegador:
- **Chrome/Edge**: Ctrl+Shift+Delete o Ctrl+F5
- **Firefox**: Ctrl+Shift+Delete o Ctrl+F5
- **Safari**: Cmd+Option+E

### 5. **Verificar que el archivo existe**
Asegúrate de que el archivo `css/style.css` existe en el servidor:
```bash
# Verifica que el archivo existe:
ls -la css/style.css

# Verifica el contenido:
head -20 css/style.css
```

### 6. **Verificar en el navegador**
Abre las herramientas de desarrollador (F12) y:
1. Ve a la pestaña **Network/Red**
2. Recarga la página (F5)
3. Busca `style.css` en la lista
4. Si aparece en rojo, haz clic para ver el error

### 7. **Rutas absolutas vs relativas**
Si tu sitio está en `https://tusitio.com/mi-proyecto/`, usa:
```html
<!-- Ruta relativa (desde donde está el HTML) -->
<link rel="stylesheet" href="css/style.css">

<!-- Ruta absoluta (desde la raíz del dominio) -->
<link rel="stylesheet" href="/mi-proyecto/css/style.css">
```

### 8. **Verificar .htaccess**
Si usas un servidor Apache, asegúrate de que el `.htaccess` no esté bloqueando los archivos CSS:
```apache
# Permitir archivos CSS
<FilesMatch "\.(css)$">
    Allow from all
</FilesMatch>
```

## Checklist de Verificación

- [ ] El directorio se llama `css` (minúsculas)
- [ ] El archivo se llama `style.css` (minúsculas)
- [ ] La ruta en el HTML es correcta: `css/style.css`
- [ ] Los permisos del archivo son 644
- [ ] Los permisos del directorio son 755
- [ ] El archivo existe en el servidor
- [ ] Has limpiado la caché del navegador
- [ ] Has verificado en las herramientas de desarrollador (F12)

## Comandos Útiles para el Servidor

```bash
# Ver estructura de directorios
find . -type d -name "css"

# Ver archivos CSS
find . -name "*.css"

# Verificar permisos
ls -la css/

# Cambiar permisos si es necesario
chmod 644 css/*.css
chmod 755 css/
```

