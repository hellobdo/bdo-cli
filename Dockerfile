# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install core dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl

# Create a non-root user
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# Switch to non-root user
USER docker
WORKDIR /home/docker

# Clone and install bdo-cli
RUN git clone https://github.com/hellobdo/bdo-cli.git && \
    cd bdo-cli && \
    chmod +x install.sh tests/*.sh && \
    ./install.sh

# Run tests by default
CMD ["bash", "-c", "cd bdo-cli && ./tests/run-tests.sh && ./tests/test-install.sh"]