# alpine:latest (as of 2024-07-03)
FROM alpine@sha256:b89d9c93e9ed3597455c90a0b88a8bbb5cb7188438f70953fede212a0c4394e0

RUN echo "Running commands as root" && \
    # Install packages
    apk add --no-cache \
        # Core packages
        bash \
        git \
        openssh-client \
        gnupg \
        procps \
        lsof \
        htop \
        net-tools \
        psmisc \
        curl \
        wget \
        rsync \
        ca-certificates \
        unzip \
        xz \
        zip \
        nano \
        vim \
        less \
        jq \
        libgcc \
        libstdc++ \
        krb5-libs \
        libintl \
        lttng-ust \
        tzdata \
        userspace-rcu \
        zlib \
        sudo \
        coreutils \
        sed \
        grep \
        which \
        ncdu \
        shadow \
        strace \
        docker-cli \

        # Zsh packages
        zsh \
        zsh-autosuggestions \
        zsh-syntax-highlighting && \

    # Create "dev" user
    adduser -D -s /bin/zsh dev && \

    # Add "dev" user to sudoers
    echo "dev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dev

USER dev

RUN echo "Running commands as dev" && cd /home/dev && \
    # Install Oh My Zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    
    # Configure Oh My Zsh
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="gallifrey"/g' ~/.zshrc && \
    sed -i 's/plugins=(git)/plugins=(git sudo z)/g' ~/.zshrc && \
    echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc && \
    echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc