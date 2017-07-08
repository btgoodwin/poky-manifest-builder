#!/bin/bash
# This file is protected by Copyright. Please refer to the COPYRIGHT file
# distributed with this source distribution.
#
# This file is part of Geon Technology's RasHAWK.
#
# RasHAWK is free software: you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option) any
# later version.
#
# RasHAWK is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see http://www.gnu.org/licenses/.
#

set -e

# Create user with external user's UID and GID
useradd --system \
    --uid ${EXT_UID} \
    --gid ${EXT_GID} \
    --shell /bin/bash \
    ${USER_NAME}
echo "${USER_NAME}  ALL=(ALL)   NOPASSWD: ALL" >> /etc/sudoers

chown -R ${USER_NAME}:${USER_NAME} ${USER_HOME}

# For now, switch to the user.
su ${USER_NAME}
pushd ${USER_WORKSPACE}

# If REPO_URL is non-empty, repo init and sync.
if ! [ -z ${REPO_URL+x} ]; then
    repo init "${REPO_URL}" && \
    repo sync
fi

${USER_RUN_OE}
