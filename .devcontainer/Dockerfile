FROM ubuntu:22.04

# non interactive frontend for locales
ENV DEBIAN_FRONTEND=noninteractive

# installing texlive and utils
RUN \
    apt-get update && \
    apt-get -y install \
        --no-install-recommends \
        locales \
        curl \
        make \
        git \
        texlive \
        texlive-latex-extra \
        texlive-latex-recommended \
        texlive-bibtex-extra \
        texlive-extra-utils \
        texlive-fonts-extra \
        pandoc \
        biber \
        latexmk \
        procps \
    && \
    rm -rf /var/lib/apt/lists/*

# generating locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV \
    LANGUAGE=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# installing cpanm & missing latexindent dependencies
RUN curl -L http://cpanmin.us | perl - --self-upgrade && \
    cpanm Log::Dispatch::File YAML::Tiny File::HomeDir