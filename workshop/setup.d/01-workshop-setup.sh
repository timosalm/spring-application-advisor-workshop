#!/bin/bash

set -x
set -eo pipefail

jq ". + { \"editor.fontSize\": 14, \"git.enableSmartCommit\": true, \"files.exclude\": { \".**\": true}}" /home/eduk8s/.local/share/code-server/User/settings.json | sponge /home/eduk8s/.local/share/code-server/User/settings.json

(cd /opt/git/repositories && git clone --bare https://github.com/timosalm/spring-petclinic-2.7 spring-petclinic && echo ".advisor" >> .gitignore)