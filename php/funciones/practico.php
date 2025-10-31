<?php
$edad = $_POST['edad'];
$grados = $_POST['grados'];
$base = $_POST['base'];
$altura = $_POST['altura'];

//Crear una función que reciba una edad y devuelva si es mayor o menor de edad.
function mayoriaEdad($edad) {
    if ($edad >= 18) {
        return "Es mayor de edad.<br>";
    } else {
        return "Es menor de edad.<br>";
    }
}
$mayoria = mayoriaEdad($edad);
echo $mayoria;

//Crear una función que convierta grados Celsius a Fahrenheit.
function caf($grados){
    return (($grados * 1.8) + 32);
}
$fahrenheit = caf($grados);
echo "$grados Celsius son $fahrenheit Fahrenheit.<br>";

//Crear una función que calcule el área de un triángulo.
function areaTriangle($base , $altura){
    return (($base * $altura) / 2);
}
$area = areaTriangle($base , $altura);
echo "El área de su triángulo de base = $base y altura = $altura es = $area.<br>";

echo "<a href='index.html'>Volver</a>";
?>