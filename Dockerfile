FROM centos:8

# Setup
RUN dnf -y update
RUN dnf -y install sudo

# Set bash
SHELL ["/bin/bash", "-c"]

# Set user
ARG user=tesseract_user
ENV DOCKER_USER="${user}"
RUN useradd -ms /bin/bash --groups wheel ${DOCKER_USER}
RUN echo "${DOCKER_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $DOCKER_USER
WORKDIR /home/${DOCKER_USER}

RUN sudo dnf install -y\
             epel-release \
             dnf-plugins-core
RUN sudo dnf config-manager --set-enabled powertools

RUN sudo dnf install -y\
             xorg-x11-apps \
             xauth \
             pciutils \
             lshw \
             epel-release \
             wget \
             zip \
             unzip \
             git \
             libXcursor-devel \
             libXinerama-devel \
             libXrandr-devel \
             mesa-dri-drivers \
             mesa-libGLES \
             mesa-libGLw \
             mesa-libGLw-devel \
             freeglut-devel \
             freeglut \
             expat-devel \
             doxygen \
             libXmu-devel \
             libXi-devel \
             libGL-devel \
             libGLU-devel \
             curl-devel \
             openssl-devel \
             gcc-c++ \
             atlas-devel \
             autoconf \
             automake \
             blas-devel \
             bluez-libs-devel \
             bzip2 \
             bzip2-devel \
             emacs \
             expat-devel \
             gcc-c++ \
             gdbm-devel \
             ghostscript \
             git \
             glibc-devel \
             gmp-devel \
             graphviz \
             ImageMagick \
             jq \
             json-c \
             libdb-devel \
             libffi-devel \
             libtool \
             libunwind-devel \
             libuuid-devel \
             libXmu-devel \
             libXpm-devel \
             make \
             man \
             mesa-libGLU-devel \
             nano \
             ncurses-devel \
             openmotif-devel \
             openssl-devel \
             patch \
             perl-Digest-MD5 \
             python39-devel \
             qt5-qtbase-devel \
             qt5-qtscript-devel \
             readline-devel \
             sqlite-devel \
             systemtap-sdt-devel \
             tcl-devel \
             tix-devel \
             tk-devel \
             valgrind-devel \
             vim-X11 \
             vim-common \
             vim-enhanced \
             vim-minimal \
             wget \
             which \
             zlib-devel \
             libXcursor-devel \
             libXinerama-devel \
             libXrandr-devel \
             mesa-dri-drivers \
             mesa-libGLES \
             mesa-libGLw \
             mesa-libGLw-devel \
             freeglut-devel \
             freeglut \
             expat-devel \
             doxygen \
             libXmu-devel \
             libXi-devel \
             libGL-devel \
             curl-devel \
             openssl-devel \
             && yum clean all \
             && rm -rf /var/tmp/yum*

COPY scripts/bashrc_customisation.sh /home/${DOCKER_USER}/.bashrc_customisation.sh
RUN cd && echo "source ${HOME}/.bashrc_customisation.sh" >> .bashrc

RUN export EXTERNALS_BASE=/home/${DOCKER_USER}/externals && mkdir -p ${EXTERNALS_BASE}

COPY scripts/externals_installer.sh /home/${DOCKER_USER}/externals/externals_installer.sh
RUN cd /home/${DOCKER_USER}/externals \
    && export EXTERNALS_BASE=/home/${DOCKER_USER}/externals \
    && source externals_installer.sh
