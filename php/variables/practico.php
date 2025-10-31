<?php
//a) Declarar una variable con tu nombre y mostrarla por pantalla.
$mi_nombre = "Brayan";
echo "Mi nombre es " . $mi_nombre . ".<br>";

//b) Crear dos variables numéricas y mostrar la suma, resta, multiplicación y división.
$num1 = 13;
$num2 = 25;
echo "El primer numero es " . $num1 . " y el segundo es " . $num2 . ".<br>";
echo "la suma es = " . $num1 + $num2 . ".<br>La resta es = " . $num1 - $num2 . ".<br>La multiplicación es = " . $num1 * $num2 . ".<br>La divición es = " . $num1 / $num2 . ".<br>";

//c) Crear un array con tus tres comidas favoritas y mostrar la segunda.
$comidas = ["Hamburguezas", "Pizzas", "Panchos"];
echo "Mi segunda comida favorita es " . $comidas[1] . ".<br>";

//d) Crear una variable booleana llamada $es_estudiante y mostrar su valor.
$es_estudiante = false;
if($es_estudiante == true){
    echo "Si es estudiante.<br>";
}else{
    echo "No es estudiante.<br>";
};

?>