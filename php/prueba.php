<?php
// Función que determina si una persona es mayor o menor de edad
function esMayorDeEdad($edad) {
    if ($edad >= 18) {
        return "Mayor de edad";
    } else {
        return "Menor de edad";
    }
}

// Función que convierte grados Celsius a Fahrenheit
function celsiusAFahrenheit($celsius) {
    return ($celsius * 9/5) + 32;
}

// Función que calcula el área de un triángulo
function areaTriangulo($base, $altura) {
    return ($base * $altura) / 2;
}

// PEDIR edad
echo "Ingrese su edad: ";
$edad = trim(fgets(STDIN));
echo esMayorDeEdad($edad) . "\n";

// PEDIR grados Celsius
echo "\n" . "Ingrese temperatura en grados Celsius: ";
$celsius = trim(fgets(STDIN));
echo "Equivalente en Fahrenheit: " . celsiusAFahrenheit($celsius) . " °F\n";

// PEDIR base y altura para calcular el área de un triángulo
echo "\n" . "Ingrese la base del triángulo: ";
$base = trim(fgets(STDIN));
echo "Ingrese la altura del triángulo: ";
$altura = trim(fgets(STDIN));
echo "Área del triángulo: " . areaTriangulo($base, $altura) . "\n";
?>
