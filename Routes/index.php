<?php

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

use function Config\slimConfig;

use Tuupola\Middleware\JwtAuthentication;
use function Config\verifVencimToken;

$app = new \Slim\App(slimConfig());

$app->get('/teste', function ($request, $response, $args) {
    return $response->withJson(array(
        "teste" => "teste de rota versão 10.04.2020"
    ),200);
});

$app->run();
