<?php

// Cria uma conexão com o servidor.
$conn = mysqli_connect('mysqldb', 'root', '123456');

// Verifica a conexão
if ($conn == false) {
    die("Não foi possível conectar ao banco: " . mysqli_connect_error());
} else {
    mysqli_close($conn);
    echo 'Acesso ao banco MYSQL - OK.';
}
