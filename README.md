# 🎓 Centro Universitario - Sitio Web Institucional

## 📋 Descripción del Proyecto

Este es un **mockup/prototipo funcional** del sitio web institucional para Centro Universitario. Es un primer acercamiento al cliente que presenta un diseño moderno, profesional y completamente responsivo, listo para ser personalizado según las necesidades específicas de la institución.

---

## ✨ Características Principales

### 🎨 Diseño Moderno y Responsivo
- **Bootstrap 5** para un diseño profesional y adaptable
- **Diseño Mobile-First** que se adapta perfectamente a todos los dispositivos
- **Paleta de colores universitaria** (azules institucionales con acentos dorados)
- **Tipografía moderna** con Google Fonts (Poppins)

### 📑 Secciones Incluidas

1. **Inicio (Hero)** 
   - Presentación impactante con estadísticas animadas
   - Llamados a la acción (CTAs) prominentes
   - Efecto parallax en el fondo

2. **Nosotros**
   - Misión institucional
   - Valores corporativos con iconos
   - Características destacadas
   - Galería de imágenes

3. **Carreras**
   - 6 carreras presentadas con tarjetas interactivas
   - Modales con información detallada
   - Imágenes de alta calidad
   - Duración, fecha de inicio y certificación

4. **Noticias**
   - 6 artículos de noticias recientes
   - Categorías con etiquetas
   - Diseño tipo tarjeta con hover effects
   - Metadata (fecha, autor)

5. **Contacto**
   - Formulario funcional con validación
   - Información de contacto completa
   - Integración con Google Maps
   - Redes sociales activas

### 🚀 Funcionalidades Técnicas

- ✅ **SEO Optimizado** - Meta tags, Open Graph, estructura semántica
- ✅ **Formulario de Contacto Funcional** - Con procesamiento PHP y envío de emails
- ✅ **Animaciones Suaves** - Librería AOS para animaciones al hacer scroll
- ✅ **Navegación Smooth Scroll** - Navegación fluida entre secciones
- ✅ **Integración de Redes Sociales** - Enlaces a Facebook, Twitter, Instagram, LinkedIn, YouTube
- ✅ **Modales Informativos** - Para detalles de carreras
- ✅ **Botón Scroll to Top** - Para mejor navegación
- ✅ **Validación de Formularios** - Tanto en cliente como en servidor

---

## 📁 Estructura de Archivos

```
centrouniversitario/
│
├── index.html              # Página principal
├── contacto.php           # Procesador del formulario
├── contactos.csv          # Almacenamiento de mensajes (se crea automáticamente)
├── README.md              # Este archivo
│
├── css/
│   └── style.css          # Estilos personalizados
│
└── js/
    └── main.js            # JavaScript personalizado
```

---

## 🛠️ Tecnologías Utilizadas

- **HTML5** - Estructura semántica
- **CSS3** - Estilos avanzados con variables CSS
- **Bootstrap 5.3.2** - Framework CSS responsivo
- **JavaScript (ES6+)** - Interactividad moderna
- **jQuery 3.7.1** - Manipulación del DOM
- **PHP 7+** - Procesamiento del servidor
- **AOS (Animate On Scroll)** - Librería de animaciones
- **Bootstrap Icons** - Iconografía moderna
- **Google Fonts** - Tipografía profesional

---

## 🚀 Instalación y Configuración

### Requisitos Previos
- Servidor web (Apache, Nginx)
- PHP 7.0 o superior
- Navegador web moderno

### Instalación Local con XAMPP

1. **Clonar o copiar el proyecto**
   ```bash
   # Si lo tienes en c:\xampp\htdocs\centrouniversitario\
   # Ya está en la ubicación correcta
   ```

2. **Iniciar XAMPP**
   - Abre el Panel de Control de XAMPP
   - Inicia Apache (y MySQL si usarás base de datos)

3. **Acceder al sitio**
   - Abre tu navegador
   - Ve a: `http://localhost/centrouniversitario`

### Configuración del Formulario de Contacto

Edita el archivo `contacto.php` (línea ~126):

```php
// Configura tu email de destino
$destinatario = 'informes@centrouniversitario.edu';
```

**Opciones de almacenamiento:**

1. **CSV (Predeterminado)** - Los mensajes se guardan en `contactos.csv`
2. **Email** - Configura el servidor de correo en PHP
3. **Base de Datos** - Descomenta la sección de BD en `contacto.php`

---

## 📧 Configuración de Email

### Opción 1: Configurar PHP mail()

Edita `php.ini`:

```ini
[mail function]
SMTP = smtp.tu-servidor.com
smtp_port = 587
sendmail_from = noreply@centrouniversitario.edu
```

### Opción 2: Usar PHPMailer (Recomendado)

```bash
composer require phpmailer/phpmailer
```

### Opción 3: Servicio Externo

Considera usar servicios como:
- SendGrid
- Mailgun
- Amazon SES

---

## 🎨 Personalización

### Cambiar Colores

Edita `css/style.css` (líneas 7-18):

```css
:root {
    --primary-color: #1e40af;        /* Color principal */
    --secondary-color: #f59e0b;      /* Color secundario */
    /* ... más variables ... */
}
```

### Cambiar Imágenes

Las imágenes actuales son de **Unsplash** (placeholders). Reemplázalas con:

```html
<!-- En index.html, busca y reemplaza las URLs -->
<img src="ruta/a/tu/imagen.jpg" alt="Descripción">
```

### Cambiar Contenido

Todo el contenido está en `index.html`. Busca y modifica:
- Textos
- Enlaces
- Información de contacto
- Carreras
- Noticias

### Agregar/Quitar Secciones

Simplemente copia la estructura de una sección existente:

```html
<section id="nueva-seccion" class="py-5">
    <div class="container py-5">
        <!-- Tu contenido aquí -->
    </div>
</section>
```

---

## 📱 Redes Sociales

Actualiza los enlaces en `index.html` (busca los `href` de redes sociales):

```html
<a href="https://facebook.com/tupagina" target="_blank">
<a href="https://twitter.com/tuusuario" target="_blank">
<a href="https://instagram.com/tuusuario" target="_blank">
```

---

## 🗺️ Google Maps

Para personalizar el mapa, genera tu embed en:
https://www.google.com/maps

Luego reemplaza el `<iframe>` en la sección de contacto.

---

## 🔍 SEO - Optimización para Buscadores

### Meta Tags Incluidos
- Description
- Keywords
- Open Graph (Facebook/Twitter)
- Responsive viewport

### Para Mejorar el SEO

1. **Personaliza los meta tags** en `<head>`
2. **Agrega un sitemap.xml**
3. **Configura Google Analytics**
4. **Registra en Google Search Console**
5. **Optimiza velocidad de carga**

---

## 📊 Google Analytics (Opcional)

Agrega antes de `</head>` en `index.html`:

```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=TU-ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'TU-ID');
</script>
```

---

## 🛡️ Seguridad

### Recomendaciones

1. **Validación de Formularios** ✅ Ya implementada
2. **Protección CSRF** - Considera agregar tokens
3. **Sanitización de Datos** ✅ Ya implementada
4. **Límite de Envíos** ✅ Ya implementado (60 segundos)
5. **HTTPS** - Usa SSL en producción
6. **Captcha** - Considera agregar reCAPTCHA

---

## 📈 Próximos Pasos / Mejoras Futuras

### Funcionalidades Adicionales

- [ ] Sistema de login para estudiantes
- [ ] Portal de pagos en línea
- [ ] Blog de noticias dinámico
- [ ] Sistema de inscripción online
- [ ] Base de datos MySQL completa
- [ ] Panel de administración
- [ ] Galería de fotos/videos
- [ ] Calendario de eventos
- [ ] Chat en vivo
- [ ] Testimonios de estudiantes

### Integraciones

- [ ] CRM (HubSpot, Salesforce)
- [ ] Sistema de gestión académica
- [ ] Plataforma de e-learning
- [ ] Sistema de pagos (PayPal, Stripe)
- [ ] WhatsApp Business API

---

## 🐛 Resolución de Problemas

### El formulario no envía emails

**Solución:**
1. Verifica la configuración de PHP mail()
2. Revisa los logs de Apache: `xampp/apache/logs/error.log`
3. Usa el archivo CSV como alternativa temporal
4. Considera usar PHPMailer

### Las imágenes no cargan

**Solución:**
1. Verifica tu conexión a internet (las imágenes son de Unsplash)
2. Reemplaza con imágenes locales

### Animaciones no funcionan

**Solución:**
1. Verifica que AOS esté cargando correctamente
2. Abre la consola del navegador (F12) y busca errores

### Estilos no se aplican

**Solución:**
1. Verifica las rutas de los archivos CSS
2. Limpia la caché del navegador (Ctrl + Shift + R)

---

## 📞 Soporte y Contacto

Para modificaciones, mejoras o soporte técnico, contacta con el desarrollador.

---

## 📄 Licencia

Este es un proyecto mockup para demostración al cliente. Los derechos de personalización y uso pertenecen a Centro Universitario.

---

## 🙏 Créditos

- **Imágenes:** [Unsplash](https://unsplash.com) (placeholder images)
- **Iconos:** [Bootstrap Icons](https://icons.getbootstrap.com)
- **Framework:** [Bootstrap 5](https://getbootstrap.com)
- **Fuentes:** [Google Fonts](https://fonts.google.com)
- **Animaciones:** [AOS Library](https://michalsnik.github.io/aos/)

---

## 📝 Notas Importantes

> ⚠️ **Este es un MOCKUP/PROTOTIPO** diseñado para presentación inicial al cliente.
> 
> - Las imágenes son placeholders de Unsplash
> - Los datos son ficticios y demostrativos
> - Los enlaces de redes sociales apuntan a las páginas principales
> - El mapa muestra una ubicación genérica de Ciudad Universitaria
> - El formulario guarda en CSV por defecto (configurar email)

---

## ✅ Checklist de Implementación

Antes de lanzar a producción:

- [ ] Reemplazar todas las imágenes placeholder
- [ ] Actualizar todo el contenido con información real
- [ ] Configurar email de contacto
- [ ] Actualizar enlaces de redes sociales
- [ ] Personalizar el mapa de Google
- [ ] Configurar dominio y hosting
- [ ] Instalar certificado SSL
- [ ] Configurar Google Analytics
- [ ] Probar en todos los navegadores
- [ ] Optimizar velocidad de carga
- [ ] Crear sitemap.xml
- [ ] Registrar en Google Search Console

---

## 🎯 Conclusión

Este sitio web mockup está **100% funcional** y listo para ser presentado al cliente. Ofrece una base sólida y profesional que puede ser personalizada y expandida según las necesidades específicas de la institución.

**Características destacadas:**
- ✅ Diseño moderno y profesional
- ✅ Totalmente responsivo
- ✅ SEO optimizado
- ✅ Formulario funcional
- ✅ Código limpio y bien documentado
- ✅ Fácil de personalizar

¡Éxito con la presentación al cliente! 🚀

---

*Última actualización: Octubre 2025*

