#!/bin/bash
DATABASE=/var/lib/stowball/2010_spring.db
sqlite3 ${DATABASE} < last_checked.sql
