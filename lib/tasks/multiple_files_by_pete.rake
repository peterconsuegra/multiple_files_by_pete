require_relative '../peterconsuegra_recipes'
require 'colorize'

#bundle exec rake 'multiple_files_by_pete[model]'

desc 'install multiple_files_by_pete required files'

task :multiple_files_by_pete, [:model] do |t, args|
  
  #Require all models
  Dir.glob("#{Rails.root}/app/models/*.rb").each { |file| require file }
  
  #Base routes
  rails_app_folder = Dir.pwd 
  gem_folder = File.expand_path('../../../.', __FILE__)
  src_folder="#{gem_folder}/templates/"
  
  #Get scaffold vars
  hash = PeterConsuegraRecipes::get_scaffold_vars(args[:model])
  
  #Adding partials
  PeterConsuegraRecipes::move_templates(src_folder,"#{rails_app_folder}/app/views/shared/",["_files_by_pete_js.html.erb","_files_by_pete.html.erb"])
  
  #Adding concern file
  PeterConsuegraRecipes::move_template(src_folder,"#{rails_app_folder}/app/controllers/concerns/","files_by_pete.rb")
  
  #Adding js and css assets
  PeterConsuegraRecipes::move_templates(src_folder,"#{rails_app_folder}/public/multiple_files_by_pete/",["jquery-3.6.0.min.js","bootstrap.min.css"])
  
  #Adding route
  PeterConsuegraRecipes::add_route(hash['base_route'],"pete_file_upload","post")
  PeterConsuegraRecipes::add_route(hash['base_route'],"pete_file_destroy","post")
  
  #Adding concern to controller
  PeterConsuegraRecipes::add_concern_to_controller("include FilesByPete\n",hash['controller_file'],hash['controller_class'])
  
  puts "-----------------------------------------".red
  puts "Copy and paste this code in your project".red
  puts "-----------------------------------------".red
  puts "Add jQuery to your layout file:".red
  puts "<script src='/multiple_files_by_pete/jquery-3.6.0.min.js'></script>".red
  puts "Add bootstrap.min.css to your layout file:".red
  puts '<link rel="stylesheet" href="/multiple_files_by_pete/bootstrap.min.css">'.red
  puts 'Get all the files of that model in the action of the controller you are want:'.red
  puts "@files = PeteFile.get_object_files(@#{args[:model]})".red
  puts "Add the number of fields to upload files you need to your _form.html.erb file:".red
  puts "<%= render partial: 'shared/files_by_pete', locals: {model: @#{args[:model]}, files: @files, section: 'legal_files' ,label: 'Upload legal files'}  %>".red
  puts "<%= render partial: 'shared/files_by_pete', locals: {model: @#{args[:model]}, files: @files, section: 'extra_files' ,label: 'Upload extra files'}  %>".red
  puts "Add the JS logic for multiple_file_by_pete to your _form.html.erb file:".red
  puts "<%= render 'shared/files_by_pete_js', model: @#{args[:model]}, size_limit: 50%>".red
  
  puts "Running command:".blue
  puts "rails g model PeteFile section:string attachable_id:integer attachable_type:string name:string".green
  `rails g model PeteFile section:string attachable_id:integer attachable_type:string name:string`
  sleep 2
  puts "Running command:".blue
  puts "rake db:migrate".green
  `rake db:migrate`
  
  #Adding model pete_file.rb
  PeterConsuegraRecipes::move_template(src_folder,"#{rails_app_folder}/app/models/","pete_file.rb")
  
end
