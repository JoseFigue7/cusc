# 🚀 Guía Rápida - Centro Universitario

## ⚡ Inicio Rápido en 3 Pasos

### 1️⃣ Abrir XAMPP
- Abre el Panel de Control de XAMPP
- Haz clic en **Start** en Apache
- Verifica que el estado sea verde

### 2️⃣ Acceder al Sitio
- Abre tu navegador (Chrome, Firefox, Edge)
- Ve a: **http://localhost/centrouniversitario**
- ¡Listo! Tu sitio está funcionando

### 3️⃣ Ver los Mensajes de Contacto
- Los mensajes se guardan automáticamente en: `contactos.csv`
- Ábrelo con Excel para ver todos los contactos

---

## 📋 Checklist de Personalización

### ✅ Paso 1: Información Básica

**Archivo:** `index.html`

Busca y reemplaza:
- ✏️ "Centro Universitario" → Tu nombre de universidad
- ✏️ "+52 (555) 123-4567" → Tu teléfono
- ✏️ "informes@centrouniversitario.edu" → Tu email
- ✏️ "Av. Universidad 123" → Tu dirección

### ✅ Paso 2: Colores Institucionales

**Archivo:** `css/style.css` (líneas 7-18)

```css
:root {
    --primary-color: #1e40af;    /* Tu color principal */
    --secondary-color: #f59e0b;  /* Tu color secundario */
}
```

### ✅ Paso 3: Redes Sociales

**Archivo:** `index.html`

Busca estos textos y reemplaza los enlaces:
- `https://facebook.com` → Tu página de Facebook
- `https://instagram.com` → Tu Instagram
- `https://twitter.com` → Tu Twitter
- `https://linkedin.com` → Tu LinkedIn
- `https://youtube.com` → Tu canal de YouTube

### ✅ Paso 4: Google Maps

1. Ve a: https://www.google.com/maps
2. Busca tu ubicación
3. Clic en "Compartir" → "Incorporar un mapa"
4. Copia el código `<iframe>`
5. Reemplaza el iframe en `index.html` (busca la palabra "mapa")

---

## 🎨 Cambiar Imágenes

Las imágenes actuales son de ejemplo de internet. Para cambiar:

1. **Guarda tus imágenes** en una carpeta `images/`
2. **En index.html**, busca las URLs de `unsplash.com`
3. **Reemplaza** con: `images/tu-imagen.jpg`

**Ejemplo:**
```html
<!-- Antes -->
<img src="https://images.unsplash.com/photo-123456...">

<!-- Después -->
<img src="images/campus.jpg">
```

---

## 📧 Configurar Email

### Opción 1: Recibir en CSV (Ya configurado)
- Los mensajes se guardan en `contactos.csv`
- Abre con Excel o Google Sheets
- ¡No necesitas configurar nada!

### Opción 2: Recibir por Email

**Archivo:** `contacto.php` (línea 126)

```php
$destinatario = 'tuEmail@tudominio.com';  // Cambia esto
```

**NOTA:** Necesitas configurar el servidor de correo de tu hosting.

---

## 🔧 Solución de Problemas Comunes

### ❌ "No se puede acceder al sitio"
**Solución:**
1. Verifica que Apache esté iniciado (verde) en XAMPP
2. Verifica la URL: `http://localhost/centrouniversitario`
3. Reinicia Apache

### ❌ "El formulario no funciona"
**Solución:**
1. Los datos SÍ se guardan en `contactos.csv`
2. El email puede no funcionar (necesita configuración de hosting)
3. Para pruebas, revisa el archivo CSV

### ❌ "Las imágenes no cargan"
**Solución:**
1. Necesitas conexión a internet (las imágenes son de Unsplash)
2. O reemplaza con imágenes locales (ver arriba)

---

## 📱 Probar en Celular

1. **Encuentra tu IP local:**
   - Windows: Abre CMD y escribe `ipconfig`
   - Busca "IPv4" (ej: 192.168.1.100)

2. **En tu celular:**
   - Conéctate a la misma red WiFi
   - Abre el navegador
   - Ve a: `http://TU-IP/centrouniversitario`
   - Ejemplo: `http://192.168.1.100/centrouniversitario`

---

## 📊 Ver Contactos Recibidos

### Método 1: Excel
1. Abre el archivo `contactos.csv`
2. Verás todos los datos organizados en columnas

### Método 2: Bloc de Notas
1. Abre `contactos.csv` con Bloc de Notas
2. Verás los datos separados por comas

### Método 3: Base de Datos (Avanzado)
1. Importa `database.sql` en phpMyAdmin
2. Edita `contacto.php` para usar la base de datos
3. Descomenta las líneas 149-167

---

## 🎯 Contenido a Personalizar

### Página Principal (Hero)
- ✏️ Título principal
- ✏️ Texto descriptivo
- ✏️ Estadísticas (20+ años, 5000+ estudiantes, etc.)

### Sección Nosotros
- ✏️ Misión de la universidad
- ✏️ Valores institucionales
- ✏️ Características destacadas

### Sección Carreras
- ✏️ Nombres de carreras
- ✏️ Duración
- ✏️ Fechas de inicio
- ✏️ Descripciones

### Sección Noticias
- ✏️ Títulos de noticias
- ✏️ Contenido
- ✏️ Fechas
- ✏️ Categorías

---

## 🌐 Publicar en Internet

### Paso 1: Contratar Hosting
Recomendados:
- Hostinger
- SiteGround
- GoDaddy
- Bluehost

### Paso 2: Subir Archivos
1. Usa FTP (FileZilla)
2. Sube todos los archivos a la carpeta `public_html/`

### Paso 3: Configurar
1. Actualiza las URLs en `sitemap.xml`
2. Actualiza las URLs en `robots.txt`
3. Cambia `localhost` por tu dominio en todos los archivos

### Paso 4: SSL (HTTPS)
- La mayoría de hostings ofrecen SSL gratis
- Activa SSL en tu panel de hosting
- Descomenta la línea de HTTPS en `.htaccess`

---

## 📚 Archivos Importantes

| Archivo | Para qué sirve |
|---------|----------------|
| `index.html` | Página principal - TODO el contenido |
| `css/style.css` | Colores y diseño |
| `js/main.js` | Funcionalidades interactivas |
| `contacto.php` | Procesa el formulario |
| `contactos.csv` | Guarda los mensajes |
| `README.md` | Documentación completa |
| `GUIA_RAPIDA.md` | Este archivo |

---

## 🎓 Siguientes Pasos

1. ✅ **Revisar el sitio completo**
   - Navega por todas las secciones
   - Prueba el formulario de contacto
   - Verifica en celular

2. ✅ **Personalizar contenido**
   - Cambiar textos
   - Actualizar información de contacto
   - Modificar carreras y noticias

3. ✅ **Agregar imágenes reales**
   - Fotos del campus
   - Fotos de estudiantes
   - Logos institucionales

4. ✅ **Configurar redes sociales**
   - Actualizar todos los enlaces
   - Verificar que funcionen

5. ✅ **Preparar para producción**
   - Contratar hosting
   - Registrar dominio
   - Subir archivos

---

## 💡 Consejos Útiles

### ✨ Antes de Presentar al Cliente
- [ ] Prueba TODOS los enlaces
- [ ] Revisa ortografía
- [ ] Verifica en diferentes navegadores
- [ ] Prueba en celular y tablet
- [ ] Envía un mensaje de prueba por el formulario

### 🎨 Para Mejor Impacto Visual
- Usa imágenes de alta calidad
- Mantén coherencia en colores
- Usa fotos reales de tu institución
- Actualiza el logo si tienes uno

### 📈 Para Mejor Posicionamiento SEO
- Actualiza los meta tags
- Envía el sitemap a Google
- Usa descripciones descriptivas
- Optimiza las imágenes (tamaño)

---

## 🆘 ¿Necesitas Ayuda?

### Recursos en Línea
- **Bootstrap:** https://getbootstrap.com/docs
- **jQuery:** https://api.jquery.com
- **PHP:** https://www.php.net/manual/es

### Tutoriales
- YouTube: "Bootstrap 5 tutorial español"
- YouTube: "PHP formulario de contacto"
- YouTube: "Subir sitio web con FileZilla"

---

## ✅ Checklist Final

Antes de lanzar el sitio:

- [ ] Todo el contenido está actualizado
- [ ] Las imágenes están optimizadas
- [ ] Todos los enlaces funcionan
- [ ] El formulario se ha probado
- [ ] Se probó en celular
- [ ] Se probó en diferentes navegadores
- [ ] El email de contacto está configurado
- [ ] Las redes sociales están actualizadas
- [ ] El mapa de Google está configurado
- [ ] Se ha creado respaldo de los archivos

---

## 🎉 ¡Felicidades!

Tienes un sitio web profesional, moderno y completamente funcional.

**Recuerda:** Este es un punto de partida. Puedes expandirlo con:
- Blog de noticias dinámico
- Sistema de inscripciones online
- Portal para estudiantes
- Sistema de pagos
- Chat en vivo
- Y mucho más...

---

**Última actualización:** Octubre 2025  
**Versión:** 1.0 - Mockup Inicial

