#!/bin/bash

HUB_HOST_FINAL="${HUB_HOST:-hub}"
BROWSER_FINAL="${BROWSER:-chrome}"
THREAD_COUNT_FINAL="${THREAD_COUNT:-1}"
SUITE_PATH="test-suites/${TEST_SUITE}"

# Let's print what we have received
echo "-------------------------------------------"
echo "HUB_HOST      : ${HUB_HOST_FINAL}"
echo "BROWSER       : ${BROWSER_FINAL}"
echo "THREAD_COUNT  : ${THREAD_COUNT_FINAL}"
echo "TEST_SUITE    : ${TEST_SUITE}"
echo "-------------------------------------------"

# 2. Verificar si el archivo de Test Suite existe
if [ ! -f "$SUITE_PATH" ]; then
    echo "**** ERROR: Test suite file not found at $SUITE_PATH ****"
    exit 1
fi

# Do not start the tests immediately. Hub has to be ready with browser nodes
echo "Checking if hub is ready at http://${HUB_HOST_FINAL}:4444/status...!"
count=0
while [ "$( curl -s http://${HUB_HOST_FINAL}:4444/status | jq -r .value.ready )" != "true" ]
do
  ((count++)) # Uso de aritmética concisa
  echo "Attempt: ${count}"
  if [ "$count" -ge 30 ]
  then
      echo "**** HUB IS NOT READY WITHIN 30 SECONDS ****"
      exit 1
  fi
  sleep 1
done

# At this point, selenium grid should be up!
echo "Selenium Grid is up and running. Running the test from $SUITE_PATH...."

# Start the java command
java -cp 'libs/*' \
     -Dselenium.grid.enabled=true \
     -Dselenium.grid.hubHost="${HUB_HOST_FINAL}" \
     -Dbrowser="${BROWSER_FINAL}" \
     org.testng.TestNG \
     -threadcount "${THREAD_COUNT_FINAL}" \
     "$SUITE_PATH"
