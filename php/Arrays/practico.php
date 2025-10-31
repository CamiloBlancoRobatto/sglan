<?php
//Crear un array multidimensional de 3 productos con nombre, precio y stock, recorrerlo con foreach y mostrar los datos.
$productos = [
    ["nombre" => "Camisa", "precio" => 990, "stock" => 15],
    ["nombre" => "Pantalón", "precio" => 2700, "stock" => 8],
    ["nombre" => "Zapatos", "precio" => 1500, "stock" => 20]
];

foreach ($productos as $producto) {
    echo $producto["nombre"] . " = " . $producto["precio"]. "$ ". $producto["stock"] . " Unidades en Stock\n";
}

//Usar array_filter para devolver solo productos cuyo stock sea mayor a 10.
$disponibles = array_filter($productos, function($p) {
    return $p["stock"] > 10;
});

echo "\nProductos con stock mayor a 10:\n";
foreach ($disponibles as $producto) {
    echo $producto["nombre"] . ", Stock:". $producto["stock"] . "\n";
}

//Usar array_map para aplicar un 10% de descuento a todos los precios.
$descuentos = array_map(function($p) {
    $p["precio"] *= 0.9;
    return $p;
}, $productos);

echo "\nProductos con 10% de descuento:\n";
foreach ($descuentos as $producto){
    echo $producto["nombre"] . ", Precio con descuento: " . $producto["precio"] . "$\n";
}
?>