# Introduction

A Rakefile to backup your MYSQL datbases. Probably requires Ruby 1.9+

# Usage

Place plain text files in lists/ . Each list should contain a list of database names, one per line. Feel free to generate this as you see fit.

Then:

    rake backup:list:[listname]

will backup all those databases to `backups/[listname]/[databasename]`;

    rake restore:list:[listname]

will restore all the databases in `backups/[listname]`;

    rake backup:list:[listname]

will drop all the databases in that list.
