#!/bin/sh

OWASPDC_DIRECTORY=$HOME/OWASP-Dependency-Check
DATA_DIRECTORY="$OWASPDC_DIRECTORY/data"
REPORT_DIRECTORY="$OWASPDC_DIRECTORY/reports"

if [ ! -d "$DATA_DIRECTORY" ]; then
    echo "Initially creating persistent directories"
    mkdir -p "$DATA_DIRECTORY"
    chmod -R 777 "$DATA_DIRECTORY"

    mkdir -p "$REPORT_DIRECTORY"
    chmod -R 777 "$REPORT_DIRECTORY"
fi

# Make sure we are using the latest version
docker pull owasp/dependency-check

echo "HELO WORLD1"

docker run --rm \
    -e user=$USER \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    --volume $(pwd):/src:z \
    --volume "$DATA_DIRECTORY":/usr/share/dependency-check/data:z \
    --volume $(pwd)/odc-reports:/report:z \
    owasp/dependency-check:latest \
    --scan /src \
    --format "ALL" \
    --project "My OWASP Dependency Check Project" \
    --out /report
    
    echo "HELO WORLD2"
