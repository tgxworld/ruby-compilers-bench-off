FROM ubuntu:14.04
MAINTAINER Guo Xiang "tgx_world@hotmail.com"

RUN apt-get update
RUN apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev git curl python-software-properties software-properties-common ruby-full

RUN git clone --branch ruby_2_2 --single-branch --depth 1 https://github.com/ruby/ruby.git
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc

# Install compilers and compile respective Ruby
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update
ADD config.sub /ruby/tool/config.sub
ADD config.guess /ruby/tool/config.guess

RUN apt-get install -y g++-4.6
RUN cd ruby && autoconf && ./configure --prefix=/root/.rbenv/versions/ruby-2.2.0-gcc-4.6 --disable-install-doc --with-gcc=gcc-4.6 && make && make install

RUN apt-get install -y g++-4.7
RUN cd ruby && autoconf && ./configure --prefix=/root/.rbenv/versions/ruby-2.2.0-gcc-4.7 --disable-install-doc --with-gcc=gcc-4.7 && make && make install

RUN apt-get install -y g++-4.8
RUN cd ruby && autoconf && ./configure --prefix=/root/.rbenv/versions/ruby-2.2.0-gcc-4.8 --disable-install-doc --with-gcc=gcc-4.8 && make && make install

RUN apt-get install -y g++-4.9
RUN cd ruby && autoconf && ./configure --prefix=/root/.rbenv/versions/ruby-2.2.0-gcc-4.9 --disable-install-doc --with-gcc=gcc-4.9 && make && make install

RUN apt-get install -y clang-3.3
RUN cd ruby && autoconf && ./configure --prefix=/root/.rbenv/versions/ruby-2.2.0-clang-3.3 --disable-install-doc --with-gcc=clang && make && make install

RUN apt-get install -y clang-3.4
RUN cd ruby && autoconf && ./configure --prefix=/root/.rbenv/versions/ruby-2.2.0-clang-3.4 --disable-install-doc --with-gcc=clang && make && make install

RUN apt-get install -y clang-3.5
RUN cd ruby && autoconf && ./configure --prefix=/root/.rbenv/versions/ruby-2.2.0-clang-3.5 --disable-install-doc --with-gcc=clang && make && make install

ADD runner runner
RUN chmod 755 runner

CMD /bin/bash -l -c "./runner"
