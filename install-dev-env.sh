#!/bin/bash

cd $HOME

#git
git config --global user.name "${GIT_NAME}"
git config --global user.email "${GIT_EMAIL}"
git config --global push.autoSetupRemote true

#prep
sudo rm -rf $HOME/.cache

#sdkman
mkdir -p /tmp/sdkman
cd /tmp/sdkman
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version
sed -i 's/sdkman_auto_env=false/sdkman_auto_env=true/g' $HOME/.sdkman/etc/config

#maven
mkdir -p $HOME/.m2
cat << EOF > $HOME/.m2/settings.xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.2.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.2.0 https://maven.apache.org/xsd/settings-1.2.0.xsd">
  <servers>
    <server>
      <id>shared-services-artifactory</id>
      <username>${REPO_USERNAME}</username>
      <password>${REPO_PASSWORD}</password>
    </server>
  </servers>
  <mirrors>
    <mirror>
      <id>shared-services-artifactory</id>
      <name>Shared Services Artifactory</name>
      <url>${REPO_URL}</url>
      <mirrorOf>*</mirrorOf>
    </mirror>
  </mirrors>
  <profiles>
    <profile>
      <id>sonar</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <properties>
        <sonar.host.url>${SONAR_URL}</sonar.host.url>
      </properties>
    </profile>
  </profiles>
</settings>
EOF
sdk install maven

#nvm
mkdir -p /tmp/nvm && cd /tmp/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source $HOME/.bashrc
nvm install --latest-npm
nvm alias default $(node --version)
npm --version
npm config set '//gitlab.com/api/v4/packages/npm/:_authToken' "${GITLAB_NPM_ACCESS_TOKEN}"
