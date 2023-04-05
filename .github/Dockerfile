FROM ruby:2.5.3

EXPOSE 3000
ENV APP /app

RUN sed -i '2d' /etc/apt/sources.list
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y build-essential libpq-dev mysql-client nodejs yarn jpegoptim cmake
RUN gem update --system "3.3.26"
RUN gem install bundler -v "2.0.2"
RUN mkdir $APP

WORKDIR $APP

ADD Gemfile* $APP/
RUN bundle install --path /usr/local/vendor/bundler -j4

ADD package.json $APP
ADD yarn.lock $APP
RUN NODE_ENV=development yarn install
RUN apt-get remove -y --purge build-essential

ADD . $APP
