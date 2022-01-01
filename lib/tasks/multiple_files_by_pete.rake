require_relative '../peterconsuegra_recipes'
require 'fileutils'
require "tty-file"

#bundle exec rake 'multiple_files_by_pete[place]'

desc 'install multiple_files_by_pete required files'

task :multiple_files_by_pete, [:model] do |t, args|

Dir.glob("#{Rails.root}/app/models/*.rb").each { |file| require file }

puts "hello desde rake"
  
end
