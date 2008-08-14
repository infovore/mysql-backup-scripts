#!/usr/bin/env ruby -wKU

# ================================
# = MySQL database backup script =
# ================================
# 
# Backs up databases to a file called [database_name].sql


DBUSER = "dbuser"
DBPASSWORD = "dbp"

def run(command, input="")
  IO.popen(command, 'r+') do |io|
    io.puts input
    io.close_write
    return io.read
  end
end

databases = run("mysql -u#{DBUSER} -p#{DBPASSWORD} -e 'show databases'").split("\n")

databases.slice!(0) # remove header from table

databases.each do |database|
  system "mysqldump -u#{DBUSER} -p#{DBPASSWORD} #{database} > #{database}.sql"
  puts "Backed up #{database} to #{database}.sql"
end
