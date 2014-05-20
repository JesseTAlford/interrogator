#!/bin/bash

# Exit on error
set -e

# Display Commands/dev-mode
set -x

# Verify the presence of the cli and note the version
cf --version

# Set CF to use a seperate config file 
export CF_HOME=/tmp/interrogator

# Login and target the app's space
cf api api.staging.cf-app.com
cf auth interrogator interrogator
cf target -o jesse -s jesse

# Get the app's name, instances, quota, and routes
# and store them as a text file
cf app dora > /tmp/interrogator/interrogator_cf_app.txt

# Assign them to env vars
INTERROGATOR_APP_NAME='dora'
INTERROGATOR_MANIFEST=/tmp/interrogator/$INTERROGATOR_APP_NAME-manifest.yml

# Initialize a manifest file and write the app details to it
rm $INTERROGATOR_MANIFEST
echo '---' >> $INTERROGATOR_MANIFEST
echo "name: $INTERROGATOR_APP_NAME" >> $INTERROGATOR_MANIFEST