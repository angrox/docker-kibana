#!/bin/sh

set -e

KIBANA_CONF_FILE="/opt/kibana-${KIBANA_VERSION}/config/kibana.yml"

KIBANA_ES_URL=${KIBANA_ES_URL:-http://elasticsearch:9200}

# Dirty hack: The complete file has no uncommented line, so we write it new
echo "# File written by run.sh" > ${KIBANA_CONF_FILE}
echo "server.host: 0.0.0.0" >> ${KIBANA_CONF_FILE}
echo "elasticsearch.url: ${KIBANA_ES_URL}" >> ${KIBANA_CONF_FILE}

if [ -n "${KIBANA_INDEX}" ]; then
    echo "setting index!"
    echo "kibana.index: ${KIBANA_INDEX}" >> ${KIBANA_CONF_FILE}
fi

# mesos-friendly change
unset HOST
unset PORT

exec /opt/kibana-${KIBANA_VERSION}/bin/kibana
