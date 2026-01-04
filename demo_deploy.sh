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

ARTIFACT="/opt/jenkins/plm/3dexp/devops_updates"
REMOTE_DIR="/opt/plm/3dexp/apps/3dpassport/linux_a64/code/tomee/bin"

echo "Deploying $ARTIFACT to $TARGET_HOST"

scp $ARTIFACT deploy@$TARGET_HOST:$REMOTE_DIR/

ssh deploy@$TARGET_HOST << EOF
  sudo systemctl stop tomcat
  sleep 5
  sudo systemctl start tomcat
EOF

echo "Deployment successful for $ENV"
