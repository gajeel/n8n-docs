FROM mcr.microsoft.com/devcontainers/base:ubuntu
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies, Python 3 and Node 20
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    curl ca-certificates git build-essential lsb-release gnupg \
    python3 python3-venv python3-pip python3-distutils \
  && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
  && apt-get install -y --no-install-recommends nodejs \
  && ln -s /usr/bin/python3 /usr/local/bin/python || true \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Create non-root 'vscode' user to match devcontainer defaults
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid ${USER_GID} ${USERNAME} || true \
  && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} || true

USER ${USERNAME}
WORKDIR /workspace
ENV PATH=/home/${USERNAME}/.local/bin:$PATH

# Keep image small: prefer installing Python packages in postCreate
