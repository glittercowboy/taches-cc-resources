# Ralph Wiggum Loop - Docker Container
# Runs Claude Code CLI in isolated environment as non-root user

FROM node:22-slim

# Install system dependencies
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Install Claude Code CLI globally
RUN npm install -g @anthropic-ai/claude-code

# Create non-root user for safety
# Claude blocks --dangerously-skip-permissions for root users
RUN useradd -m -s /bin/bash ralph && \
    mkdir -p /workspace && \
    chown ralph:ralph /workspace

# Switch to non-root user
USER ralph

# Set working directory
WORKDIR /workspace

# Configure git for commits (will be overwritten by mount)
RUN git config --global user.email "ralph@autonomous.ai" && \
    git config --global user.name "Ralph Wiggum"

# Default command
CMD ["bash"]
