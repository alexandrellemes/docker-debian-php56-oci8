<?php

$conn = pg_connect("host=postgresdb port=5432 user=postgres password=123456");

// Verifica a conexão
if ($conn == false) {
    die("Não foi possível conectar ao banco: " . pg_errormessage($conn));
} else {
    pg_close($conn);
    echo 'Acesso ao banco POSTGRESQL - OK.';
}
