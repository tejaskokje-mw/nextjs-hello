# Use the official Bun slim image (version 1.1.31)
FROM oven/bun:1.1.31-debian

# Set the working directory inside the container
WORKDIR /app

# Install required build tools, curl, and Node.js 20
# Node.js 20 is required for pprof, which is used for middleware profiling
RUN apt-get update && \
    apt-get install -y python3 make g++ curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Copy package.json and bun.lockb (if available) to install dependencies
# This ensures Docker can cache the dependency installation step
COPY ./package.json bun.lockb* ./

# Add ARGs for build-time variables
ARG NEXT_PUBLIC_POSTHOG_KEY
ARG MW_API_KEY
ARG MW_TARGET

# Set environment variables for both build and runtime
ENV MW_API_KEY=${MW_API_KEY}
ENV MW_TARGET=${MW_TARGET}

# Install dependencies using Bun
RUN bun install

# Copy the rest of your application code into the container
# If only the application code changes (not package.json or bun.lockb), Docker will reuse the cached layer above
COPY . .

# Build the Next.js application using Bun
RUN bun run build

# Expose port 3000 for the Next.js web service
EXPOSE 3000

# Start the application
CMD ["bun", "run", "start"]