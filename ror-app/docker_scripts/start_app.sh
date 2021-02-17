#!/bin/bash

sleep 30    # Espera a MySQL

rake db:create
rails db:migrate
rails db:seed

rails s