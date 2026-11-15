# Pull the official `TeX Live`.
FROM texlive/texlive:latest-doc@sha256:6009b7dc5333e1a56dcec30fc25e7bc52d32d46244ab4b46c816f459ac38cd18AS texlive

# Use the base `Ubuntu` image.
FROM base-ubuntu

# Switch to the `root` user for the installation.
USER root

# Install the runtime dependencies for the `TeX Live` helper tools.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        default-jre-headless \
        ghostscript \
        gnuplot-nox \
        libdigest-perl-md5-perl \
        libfile-homedir-perl \
        libgetopt-long-descriptive-perl \
        libglut3.12 \
        libncurses6 \
        libpdf-api2-perl \
        libtirpc3t64 \
        libunicode-linebreak-perl \
        libyaml-tiny-perl \
    && rm -rf /var/lib/apt/lists/*

# Copy the complete `TeX Live` distribution from the official image.
COPY --link --from=texlive /usr/local/texlive /usr/local/texlive

# Add the `TeX Live` executables to the system path.
RUN "$(find /usr/local/texlive -name tlmgr -print -quit)" path add

# Register the `TeX Live` fonts.
RUN cp "$(find /usr/local/texlive -name texlive-fontconfig.conf -print -quit)" /etc/fonts/conf.d/09-texlive-fonts.conf \
    && fc-cache -fs

# Verify the copied distribution.
RUN latex --version \
    && latexmk --version \
    && pdflatex --version \
    && lualatex --version \
    && xelatex --version \
    && bibtex --version \
    && biber --version \
    && command -v makeindex \
    && xindy --version \
    && arara --version \
    && texdoc -l geometry > /dev/null

# Switch back to the `vscode` user for the interactive session.
USER vscode
