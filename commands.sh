#!/bin/bash
service ssh restart && bash && sudo service apache2 restart && bash
exec "$@"
