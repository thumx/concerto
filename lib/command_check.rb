#Cross-platform way of finding an executable in the $PATH
#which('ruby') #=> /usr/bin/ruby
#Courtesy of Mislav Marohnic (via Stackoverflow)
def which(cmd)
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    exts.each { |ext|
      exe = "#{path}/#{cmd}#{ext}"
      return exe if File.executable? exe
    }
  end
  return nil
end


#Check for existence of a command for use
def command?(command)
  if which(command) != nil
    return true
  else
    return false
  end
end

def system_has_mysql?
  Gem::Specification::find_all_by_name('mysql2').any? || command?('mysql_config')
end

def system_has_postgres?
  Gem::Specification::find_all_by_name('pg').any? || command?('pg_config')
end

def mysql_location
  which('mysql_config').split('/bin').first
end

def postgres_location
  which('pg_config').split('/bin').first
end
