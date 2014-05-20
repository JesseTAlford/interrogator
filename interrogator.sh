#!/bin/bash

# Exit on error
set -e

# Display Commands/dev-mode
set -x

# Verify the presence of the cli and note the version
cf --version

# Set CF to use a seperate config file 
export CF_HOME=/tmp/

# Login and target the app's space
cf api api.staging.cf-app.com
cf auth interrogator interrogator
cf target -o jesse -s jesse

# Get the app's name, instances, quota, and routes
# cf app dora