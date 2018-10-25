ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION

ARG APP_PATH
ARG GEM_GROUPS

RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

COPY app/Gemfile $APP_PATH
RUN bundle install --with $GEM_GROUPS

COPY app $APP_PATH

RUN bundle exec rake db:migrate

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
