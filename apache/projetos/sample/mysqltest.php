<?php

$mysqli = new mysqli("mysqldb", "root", "123456", "mysql");

/* change character set to utf8 */
if (!$mysqli->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $mysqli->error);
    exit();
} else {
    printf("Current character set: %s\n", $mysqli->character_set_name());
}

// Cria uma conexão com o servidor.
$conn = mysqli_connect('mysqldb', 'root', '123456');
mysqli_set_charset($conn, "utf8");

// Verifica a conexão
if ($conn == false) {
    die("Não foi possível conectar ao banco: " . mysqli_connect_error());
} else {
    mysqli_close($conn);
    echo PHP_EOL . '<br>Acesso ao banco MYSQL - OK.';
}
