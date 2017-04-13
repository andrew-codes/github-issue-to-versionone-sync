FROM risingstack/alpine:3.4-v6.7.0-4.0.0

WORKDIR /opt/app

# Install yarn
RUN mkdir -p /opt
ADD yarn-v0.21.3.tar.gz /opt/
RUN mv /opt/dist /opt/yarn
ENV PATH "$PATH:/opt/yarn/bin"

ADD package.json yarn.lock /tmp/

# Copy cache contents (if any) from local machine
ADD .yarn-cache.tgz /

# Install packages
RUN cd /tmp && yarn --production --force
RUN mkdir -p /opt/app && cd /opt/app && ln -s /tmp/node_modules

# Copy the code
ADD ./dist /opt/app
ENV PORT 3001
ENV NODE_ENV production
EXPOSE $PORT
CMD ["node", "server/index.js"]
