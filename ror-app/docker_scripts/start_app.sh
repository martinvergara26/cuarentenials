#!/bin/bash

sleep 30    # Espera a MySQL

rake db:create
rails db:migrate
rails db:seed

rails s -p 3000 -b '0.0.0.0'