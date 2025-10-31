<?php
$usuario = $_POST['usuario'];
$clave = $_POST['clave'];

// Usuario y contraseña fijos (esto en proyectos reales se guarda en una base de datos)
$usuario_valido1 = "admin";
$clave_valida1 = "1234";

//Agregar un segundo usuario válido (por ejemplo: user2 con clave abcd).
$usuario_valido2 = "user2";
$clave_valida2 = "abcd";

//Mostrar el mensaje: "Acceso denegado. Intente nuevamente." si falla el login.
if((($usuario == $usuario_valido1) && ($clave == $clave_valida2)) or (($usuario == $usuario_valido2) && ($clave == $clave_valida1))){
    echo "<h2>Acceso denegado. Intente nuevamente.</h2><br><br>";
    echo "<a href='index.html'>Volver al Login</a>";

    //Validar.
}else if (($usuario == $usuario_valido1 && $clave == $clave_valida1) || ($usuario == $usuario_valido2 && $clave == $clave_valida2)) {
    echo "<h2>Bienvenido, $usuario</h2><br><br>";
    echo "<a href='index.html'>Volver al Login</a>";
} else {
    echo "<h2>Usuario o contraseña incorrectos</h2><br><br>";
    echo "<a href='index.html'>Volver al Login</a>";
}

?>