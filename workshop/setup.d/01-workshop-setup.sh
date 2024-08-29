#!/bin/bash

set -x
set -eo pipefail

jq ". + { \"editor.fontSize\": 14, \"files.exclude\": { \"**/.**\": true}}" /home/eduk8s/.local/share/code-server/User/settings.json | sponge /home/eduk8s/.local/share/code-server/User/settings.json

git clone https://github.com/timosalm/spring-petclinic-2.7 
(cd spring-petclinic-2.7 && git remote rename origin upstream && git remote add origin $GIT_PROTOCOL://$GIT_HOST/spring-petclinic && git push origin main)
rm -rf spring-petclinic-2.7