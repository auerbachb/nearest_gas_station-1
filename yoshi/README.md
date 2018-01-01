# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Rails 5.1.4

* enable cache
  <br>
  rails dev:cache

* go to localhost:3000/singup create a new account first. "name email password password_confirmation" are needed 
  <br>
  Example: curl --data "name=xxx&email=xxx@email.com&password=xxx&password_confirmation=xxx" "http://localhost:3000/signup"
* go to localhost:3000/auth/login with email and password to get token
  <br>
  Example: curl --data "email=qwe@email.com&password=foo" "http://localhost:3000/auth/login"
* send get request to localhost:3000/nearest_gas with token to get response
   <br>
  Example: curl -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MTQ4NTk2NjB9.UtqXIXobHzIMNOwi7MsUCbA-cecrifSyL6fkUq2IP-0" -X GET "http://localhost:3000/nearest_gas?lat=37.77801&lng=-122.4119076"

