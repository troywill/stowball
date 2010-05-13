groupadd -g 25 apache &&
useradd -c "Apache Server" -d /dev/null -g apache \
        -s /bin/false -u 25 apache
