# EcoBoard Project

Projet d'un site web pour purecontrol, qui à pour fonctionnalitée principale de proposer des graphiques de consommation d'énergie.

## Déployement 

### Importation de BDD

Importer la fichier BDD.sql sur votre serveur de base de données.

Modifiez les paramêtres de BDD dans le fichier ./ecoboard_back/routes/bdd/informations.json : 

```
{
  "BDD_HOST" : "<BDD_HOST>",
  "BDD_USERNAME" : "<BDD_USERNAME>",
  "BDD_PASSWORD" : "<BDD_PASSWORD>",
  "BDD_DATABASE" : "<BDD_DATABASE_NAME>",

  "INFLUX_HOST" : "<INFLUX_HOST>",
  "INFLUX_USERNAME" : "<INFLUX_USERNAME>",
  "INFLUX_PASSWORD" : "<INFLUX_PASSWORD>",
  "INFLUX_DATABASE" : "<INFLUX_DATABASE_NAME>",
  "INFLUX_MEASUREMENT" : "<INFLUX_MEASUREMENT>",

  "TOKEN_PASSWORD" : "<TOKEN_FOR_PASSWORD_FOR_SESSIONS_TOKENS>",
  "TOKEN_EMAIL_PASSWORD" : "<TOKEN_FOR_PASSWORD_FOR_EMAIL_TOKENS>",
  "SERVER_PORT" : <SERVER_PORT>,
  "CARBONE_INFLUX_DATA" : "<EQUIPEMENT_NAME_FOR_CARBONE>",
  
  "ADDRESS_FOR_VALIDATION_EMAIL": "<URL_FOR_VALIDATION_EMAIL>",
  "ADDRESS_FOR_CHANGEMENT_PASSWORD": "<URL_FOR_CHANGEMENT_PASSWORD>",
  "ADDRESS_TO_EMAIL_SERVICES": "<URL_FOR_EMAIL_WEBSERVICES>",
  "ENTREPRISE_EMAIL_RECEIVER" : "<EMAIL_TO_SEND_NEW_ENTREPRISE>"
}
```

### Gestion des contrats pdf

Emplacement des pdf de vérification des compteurs : ./ecoboard_back/contrats
Penser à le sortir du docker

### Gestion des certificats SSL enedis

Emplacement des pdf de vérification des compteurs : ./ecoboard_back/routes/bdd/certificats_enedis
Penser à les modifier par les votres

### Génération de image Docker

Dans la racine du git éxécuté cette commande pour construire le container Docker :

```
$ docker build . --tag="ecoboard_app"
```

## Démarage du container Docker

Dans la racine du git éxécuté cette commande pour démarer le container Docker :

```
$ docker run --name ecoboard_app ecoboard_app
```

```
environment:
  - BDD_HOST=<BDD_HOST>
  - BDD_USERNAME=<BDD_USERNAME>
  - BDD_PASSWORD=<BDD_PASSWORD>
  - BDD_DATABASE=<BDD_DATABASE_NAME>
  - INFLUX_HOST=<INFLUX_HOST>
  - INFLUX_USERNAME=<INFLUX_USERNAME>
  - INFLUX_PASSWORD=<INFLUX_PASSWORD>
  - INFLUX_DATABASE=<INFLUX_DATABASE_NAME>
  - INFLUX_MEASUREMENT=<INFLUX_MEASUREMENT>
  - TOKEN_PASSWORD=<TOKEN_FOR_PASSWORD_FOR_SESSIONS_TOKENS>
  - TOKEN_EMAIL_PASSWORD=<TOKEN_FOR_PASSWORD_FOR_EMAIL_TOKENS>
  - CARBONE_INFLUX_DATA=<EQUIPEMENT_NAME_FOR_CARBONE>
  - ADDRESS_FOR_VALIDATION_EMAIL=<URL_FOR_VALIDATION_EMAIL>
  - ADDRESS_FOR_CHANGEMENT_PASSWORD=<URL_FOR_CHANGEMENT_PASSWORD>
  - ADDRESS_TO_EMAIL_SERVICES=<URL_FOR_EMAIL_WEBSERVICES>
  - ENTREPRISE_EMAIL_RECEIVER=<EMAIL_TO_SEND_NEW_ENTREPRISE>
```