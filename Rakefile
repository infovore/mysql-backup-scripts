# require 'FileUtils'
require 'YAML'

config = YAML.load(File.read("config.yml"))
%w{dbuser dbpassword}.each do |key|
  Object.const_set(key.upcase, config["config"][key])
end

ABSPATH = File.expand_path(File.dirname(__FILE__))
LISTS = Dir["#{ABSPATH}/lists/*"].map {|f| f.split("/").last}

namespace :backup do 
  namespace :list do
    LISTS.each do |list|
      desc "Backup every database listed in lists/#{list}"
      task list.to_sym do

        FileUtils::mkdir_p("#{ABSPATH}/backups/#{list}")

        databases = File.readlines("#{ABSPATH}/lists/#{list.strip}").map {|l| l.strip}

        databases.each do |database|
          system "mysqldump -u#{DBUSER} -p#{DBPASSWORD} #{database} > #{ABSPATH}/backups/#{list}/#{database}.sql"
          puts "Backed up #{database} to backups/#{list}/#{database}.sql"
        end
      end
    end
  end
end

namespace :restore do
  namespace :list do
    LISTS.each do |list|
      desc "Restore everything in backups/#{list}"
      task list.to_sym do
        Dir["#{ABSPATH}/backups/#{list}/*"].each do |file|
          db_name = File.basename(file, ".sql")
          system("mysql -u#{DBUSER} -p#{DBPASSWORD} -e 'drop database #{db_name}'")
          system("mysql -u#{DBUSER} -p#{DBPASSWORD} -e 'create database #{db_name}'")
          system("mysql -u#{DBUSER} -p#{DBPASSWORD}  #{db_name} < #{file}")  
          puts "Restored #{db_name} from #{file}"
        end
      end
    end
  end
end

namespace :drop do 
  namespace :list do
    LISTS.each do |list|
      desc "Drop every database listed in lists/#{list}"
      task list.to_sym do
        databases = File.readlines("#{ABSPATH}/lists/#{list.strip}").map {|l| l.strip}

        databases.each do |database|
          system("mysql -u#{DBUSER} -p#{DBPASSWORD} -e 'drop database #{database}'")
          puts "Dropped #{database}."
        end
      end
    end
  end
end