FROM node:20

# Install dependencies
RUN apt-get update && apt-get install -y postgresql-client netcat-openbsd

# Set working directory
WORKDIR /app

# Copy necessary files
COPY . .

# Copy wait-for-it script
COPY docker/wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# Install PNPM
RUN npm install -g pnpm@9.0.2

# Configure PNPM
RUN pnpm config set store-dir $HOME/.pnpm-store

# Enable corepack and prepare project dependencies
RUN corepack enable
RUN corepack prepare pnpm@latest --activate

# Remove specific line from package.json
RUN sed -i '54d' package.json

# Install project dependencies
RUN pnpm install

# Build the application
RUN pnpm run build
RUN pnpm run dts

# Expose port 3000
EXPOSE 3000

# Run migrations with wait-for-it script
WORKDIR /app/apps/builder
