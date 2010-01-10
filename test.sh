TARGET='/usr/local'
DIR='/usr/local/stow'

create_packages () {
    for I in 1 2 3
    do
	mkdir -v --parent ${DIR}/p${I}/bin/l2/l3
	touch ${DIR}/p${I}/bin/l2/l3/f${I}
    done
}

unstow_everything () {
    for I in 1 2 3
    do
        stow -vvv -D p${I}
    done
}

demonstrate_bug () {
    cd ${DIR}
    unstow_everything
    stow -vvv p1
    stow -vvv -S p2 -S p3
    cd -
}

create_packages
demonstrate_bug
