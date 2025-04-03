FROM node:22-bullseye

# Install Chrome dependencies (keep this section)
RUN apt-get update && \
    apt-get install -y \
    chromium \
    fonts-liberation \
    libgbm1 \
    libxss1 \
    && rm -rf /var/lib/apt/lists/*

# Environment variables
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV DISPLAY=:99

WORKDIR /app

# Copy npm files instead of yarn
COPY package.json package-lock.json ./

# Install using npm
RUN npm ci --production

COPY . .

RUN mkdir -p .wwebjs_auth .wwebjs_cache

CMD ["node", "./index.js"]
EXPOSE 3000
