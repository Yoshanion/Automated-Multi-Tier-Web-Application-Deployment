# Use an official Node.js runtime as a parent image
FROM node:16-alpine

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) first to leverage Docker cache
COPY ../../app/front-end/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY ../../app/front-end/ .

# Build the app (uncomment the following line if you are using a framework like React that needs building)
# RUN npm run build

# Start the app
CMD ["npm", "start"]