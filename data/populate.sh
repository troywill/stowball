#!/bin/bash
EDITOR='emacs'
${EDITOR} packages.csv latest_tarball.csv
${EDITOR} packages.csv webpages.csv
${EDITOR} packages.csv package_metas.csv
git add *
git commit
git push origin master
cd ..
./stowball-write-repository-data
