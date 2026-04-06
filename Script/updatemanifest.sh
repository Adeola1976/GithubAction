
#!/bin/bash

set -x

# Set the repository URL
git config --global user.email $EMAIL
git config --global user.name $EMAIL
REPO_URL="https://x-access-token:$TOKEN@github.com/Adeola1976/GithubAction.git"
git remote set-url origin "$REPO_URL"
echo "Token length: ${#TOKEN}."

# Clone the git repository into the /tmp directory
git clone "$REPO_URL" /tmp/temp_repo

# Navigate into the cloned repository directory
cd /tmp/temp_repo

# Make changes to the Kubernetes manifest file(s)
# For example, let's say you want to change the image tag in a deployment.yaml file
sed -i "s|image:.*|image:$REGISTER_NAME/$REPO_NAME:$BUILD_ID|g" K8S/$REPO_NAME-depolyment.yaml

# Add the modified files
git add .

# Commit the changes
git commit -m "Update Kubernetes manifest"

# Push the changes back to the repository
git push

# Cleanup: remove the temporary directory
rm -rf /tmp/temp_repo
