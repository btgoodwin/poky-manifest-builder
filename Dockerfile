# This file is protected by Copyright. Please refer to the COPYRIGHT file
# distributed with this source distribution.
#
# This file is part of Geon Technology's OE Builder.
#
# OE Builder is free software: you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option) any
# later version.
#
# OE Builder is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see http://www.gnu.org/licenses/.
#
FROM ubuntu:16.04

LABEL name="Generic OE Run Environment" \
    version="0.1" \
    maintainer="Thomas Goodwin <btgoodwin@geontech.com>" \
    vendor="Geon Technologies"

RUN apt-get update && \
    apt-get install install -qy \
        python \
        curl \
        gawk \
        wget \
        git-core \
        diffstat \
        unzip \
        texinfo \
        gcc-multilib \
        build-essential \
        chrpath \
        socat \
        libsdl1.2-dev \
        xterm && \
    curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo && \
    chmod a+x /usr/local/bin/repo

# User sets this variable to begin a new project from a manifest URL.
ENV REPO_URL ""

# User TEMPLATECONF relative to the poky base directory.
ENV TEMPLATECONF ""

# Set these and other environment variables for the `build-image.sh` script that should
# be provided in your workspace/build path.
ENV MACHINE     ""
ENV BUILD_IMAGE ""

# External user's UID and GID for the init script
ENV EXT_UID 54321
ENV EXT_GID 12345

# User's resulting name and workspace location for run-oe script
# Do not modify these.
ENV USER_NAME           user
ENV USER_HOME           /home/${USER_NAME}
ENV USER_WORKSPACE      ${USER_HOME}/workspace
ENV USER_RUN_OE         ${USER_WORKSPACE}/run-oe.sh

# Exposed workspace
VOLUME ${USER_WORKSPACE}

# Init script to bootstrap startup
COPY files/init.sh /root/init.sh
RUN chmod +x /root/init.sh

# Run script to begin bitbake as the user.
COPY files/run-oe.sh ${USER_RUN_OE}
RUN chmod +x ${USER_RUN_OE}

CMD [ "/bin/bash", "-c", "/root/init.sh" ]
