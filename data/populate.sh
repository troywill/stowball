#!/bin/bash
set -o errexit
EDITOR='emacs'
DIRECTORY=$1
cd ${DIRECTORY}
${EDITOR} packages.csv latest_tarball.csv
${EDITOR} packages.csv webpages.csv
${EDITOR} packages.csv package_metas.csv
git add *
git commit
git push origin master
./stowball-write-repository-data
