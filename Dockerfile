# Start from the official Node.js LTS release
FROM node:lts

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy local code to the container image
COPY . .

# Declare all environment variables as build args
ARG NEXTAUTH_SECRET
ARG NEXTAUTH_URL
ARG GOOGLE_CLIENT_ID
ARG GOOGLE_CLIENT_SECRET
ARG DATABASE_URL
ARG OPENAI_API_KEY
ARG REDIS_URL
ARG REDIS_SECRET

# Now set these build args as environment variables
ENV NEXTAUTH_SECRET=$NEXTAUTH_SECRET
ENV NEXTAUTH_URL=$NEXTAUTH_URL
ENV GOOGLE_CLIENT_ID=$GOOGLE_CLIENT_ID
ENV GOOGLE_CLIENT_SECRET=$GOOGLE_CLIENT_SECRET
ENV DATABASE_URL=$DATABASE_URL
ENV OPENAI_API_KEY=$OPENAI_API_KEY
ENV REDIS_URL=$REDIS_URL
ENV REDIS_SECRET=$REDIS_SECRET

# Build the application
RUN npm run build
RUN npm run postinstall

# Expose the application on port 3000
EXPOSE 3000

# Start the application
CMD [ "npm", "start" ]
