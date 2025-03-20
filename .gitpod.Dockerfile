FROM gitpod/workspace-postgres

# Install Ruby
USER gitpod
RUN curl -sSL https://get.rvm.io | bash
RUN bash -lc "rvm install 3.2.2 && rvm use 3.2.2 --default"

# Install Rails
RUN bash -lc "gem install rails bundler webdrivers -N"

# Install Node.js and Yarn
RUN bash -c ". ~/.nvm/nvm.sh && nvm install --lts"
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update && sudo apt-get install -y yarn

# Additional dependencies for Rails
RUN sudo apt-get update && sudo apt-get install -y \
    libpq-dev \
    redis-server \
    imagemagick \
    libvips-dev 