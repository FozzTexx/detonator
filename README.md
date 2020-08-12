Detonator - a fireworks ignition controller  
Copyright 2015 by Chris Osborn <fozztexx@fozztexx.com>  

This is a simple web based interface that runs on a Raspberry Pi to
control relays through GPIO. I used it to set off fireworks over WiFi
from my iPhone.

You can read more about the setup at http://insentricity.com/a.cl/243

Before you do anything make sure that fireworks.py is controlling your
relays. If that's not working for you then nothing else will. After
you get that working then you can compile the web interface inside of
a docker container.

To build you'll need docker and docker-compose. Then just do

    make

To run it, type

    docker-compose up

then go to http://localhost:1776 in a web browser
