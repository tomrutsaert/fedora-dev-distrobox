# fedora-dev-distrobox

Personal development distrobox container with awscli, git, starship installed.
Has script to init the dev env and to isntall intellij in the container and distrobox expose it

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

execute following command `install-dev-env` to install the dev environment, (git config, sdkman, nvm, mvn, ...)
execute following command `install-intellij` to install intellij
after the scripts have ran, It could be necessary to execute `source $HOME/.bashrc` or to relogin
