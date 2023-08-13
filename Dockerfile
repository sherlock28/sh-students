FROM debian:buster-slim as base
RUN apt-get update \
    && apt-get install --no-install-recommends -y curl=7.64.0-4+deb10u6 ca-certificates=20200601~deb10u2 \
    && rm -rf /var/lib/apt/lists/*
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl https://get.volta.sh | bash -s -- --version 1.1.1
ENV PATH="/root/.volta/bin:${PATH}"

FROM base as deps
WORKDIR /usr/app
COPY package*.json ./
RUN volta install node
RUN npm ci

FROM deps as prod
WORKDIR /usr/app
COPY .env ./
COPY src ./src
COPY --from=deps /usr/app .
RUN npm install pm2 -g
EXPOSE 5000
# ENTRYPOINT ["tail", "-f", "/dev/null"]
CMD ["pm2-runtime","./src/index.js"]
