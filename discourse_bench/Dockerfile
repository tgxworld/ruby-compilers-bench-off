FROM tgxworld/ruby_compilers_base
MAINTAINER Guo Xiang "tgx_world@hotmail.com"

# Required for Discourse bench
RUN apt-get install -y wget postgresql-client apache2-utils postgresql-client libffi-dev libpq-dev
RUN git clone --verbose --branch stable --single-branch --depth 1 https://github.com/ruby-bench/discourse.git

ADD database.yml database.yml
ADD discourse.conf discourse.conf
ADD discourse_profile.dump discourse_profile.dump
ADD cache cache
ADD runner runner
RUN chmod 755 runner

CMD /bin/bash -l -c "./runner"
