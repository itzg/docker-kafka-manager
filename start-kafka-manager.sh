#!/bin/sh

exec bin/kafka-manager -Dconfig.file=${KM_CONFIGFILE:-conf/application.conf} "$@"