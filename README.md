# README

Enero 2024
Realizada por: giselleandrea 

## Dependencias

* Ruby version
```bash
ruby "3.1.4"
```
* Rails version
```bash
gem "rails", "~> 7.1.3"
```
* Database version
```bash
gem "mysql2", "~> 0.5"
```
Para ejecutar se debe proporcionar los datos de la base de datos de preferencia. config/database.yml

* Migration
```bash
rails db:migrate
```
* Running de app
```bash
rails server
```
Por defecto en ambiente dev esta en el puerto 3000. http://localhost:3000

* How to run the test suite
```bash
rails test
```

* ...

## cURL productos 

curl --location --request GET 'http://localhost:3000/products'

curl --location --request GET 'http://localhost:3000/product/1'

curl --location --request POST 'http://localhost:3000/new_product' \
--header 'Content-Type: application/json' \
--data-raw '{
  "product": {
    "name": "Producto 4",
    "price": 5000,
    "quantity": 80
  }
}'

curl --location --request PUT 'http://localhost:3000/update_product/4' \
--header 'Content-Type: application/json' \
--data-raw '{
  "product": {
    "name": "Producto editado 4",
    "price": 5000,
    "quantity": 80
  }
}'

curl --location --request DELETE 'http://localhost:3000/delete_product/2'

## cURL Clientes 

curl --location --request GET 'http://localhost:3000/customers'

curl --location --request GET 'http://localhost:3000/customer/1'

curl --location --request POST 'http://localhost:3000/new_customer' \
--header 'Content-Type: application/json' \
--data-raw '{
    "customer": {
        "name": "Cliente 1",
        "email": "Cliente@test.com",
        "phone": "1234567891",
        "address": "Calle 123"
        "user_id": 1
    }
}'

curl --location --request PUT 'http://localhost:3000/update_customer/1' \
--header 'Content-Type: application/json' \
--data-raw '{
    "customer": {
        "name": "Cliente 1",
        "email": "Cliente@test.com",
        "phone": "1234567891",
        "address": "Calle 123 456"
    }
}'

curl --location --request DELETE 'http://localhost:3000/delete_customer/2'

## cURL Ordenes

curl --location --request POST 'http://localhost:3000/new_order' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.sI9Rj4tf8RoC6tfa_TNbY6hxz5bRH_Pjsb60qJcc_Dw' \
--header 'Content-Type: application/json' \
--data-raw '{
  "order": {
    "order_has_products_attributes": [
      {
        "product_id": 1,
        "cant": 2
      },
      {
        "product_id": 3,
        "cant": 1
      }
    ]
  }
}'

## cURL Users


curl --location --request POST 'http://localhost:3000/new_user' \
--header 'Content-Type: application/json' \
--data-raw '{
    "user": {
        "name": "usuario 1",
        "email": "usuario1@test.com",
        "username": "usuariox",
        "password": "123456789",
        "role": "user"
    }
}'

curl --location --request POST 'http://localhost:3000/auth/login' \
--form 'email="usuario1@test.com"' \
--form 'password="123456789"'

curl --location --request GET 'http://localhost:3000/users' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.sI9Rj4tf8RoC6tfa_TNbY6hxz5bRH_Pjsb60qJcc_Dw'
