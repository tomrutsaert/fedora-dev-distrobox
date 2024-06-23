# fedora-dev-distrobox

## Creating the container

```
distrobox-create --image ghcr.io/tomrutsaert/fedora-dev-toolbox:latest \
--name dev-container \
--home $HOME/.distrobox/home/dev-container \
--additional-flags "--env REPO_USERNAME=XXXXXX" \
--additional-flags "--env REPO_PASSWORD=XXXXXX" \
--additional-flags "--env REPO_URL=https://repo.mydomain.com/artifactory/repo" \
--additional-flags "--env SONAR_URL=https://sonar.mydomain.com/" \
--additional-flags "--env AWS_ACCESS_KEY_ID=XXXXXX" \
--additional-flags "--env AWS_SECRET_ACCESS_KEY=XXXXXX" \
--additional-flags "--env AWS_REGION=eu-west-1" \
--additional-flags "--env GITLAB_NPM_ACCESS_TOKEN=XXXXXX" \
--additional-flags "--env GIT_NAME='My Name'" \
--additional-flags "--env GIT_EMAIL=mymail@test.com" \
--yes
```

execute following command `dev-box-init` to init the dev box
This will install starship, sdkman, maven, nvm, awscli , intellij