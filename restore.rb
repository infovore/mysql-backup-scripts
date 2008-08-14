#!/usr/bin/env ruby -wKU

# ================================
# = MySQL database backup script =
# ================================
# 
# Restores databases from files named [database_name].sql to a database named [database_name]
# 
# NOTE: will DROP a database before re-creating it. 


DBUSER = "dbuser"
DBPASSWORD = "dbp"

Dir["./*.sql"].each do |file|
  filename = File.basename(file, ".sql")
  system("mysql -udbuser -pdbp -e 'drop database #{filename}'")
  system("mysql -udbuser -pdbp -e 'create database #{filename}'")
  system("mysql -udbuser -pdbp  #{filename} < #{file}'")  
end