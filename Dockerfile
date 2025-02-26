# Step 1: Build the React app
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install --legacy-peer-deps

# Copy the rest of the application files
COPY . .

# Build the React app
RUN npm run build

# Step 2: Serve with Nginx
FROM nginx:latest

# Copy built React files to Nginx public folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
