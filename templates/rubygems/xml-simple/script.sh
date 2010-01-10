#!/bin/bash
set -o errexit
# gem fetch xml-simple
GEM_NAME='xml-simple'
GEM_VERSION='1.0.12'
RUBY_VERSION=`ruby -e 'print RUBY_VERSION'`
echo "==>${RUBY_VERSION}<=="
sudo mkdir --parent --verbose /stow/${GEM_NAME}-${GEM_VERSION}
sudo mkdir --parent --verbose /stow/rubygems
sudo chown --verbose troy /stow/rubygems

gem install xml-simple-1.0.12.gem \
    --verbose \
    --install-dir /stow/rubygems/usr/lib/ruby/gems/${RUBY_VERSION} \
    --bindir /stow/rubygems/usr/bin \
    --no-rdoc \
    --no-ri
#    --ignore-dependencies \

exit
