#!/usr/bin/env bash

cd /opt/tectonicus

xvfb-run ./bin/tectonicus --useEGL -c /config.xml -j /minecraft.jar

