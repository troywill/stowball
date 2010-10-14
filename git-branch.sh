NEWBRANCH='2010_October'
git branch ${NEWBRANCH} master # create a new branch from master
git checkout ${NEWBRANCH} # switch from master to $NEWBRANCH

git checkout master
git diff ${NEWBRANCH}

git push origin ${NEWBRANCH}
