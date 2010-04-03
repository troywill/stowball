#!/bin/bash
EDITOR='emacs'
${EDITOR} dependencies.csv packages.csv
git add dependencies.csv
git commit -a
git push
