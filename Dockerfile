FROM node:16-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the Svelte app
RUN npm run build

FROM node:16-alpine
COPY --from=0 /app .
COPY . .

EXPOSE 3000
# Specify the command to run when the container starts
CMD [ "node", "./build" ]