FROM ubuntu:16.04

ENV RVM_DEPS="bzip2 gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev \
 libyaml-dev libsqlite3-dev sqlite3 libgmp-dev libgdbm-dev libncurses5-dev automake libtool bison libffi-dev"

RUN \
    apt-get update && \
    apt-get install -y curl $RVM_DEPS && \

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -sSL https://get.rvm.io | bash -s stable --ruby && \

    # Clean up APT when done.
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN \
    groupadd -r newrelic && \
    useradd -g newrelic -ms /bin/bash plugindev && \
    usermod -aG rvm plugindev

USER plugindev

RUN ["/bin/bash", "-lc", "\
    rvm install 2.3 && \
    rvm use ruby-2.3.0 && \
    rvm rubygems latest && \
    gem install bundle \
"]

WORKDIR /home/plugindev

ENV RELEASE="0.2"
RUN curl -sSL "https://github.com/ilons/newrelic_varnish_plugin/archive/v${RELEASE}.tar.gz" | tar zxvz

RUN ["/bin/bash", "-lc", "\
    ruby --version && \
    cd newrelic_varnish_plugin-${RELEASE} && \
    bundle install \
"]
