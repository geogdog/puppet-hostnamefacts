#!/bin/bash
#
# testme.sh - Run my tests like a good boy
#
# Copyright (C) 2014 Greg Trahair <greg.trahair@gmail.com>
#
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

# Set shell options
#set -ex

# Set SCRIPTDIR to the directory that this script runs from
SCRIPTDIR="$(cd $(dirname "${0}");pwd)"

# Variables
export PUPPET_VERSION=3.5.1
export RUBY_VERSION=1.8.7
export BUNDLE_GEMFILE=.gemfile

# Main routine
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

rvm use ${RUBY_VERSION}@$$ --create
bundle install
bundle exec rake validate && \
bundle exec rake lint && \
SPEC_OPTS="--format documentation" bundle exec rake spec

rvm --force gemset delete $$
