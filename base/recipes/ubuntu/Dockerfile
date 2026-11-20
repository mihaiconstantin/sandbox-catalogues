# Stable `Ubuntu` development image.
FROM mcr.microsoft.com/devcontainers/base:ubuntu26.04

# Switch to the `root` user.
USER root

# Set `zsh` as the default login shell for the developer account.
RUN usermod -s /usr/bin/zsh vscode

# Install the system dependencies for the development environment.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        git \
        gpg \
        gpg-agent \
        tmux \
        pkg-config \
        fontconfig \
        python3 \
        python3-venv \
        python3-pip \
        python3-pygments \
        python-is-python3 \
        nodejs \
        npm \
        vim \
        jq \
        tidy \
        zip \
        unzip \
        tree \
        sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Install self-updating tools as the developer account.
USER vscode

# Set explicit user paths and non-secret workspace defaults.
ENV HOME="/home/vscode" \
    PATH="/home/vscode/.local/bin:${PATH}" \
    NPM_CONFIG_PREFIX="/home/vscode/.local" \
    UV_PROJECT_ENVIRONMENT=".venv-sandbox" \
    EDITOR="vim" \
    VISUAL="vim"

# Create the global `npm` prefix directory.
RUN mkdir -p "${NPM_CONFIG_PREFIX}/lib"

# Install user-owned `uv`.
RUN curl -LsSf "https://astral.sh/uv/install.sh" -o /tmp/install-uv.sh \
    && UV_INSTALL_DIR="${HOME}/.local/bin" UV_NO_MODIFY_PATH=1 sh /tmp/install-uv.sh \
    && rm /tmp/install-uv.sh \
    && uv --version

# Install user-owned `omp`.
RUN curl -LsSf "https://omp.sh/install" -o /tmp/install-omp.sh \
    && PI_INSTALL_DIR="${HOME}/.local/bin" sh /tmp/install-omp.sh --binary \
    && rm /tmp/install-omp.sh \
    && omp --version

# Copy the `tmux` configuration
COPY --chown=vscode:vscode "config/.tmux.conf" /home/vscode/.tmux.conf

# Copy the `vim` configuration.
COPY --chown=vscode:vscode "config/.vimrc" /home/vscode/.vimrc

# Copy the shell aliases.
COPY --chown=vscode:vscode "scripts/aliases.sh" /home/vscode/.scripts/aliases.sh

# Ensure the aliases are loaded in `zsh`.
RUN echo "source /home/vscode/.scripts/aliases.sh" >> /home/vscode/.zshrc


# Adjust `omp` options.
RUN omp config set secrets.enabled true \
    && omp config set telemetry.otlpExportEnabled false \
    && omp config set lsp.diagnosticsOnWrite false
