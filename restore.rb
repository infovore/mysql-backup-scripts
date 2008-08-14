#!/usr/bin/env ruby -wKU

DBUSER = "dbuser"
DBPASSWORD = "dbp"

Dir["./*.sql"].each do |file|
  filename = File.basename(file, ".sql")
  system("mysql -udbuser -pdbp -e 'drop database #{filename}'")
  system("mysql -udbuser -pdbp -e 'create database #{filename}'")
  system("mysql -udbuser -pdbp  #{filename} < #{file}'")  
end