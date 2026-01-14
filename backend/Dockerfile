# Use a small, secure base image
FROM node:20-alpine

# Create app directory
WORKDIR /app

# Copy package files first (better Docker layer caching)
COPY package*.json ./

# Install production dependencies only
RUN npm ci --omit=dev

# Copy the rest of the source
COPY . .

# Your app listens on 3000 (change if needed)
EXPOSE 5001

# Start the server
CMD ["node", "server.js"]
