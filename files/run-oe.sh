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

export TEMPLATECONF=`pwd`${TEMPLATECONF}

# Should be in the user's workspace path when this executes.
source ./poky/oe-init-build-env ./build ./poky/bitbake

# Now we're in build, where there should be a build-image.sh
if ! [ -f ./build-image.sh ]; then
    echo "Error: build-image.sh not found" 1>&2
    exit 1
fi

# Start the build.
./build-image.sh
