FROM ruby:3.2.2

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    postgresql-client \
    libpq-dev \
    nodejs \
    yarn

RUN SYSTEM_ARCH=$(arch | sed s/aarch64/arm64/) && \
    if [ $SYSTEM_ARCH != 'arm64' ]; then \
    apt-get update && export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install --no-install-recommends chromium \
    ; fi

WORKDIR /app

COPY . .

# Install gems
RUN bundle install

# Create and migrate the database
RUN rails db:create && rails db:migrate


# Expose port 3000
EXPOSE 3000

# Start the Rails application
CMD ["rails", "s", "-b", "0.0.0.0"]