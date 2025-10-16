/**
 * Centro Universitario - Main JavaScript
 * Funcionalidades principales de la página web
 */

$(document).ready(function() {
    
    // ===== Inicializar AOS (Animate On Scroll) =====
    AOS.init({
        duration: 800,
        easing: 'ease-in-out',
        once: true,
        offset: 100
    });

    // ===== Navbar Scroll Effect =====
    $(window).scroll(function() {
        if ($(this).scrollTop() > 50) {
            $('#mainNav').addClass('scrolled');
        } else {
            $('#mainNav').removeClass('scrolled');
        }
    });

    // ===== Smooth Scrolling para enlaces internos =====
    $('a[href^="#"]').on('click', function(e) {
        const target = $(this).attr('href');
        
        // Verificar si el target existe
        if ($(target).length) {
            e.preventDefault();
            
            $('html, body').animate({
                scrollTop: $(target).offset().top - 80
            }, 800, 'swing');
            
            // Cerrar el menu móvil si está abierto
            if ($('.navbar-collapse').hasClass('show')) {
                $('.navbar-toggler').click();
            }
        }
    });

    // ===== Active Navigation Link =====
    $(window).on('scroll', function() {
        const scrollPos = $(window).scrollTop() + 100;
        
        $('section').each(function() {
            const currentSection = $(this);
            const sectionTop = currentSection.offset().top;
            const sectionBottom = sectionTop + currentSection.outerHeight();
            const sectionId = currentSection.attr('id');
            
            if (scrollPos >= sectionTop && scrollPos < sectionBottom) {
                $('.nav-link').removeClass('active');
                $('.nav-link[href="#' + sectionId + '"]').addClass('active');
            }
        });
    });

    // ===== Scroll to Top Button =====
    const scrollTopBtn = $('#scrollTopBtn');
    
    $(window).scroll(function() {
        if ($(this).scrollTop() > 300) {
            scrollTopBtn.addClass('show');
        } else {
            scrollTopBtn.removeClass('show');
        }
    });
    
    scrollTopBtn.click(function() {
        $('html, body').animate({
            scrollTop: 0
        }, 600);
        return false;
    });

    // ===== Formulario de Contacto con AJAX =====
    $('#contactForm').on('submit', function(e) {
        e.preventDefault();
        
        const form = $(this);
        const formData = form.serialize();
        const submitBtn = form.find('button[type="submit"]');
        const formMessage = $('#formMessage');
        
        // Deshabilitar el botón durante el envío
        submitBtn.prop('disabled', true);
        submitBtn.html('<span class="spinner-border spinner-border-sm me-2"></span>Enviando...');
        
        // Enviar el formulario
        $.ajax({
            url: form.attr('action'),
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    formMessage
                        .removeClass('alert-danger')
                        .addClass('alert alert-success')
                        .html('<i class="bi bi-check-circle me-2"></i>' + response.message)
                        .fadeIn();
                    
                    // Limpiar el formulario
                    form[0].reset();
                    
                    // Ocultar el mensaje después de 5 segundos
                    setTimeout(function() {
                        formMessage.fadeOut();
                    }, 5000);
                } else {
                    formMessage
                        .removeClass('alert-success')
                        .addClass('alert alert-danger')
                        .html('<i class="bi bi-exclamation-triangle me-2"></i>' + response.message)
                        .fadeIn();
                }
            },
            error: function() {
                formMessage
                    .removeClass('alert-success')
                    .addClass('alert alert-danger')
                    .html('<i class="bi bi-exclamation-triangle me-2"></i>Ha ocurrido un error. Por favor, inténtalo de nuevo.')
                    .fadeIn();
            },
            complete: function() {
                // Rehabilitar el botón
                submitBtn.prop('disabled', false);
                submitBtn.html('<i class="bi bi-send"></i> Enviar Mensaje');
            }
        });
    });

    // ===== Contador Animado para Estadísticas =====
    function animateCounter(element, start, end, duration) {
    let startTimestamp = null;
    const step = (timestamp) => {
        if (!startTimestamp) startTimestamp = timestamp;
        const progress = Math.min((timestamp - startTimestamp) / duration, 1);
        const value = Math.floor(progress * (end - start) + start);
        element.text(value); // 🔹 Eliminado el "+"
        if (progress < 1) {
            window.requestAnimationFrame(step);
        }
    };
    window.requestAnimationFrame(step);
}

    // Activar contador cuando la sección sea visible
    let countersActivated = false;
    $(window).on('scroll', function() {
        if (!countersActivated && $('#inicio').length) {
            const statsTop = $('#inicio .stat-box').first().offset().top;
            const scrollPos = $(window).scrollTop() + $(window).height();
            
            if (scrollPos > statsTop) {
                countersActivated = true;
                
                // Animar cada contador
                const counters = [

                    { element: $('#inicio .stat-box').eq(2).find('h2'), value: 6 }
                ];
                
                counters.forEach(counter => {
                    if (counter.element.length) {
                        animateCounter(counter.element, 0, counter.value, 2000);
                    }
                });
            }
        }
    });

    // ===== Lazy Loading para Imágenes =====
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src || img.src;
                    img.classList.add('loaded');
                    observer.unobserve(img);
                }
            });
        });

        document.querySelectorAll('img').forEach(img => {
            imageObserver.observe(img);
        });
    }

    // ===== Validación adicional del formulario =====
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', function(event) {
            if (!contactForm.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            contactForm.classList.add('was-validated');
        }, false);
    }

    // ===== Animación de entrada para las tarjetas =====
    $('.career-card, .news-card, .value-card').each(function(index) {
        $(this).css({
            'animation-delay': (index * 0.1) + 's'
        });
    });

    // ===== Hover effect para las imágenes de las carreras =====
    $('.career-card').hover(
        function() {
            $(this).find('.career-image img').css('transform', 'scale(1.1)');
        },
        function() {
            $(this).find('.career-image img').css('transform', 'scale(1)');
        }
    );

    // ===== Preloader (opcional) =====
    $(window).on('load', function() {
        if ($('#preloader').length) {
            $('#preloader').delay(100).fadeOut('slow', function() {
                $(this).remove();
            });
        }
    });

    // ===== Cerrar modales al hacer clic en enlaces internos =====
    $('.modal a[href^="#"]').on('click', function() {
        $('.modal').modal('hide');
    });

    // ===== Efecto parallax para el hero =====
    $(window).scroll(function() {
        const scrolled = $(window).scrollTop();
        $('.hero-section').css('background-position', 'center ' + (scrolled * 0.5) + 'px');
    });

    // ===== Mostrar animación al hacer scroll a las secciones =====
    function isElementInViewport(el) {
        const rect = el.getBoundingClientRect();
        return (
            rect.top >= 0 &&
            rect.left >= 0 &&
            rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
            rect.right <= (window.innerWidth || document.documentElement.clientWidth)
        );
    }

    function callbackFunc() {
        const items = document.querySelectorAll('.fade-in-up');
        for (let i = 0; i < items.length; i++) {
            if (isElementInViewport(items[i])) {
                items[i].classList.add('visible');
            }
        }
    }

    window.addEventListener('load', callbackFunc);
    window.addEventListener('scroll', callbackFunc);

    // ===== Tooltip de Bootstrap =====
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // ===== Efecto de escritura para el título hero (opcional) =====
    function typeWriter(element, text, speed = 50) {
        let i = 0;
        element.html('');
        
        function type() {
            if (i < text.length) {
                element.html(element.html() + text.charAt(i));
                i++;
                setTimeout(type, speed);
            }
        }
        type();
    }

    // ===== Detectar y animar elementos cuando entran en viewport =====
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
            }
        });
    }, observerOptions);

    // Observar elementos que queremos animar
    document.querySelectorAll('.career-card, .news-card, .value-card').forEach(el => {
        observer.observe(el);
    });

    // ===== Agregar clase active a los links del navbar al hacer clic =====
    $('.navbar-nav .nav-link').on('click', function() {
        $('.navbar-nav .nav-link').removeClass('active');
        $(this).addClass('active');
    });

    // ===== Efecto de zoom en imágenes al hacer clic =====
    $('.career-image img, .news-image img').on('click', function() {
        const imgSrc = $(this).attr('src');
        const modal = `
            <div class="modal fade" id="imageModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content bg-transparent border-0">
                        <div class="modal-body p-0">
                            <button type="button" class="btn-close btn-close-white position-absolute top-0 end-0 m-3 z-index-1" 
                                    data-bs-dismiss="modal" style="z-index: 10;"></button>
                            <img src="${imgSrc}" class="img-fluid rounded" alt="Imagen ampliada">
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        // Remover modal anterior si existe
        $('#imageModal').remove();
        
        // Agregar y mostrar nuevo modal
        $('body').append(modal);
        $('#imageModal').modal('show');
        
        // Limpiar al cerrar
        $('#imageModal').on('hidden.bs.modal', function() {
            $(this).remove();
        });
    });

    // ===== Console Log de Bienvenida =====
    console.log('%c¡Bienvenido a Centro Universitario!', 'color: #1e40af; font-size: 20px; font-weight: bold;');
    console.log('%cDesarrollado con ❤️ para ofrecer la mejor experiencia educativa', 'color: #6b7280; font-size: 12px;');

    // ===== Mensaje de debug para desarrollo =====
    if (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') {
        console.log('%cModo de desarrollo activado', 'color: #f59e0b; font-weight: bold;');
    }

});

// ===== Función para validar email =====
function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(String(email).toLowerCase());
}

// ===== Función para formatear teléfono =====
function formatPhone(phone) {
    const cleaned = ('' + phone).replace(/\D/g, '');
    const match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/);
    if (match) {
        return '(' + match[1] + ') ' + match[2] + '-' + match[3];
    }
    return phone;
}

// ===== Protección básica contra spam en formularios =====
(function() {
    const formSubmissions = [];
    const maxSubmissions = 3;
    const timeWindow = 60000; // 1 minuto

    window.checkFormSubmission = function() {
        const now = Date.now();
        const recentSubmissions = formSubmissions.filter(time => now - time < timeWindow);
        
        if (recentSubmissions.length >= maxSubmissions) {
            alert('Has enviado demasiados formularios recientemente. Por favor, espera un momento.');
            return false;
        }
        
        formSubmissions.push(now);
        return true;
    };
})();

// Al abrir el menú
document.body.classList.add('no-scroll');

// Al cerrar el menú
document.body.classList.remove('no-scroll');
