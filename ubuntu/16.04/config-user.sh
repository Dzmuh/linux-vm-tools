#!/bin/bash

# ---------------------------------------------------------------------------
#
# MIT License
#
# Copyright (c) Microsoft Corporation. All rights reserved.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE
#
# ---------------------------------------------------------------------------
#
# This script configures the logged in users xsession to properly
# configure unity to launch
#
# Major thanks to: http://c-nergy.be/blog/?p=10752 for the tips.
#

if [ ! "$(id -u)" ]; then
    echo 'This script must be run with root privileges' >&2
    exit 1
fi

bash -c "cat > ~/.xsession <<EOF

/usr/lib/gnome-session/gnome-session-binary --session=ubuntu &
/usr/lib/x86_64-linux-gnu/unity/unity-panel-service &
/usr/lib/unity-settings-daemon/unity-settings-daemon &

for indicator in /usr/lib/x86_64-linux-gnu/indicator-*;
do
    basename='basename \\\${indicator}'
    dirname='dirname \\\${indicator}'
    service=\\\${dirname}/\\\${basename}/\\\${basename}-service
    \\\${service} &
done
unity
EOF"
