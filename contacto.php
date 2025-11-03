<?php
/**
 * Centro Universitario - Procesador de Formulario de Contacto
 * 
 * Este archivo procesa los datos del formulario de contacto
 * y envía notificaciones por correo electrónico
 */

// Configuración de PHP
error_reporting(E_ALL);
ini_set('display_errors', 0);
header('Content-Type: application/json; charset=utf-8');

<?php
// Validar reCAPTCHA
$recaptcha = $_POST['g-recaptcha-response'];
$secret = '6Le31ewrAAAAABUx2Cx6YVdkJxbHcU1n_a3d4eOb';

$response = file_get_contents("https://www.google.com/recaptcha/api/siteverify?secret=$secret&response=$recaptcha");
$result = json_decode($response);

if (!$result->success) {
  // Si falla el reCAPTCHA, no procesamos el formulario
  echo "Por favor verifica que no eres un robot.";
  exit;
}

// Aquí continúa el procesamiento normal del formulario
$nombre = $_POST['nombre'];
$email = $_POST['email'];
$telefono = $_POST['telefono'];
$interes = $_POST['interes'];
$mensaje = $_POST['mensaje'];

// Aquí puedes enviar el correo, guardar en base de datos, etc.
echo "Formulario enviado correctamente.";
?>

// Iniciar sesión para protección contra spam
session_start();

// Función para limpiar datos de entrada
function limpiarDatos($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

// Función para validar email
function validarEmail($email) {
    return filter_var($email, FILTER_VALIDATE_EMAIL);
}

// Función para validar teléfono
function validarTelefono($telefono) {
    // Permitir números, espacios, guiones y paréntesis
    return preg_match('/^[0-9\s\-\(\)]+$/', $telefono);
}

// Array para almacenar errores
$errores = [];
$response = ['success' => false, 'message' => ''];

// Verificar que la solicitud sea POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    $response['message'] = 'Método de solicitud no válido.';
    echo json_encode($response);
    exit;
}

// Protección básica contra spam - verificar tiempo entre envíos
if (isset($_SESSION['ultimo_envio'])) {
    $tiempo_transcurrido = time() - $_SESSION['ultimo_envio'];
    if ($tiempo_transcurrido < 60) { // 60 segundos entre envíos
        $response['message'] = 'Por favor, espera un momento antes de enviar otro mensaje.';
        echo json_encode($response);
        exit;
    }
}

// Recibir y limpiar datos del formulario
$nombre = isset($_POST['nombre']) ? limpiarDatos($_POST['nombre']) : '';
$email = isset($_POST['email']) ? limpiarDatos($_POST['email']) : '';
$telefono = isset($_POST['telefono']) ? limpiarDatos($_POST['telefono']) : '';
$interes = isset($_POST['interes']) ? limpiarDatos($_POST['interes']) : '';
$mensaje = isset($_POST['mensaje']) ? limpiarDatos($_POST['mensaje']) : '';

// Validar campos requeridos
if (empty($nombre)) {
    $errores[] = 'El nombre es requerido.';
}

if (empty($email)) {
    $errores[] = 'El email es requerido.';
} elseif (!validarEmail($email)) {
    $errores[] = 'El email no es válido.';
}

if (empty($telefono)) {
    $errores[] = 'El teléfono es requerido.';
} elseif (!validarTelefono($telefono)) {
    $errores[] = 'El teléfono no es válido.';
}

if (empty($interes)) {
    $errores[] = 'El motivo de consulta es requerido.';
}

if (empty($mensaje)) {
    $errores[] = 'El mensaje es requerido.';
} elseif (strlen($mensaje) < 10) {
    $errores[] = 'El mensaje debe tener al menos 10 caracteres.';
}

// Si hay errores, devolverlos
if (!empty($errores)) {
    $response['message'] = implode(' ', $errores);
    echo json_encode($response);
    exit;
}

// ===== CONFIGURACIÓN DE EMAIL =====
// IMPORTANTE: Configura estos valores según tu servidor de correo
$destinatario = 'contacto@cusc.mx'; // Email donde recibirás los mensajes
$asunto = 'Nuevo mensaje de contacto - Centro Universitario';

// Mapeo de opciones de interés
$motivos_consulta = [
    'informacion-general' => 'Información General',
    'admission' => 'Proceso de Admisión',
    'becas' => 'Becas y Financiamiento',
    'carreras' => 'Información de Carreras',
    'visita' => 'Agendar Visita',
    'otro' => 'Otro'
];

$interes_texto = isset($motivos_consulta[$interes]) ? $motivos_consulta[$interes] : $interes;

// Construir el cuerpo del email en formato HTML
$cuerpo_email = '
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background: linear-gradient(135deg, #1e3a8a, #1e40af); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }
        .content { background: #f9fafb; padding: 30px; border-radius: 0 0 10px 10px; }
        .field { margin-bottom: 20px; }
        .label { font-weight: bold; color: #1e40af; }
        .value { background: white; padding: 10px; border-radius: 5px; margin-top: 5px; }
        .footer { text-align: center; margin-top: 20px; color: #6b7280; font-size: 12px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📧 Nuevo Mensaje de Contacto</h1>
            <p>Centro Universitario</p>
        </div>
        <div class="content">
            <div class="field">
                <div class="label">Nombre Completo:</div>
                <div class="value">' . htmlspecialchars($nombre) . '</div>
            </div>
            
            <div class="field">
                <div class="label">Email:</div>
                <div class="value">' . htmlspecialchars($email) . '</div>
            </div>
            
            <div class="field">
                <div class="label">Teléfono:</div>
                <div class="value">' . htmlspecialchars($telefono) . '</div>
            </div>
            
            <div class="field">
                <div class="label">Motivo de Consulta:</div>
                <div class="value">' . htmlspecialchars($interes_texto) . '</div>
            </div>
            
            <div class="field">
                <div class="label">Mensaje:</div>
                <div class="value">' . nl2br(htmlspecialchars($mensaje)) . '</div>
            </div>
            
            <div class="footer">
                <p>Recibido el ' . date('d/m/Y H:i:s') . '</p>
                <p>Este es un mensaje automático del formulario de contacto</p>
            </div>
        </div>
    </div>
</body>
</html>
';

// Encabezados del email
$headers = [
    'MIME-Version: 1.0',
    'Content-Type: text/html; charset=UTF-8',
    'From: Centro Universitario <noreply@centrouniversitario.edu>',
    'Reply-To: ' . $email,
    'X-Mailer: PHP/' . phpversion()
];

// Intentar enviar el email
$email_enviado = @mail($destinatario, $asunto, $cuerpo_email, implode("\r\n", $headers));

// ===== GUARDAR EN BASE DE DATOS (OPCIONAL) =====
// Descomenta y configura si deseas guardar los mensajes en una base de datos
/*
try {
    $pdo = new PDO('mysql:host=localhost;dbname=centrouniversitario', 'usuario', 'contraseña');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $sql = "INSERT INTO contactos (nombre, email, telefono, interes, mensaje, fecha) 
            VALUES (:nombre, :email, :telefono, :interes, :mensaje, NOW())";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        ':nombre' => $nombre,
        ':email' => $email,
        ':telefono' => $telefono,
        ':interes' => $interes,
        ':mensaje' => $mensaje
    ]);
    
} catch(PDOException $e) {
    // Log del error (en producción, no mostrar detalles)
    error_log("Error BD: " . $e->getMessage());
}
*/

// ===== GUARDAR EN ARCHIVO CSV (ALTERNATIVA) =====
// Esta es una forma simple de almacenar los datos sin base de datos
try {
    $archivo_csv = 'contactos.csv';
    $nuevo_archivo = !file_exists($archivo_csv);
    
    $fp = fopen($archivo_csv, 'a');
    
    if ($fp) {
        // Si es un archivo nuevo, agregar encabezados
        if ($nuevo_archivo) {
            fputcsv($fp, ['Fecha', 'Nombre', 'Email', 'Teléfono', 'Interés', 'Mensaje']);
        }
        
        // Agregar datos
        fputcsv($fp, [
            date('Y-m-d H:i:s'),
            $nombre,
            $email,
            $telefono,
            $interes_texto,
            $mensaje
        ]);
        
        fclose($fp);
    }
} catch (Exception $e) {
    // Log del error
    error_log("Error al guardar en CSV: " . $e->getMessage());
}

// ===== ENVIAR EMAIL DE CONFIRMACIÓN AL USUARIO =====
$asunto_confirmacion = 'Hemos recibido tu mensaje - Centro Universitario';
$cuerpo_confirmacion = '
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background: linear-gradient(135deg, #1e3a8a, #1e40af); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }
        .content { background: #f9fafb; padding: 30px; border-radius: 0 0 10px 10px; }
        .footer { text-align: center; margin-top: 20px; color: #6b7280; font-size: 12px; }
        .button { display: inline-block; padding: 12px 30px; background: #f59e0b; color: white; text-decoration: none; border-radius: 5px; margin-top: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>¡Gracias por Contactarnos!</h1>
        </div>
        <div class="content">
            <p>Hola <strong>' . htmlspecialchars($nombre) . '</strong>,</p>
            
            <p>Hemos recibido tu mensaje y queremos agradecerte por tu interés en Centro Universitario.</p>
            
            <p>Nuestro equipo revisará tu consulta sobre <strong>' . htmlspecialchars($interes_texto) . '</strong> y te responderemos lo antes posible.</p>
            
            <p>Si tu consulta es urgente, puedes comunicarte con nosotros directamente:</p>
            <ul>
                <li>📞 Teléfono: +55 5975 6260</li>
                <li>📧 Email: contacto@cusc.mx</li>
                <li>🕐 Horario: Lunes a Viernes, 8:00 - 20:00</li>
            </ul>
            
            <div style="text-align: center;">
                <a href="http://localhost/centrouniversitario" class="button">Visita Nuestro Sitio Web</a>
            </div>
            
            <div class="footer">
                <p><strong>Centro Universitario</strong></p>
                <p>Av. Universidad 123, Ciudad Universitaria</p>
                <p>Este es un mensaje automático, por favor no respondas a este email.</p>
            </div>
        </div>
    </div>
</body>
</html>
';

$headers_confirmacion = [
    'MIME-Version: 1.0',
    'Content-Type: text/html; charset=UTF-8',
    'From: Centro Universitario <noreply@centrouniversitario.edu>',
    'X-Mailer: PHP/' . phpversion()
];

@mail($email, $asunto_confirmacion, $cuerpo_confirmacion, implode("\r\n", $headers_confirmacion));

// Actualizar el tiempo del último envío
$_SESSION['ultimo_envio'] = time();

// Enviar respuesta exitosa
$response['success'] = true;
$response['message'] = '¡Gracias por tu mensaje! Nos pondremos en contacto contigo pronto.';

// En caso de que el email no se envíe (servidor sin configurar)
if (!$email_enviado) {
    // Aún así mostrar éxito al usuario (los datos se guardaron en CSV)
    $response['message'] .= ' Tu información ha sido registrada correctamente.';
    // Log del error para el administrador
    error_log("Advertencia: El email no pudo ser enviado. Verifica la configuración del servidor de correo.");
}

echo json_encode($response);
exit;
?>

