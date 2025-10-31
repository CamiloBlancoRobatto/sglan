<?php
//Solicite dos números.
$num1 = $_POST['num1'];
$num2 = $_POST['num2'];

//Muestre:
//La suma, resta, multiplicación y división de los números.
echo "El primer numero es $num1 y el segundo es $num2.<br>";
echo "la suma es = " . $num1 + $num2 . ".<br>La resta es = " . $num1 - $num2 . ".<br>La multiplicación es = " . $num1 * $num2 . ".<br>La divición es = " . $num1 / $num2 . ".<br>";

//Si son iguales o diferentes (usando == y ===).
if($num1 == $num2){
    echo "El primer y el segundo número son iguales.<br>";
} else{
    echo "El primer y el segundo número son diferentes.<br>";
}

//Un mensaje personalizado si la suma es mayor a 100, usando operador ternario.
$mensaje = ($num1+$num2 > 100) ? "La suma de sus numeros es mayor a 100.<br>" : "La suma de sus numeros es menor o igual a 100.<br>";
echo $mensaje;

echo "<a href='index.html'>Volver</a>";
?>