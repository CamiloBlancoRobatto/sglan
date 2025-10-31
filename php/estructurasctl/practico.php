<?php
//a) Usá un if para verificar si una variable $nota es mayor o igual a 6 y mostrar "Aprobado", si no, "Reprobado".
$nota = 6;

if ($nota >= 6) {
    echo "Aprobado.<br>";
} else {
    echo "Reprobado.<br>";
}

//b) Creá un bucle for que imprima los números del 10 al 1.
$contador = 10;
while ($contador >= 1) {
    echo "Número: $contador.<br>";
    $contador--;
}

//c) Recorre un array con foreach y mostrale el nombre a cada elemento: ["Pedro", "María", "Sofía"].
$nombres = ["Pedro", "María", "Sofía"];

foreach ($nombres as $nombre) {
    echo "$nombre.<br>";
}

//d) Usá switch para responder a los días: "lunes", "viernes" o "otro día".
$dia = "viernes";

switch ($dia) {
    case "lunes":
        echo "Inicio de semana.<br>";
        break;
    case "viernes":
        echo "Quinto día de la semana.<br>";
        break;
    default:
        echo "Otro día.<br>";
}
?>