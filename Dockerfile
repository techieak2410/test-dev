# -------------------------
# STAGE 1 — Build the App
# -------------------------
FROM node:22-alpine AS build

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source and build
COPY . .
RUN npm run build


# -------------------------
# STAGE 2 — Run with Nginx
# -------------------------
FROM nginx:1.27-alpine

# Copy your custom Nginx config (optional)
# Make sure the file exists next to this Dockerfile
COPY nginx.conf /etc/nginx/nginx.conf

# Copy built app from build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Expose default Nginx port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

