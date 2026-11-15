# Use the base `Ubuntu` image.
FROM base-ubuntu

# Switch to the `root` user for the installation.
USER root

# Install `R` and its development libraries.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        r-base \
        r-base-dev \
    && rm -rf /var/lib/apt/lists/*

# Switch back to the `vscode` user for user-owned tooling.
USER vscode

# Specify a writable `R` package library.
ENV R_LIBS_USER=/home/vscode/R/library

# Create the user-owned `R` package library directory.
RUN mkdir -p "${R_LIBS_USER}"

# Install `arf` without modasdifying shell startup files.
RUN curl -LsSf "https://github.com/eitsupi/arf/releases/latest/download/arf-console-installer.sh" -o /tmp/install-arf.sh \
    && ARF_CONSOLE_INSTALL_DIR="${HOME}/.local" ARF_CONSOLE_NO_MODIFY_PATH=1 sh /tmp/install-arf.sh \
    && rm /tmp/install-arf.sh \
    && arf --version
