#!/bin/bash
set -e

ENV=$1

if [ -z "$ENV" ]; then
  echo "Usage: ./deploy.sh <dev|qa|prod>"
  exit 1
fi

case "$ENV" in
  dev)
    TARGET_HOST="3dexp-dev.example.com"
    ;;
  qa)
    TARGET_HOST="3dexp-qa.example.com"
    ;;
  prod)
    TARGET_HOST="prod-qa.company.com"
    ;;
  *)
    echo "Invalid environment"
    exit 1
    ;;
esac

DEPLOY_USER="deploy"
ARTIFACT="/opt/jenkins/data/workspace/app.war"
REMOTE_DIR="/opt/plm/3dexp/apps/3dpassport/linux_a64/code/tomee/webapps"

echo "Deploying $ARTIFACT to $TARGET_HOST"

scp -o StrictHostKeyChecking=no \
"$ARTIFACT" ${DEPLOY_USER}@${TARGET_HOST}:${REMOTE_DIR}/

ssh -o StrictHostKeyChecking=no ${DEPLOY_USER}@${TARGET_HOST} <<EOF
  sudo systemctl stop tomcat
  sleep 5
  sudo systemctl start tomcat
EOF

echo "Deployment successful for $ENV"
