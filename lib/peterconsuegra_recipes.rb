require 'colorize'
require 'fileutils'
require "tty-file"

module PeterConsuegraRecipes  
  
  def self.move_templates(src_folder,dest_folder,files)
    FileUtils.mkdir_p dest_folder
    files.each do |file_name|
      FileUtils.cp(src_folder+file_name,dest_folder+file_name)
      puts "file copied to: #{dest_folder+file_name}".green
    end
  end
  
  def self.move_template(src_folder,dest_folder,file)
    FileUtils.mkdir_p dest_folder
    FileUtils.cp src_folder+file,dest_folder+file
    puts "File copied to: #{dest_folder+file}".green
  end
  
  def self.add_route(base_route,action_name,method)
    rails_app_folder = Dir.pwd 
    route_file="#{rails_app_folder}/config/routes.rb"
    route_code = "#{method} '/#{base_route}_#{action_name}', to: '#{base_route}##{action_name}'"
    PeterConsuegraRecipes::append_before_last_appearance_of("end",route_code,route_file)
    puts "Adding route: #{route_code}".blue
  end
  
  def self.add_concern_to_controller(code,controller_file,controller_class)
    rails_app_folder = Dir.pwd 
    file="#{rails_app_folder}/app/controllers/#{controller_file}"
    #puts "class #{controller_class} < ApplicationController"
    #code="include FilesByPete\n"
    TTY::File.inject_into_file file, code, after: "class #{controller_class} < ApplicationController\n"
    puts "Adding concern to controller #{file}: #{code}".blue
  end
  
  def self.append_before_last_appearance_of(string,code,file)
    File.open(file, 'r+') do |file|
      lines = file.each_line.to_a
      length = lines.length()
      
      lines.reverse.each_with_index do |val, index|
        if val.include?(string)
          aux = lines[length-(index+1)]
          lines[length-(index+1)] = "#{code} \n"
          lines.append(aux)
          file.rewind
          file.write(lines.join)
          break
        end
      end
    end
  end
  
  def self.get_scaffold_vars(model)
    hash = Hash.new
    hash["model"] = model
    hash["model_class"] = model.titleize.gsub(' ','')
    hash["table_name"] = eval(hash["model_class"]).table_name
    hash["controller_file"] = hash["table_name"]+"_controller.rb"
    hash["controller_class"] = hash["table_name"].titleize.gsub(' ','')+"Controller"
    hash["base_route"] = hash["table_name"]
    #puts hash
    return hash
  end
  
end
