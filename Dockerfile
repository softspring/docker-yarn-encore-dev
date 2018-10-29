FROM debian:latest

# update and install all required packages (no sudo required as root)
# https://gist.github.com/isaacs/579814#file-only-git-all-the-way-sh
RUN apt-get update -yq && apt-get upgrade -yq && \
    apt-get install -yq curl git nano sudo gnupg

# install nodejs
# RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && sudo apt-get install -y nodejs
RUN curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash - && \
    sudo apt-get install -y nodejs npm

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    sudo apt-get update -yq && sudo apt-get install --no-install-recommends -y yarn

RUN apt-get update -yq && apt-get upgrade -yq && \
    apt-get install -yq sudo

ARG USER_NAME
ARG UID

RUN echo $USER_NAME && \
    useradd --uid $UID -g users $USER_NAME && \
    mkdir -p /home/$USER_NAME && \
    chown $USER_NAME /home/$USER_NAME && \
    chgrp users /home/$USER_NAME && \
    echo "$USER_NAME ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash", "/app/vendor/softspring/docker-yarn-encore-dev/startup.sh"]