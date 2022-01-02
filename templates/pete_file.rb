class PeteFile < ApplicationRecord
  
  before_destroy :delete_file
  
  def delete_file
    rails_app_folder = Dir.pwd 
    path_to_file="#{rails_app_folder}/public/upload/#{self.attachable_type}/#{self.attachable_id}/#{self.section}/#{self.name}"
    File.delete(path_to_file) if File.exist?(path_to_file)
  end
  
  #uploaded_io ActionDispatch::Http::UploadedFile
  def upload_file(uploaded_io)
    require 'fileutils'
    
    rails_app_folder = Dir.pwd 
    dest_folder="#{rails_app_folder}/public/upload/#{self.attachable_type}/#{self.attachable_id}/#{self.section}"
    FileUtils.mkdir_p dest_folder
    File.open(Rails.root.join('public', "upload/#{self.attachable_type}/#{self.attachable_id}/#{self.section}" , self.name), 'wb') do |file|
        file.write(uploaded_io.read)
     end
    
  end
  
  def get_file_a
    "<a target='_blank' class ='pete_file_li' href='/upload/#{self.attachable_type}/#{self.attachable_id}/#{self.section}/#{self.name}'>#{self.name}</a>"
  end
  
  def self.get_section_files(attachable_id,attachable_type,section)
     PeteFile.where(["attachable_id = ? and attachable_type = ? and section = ?", attachable_id, attachable_type,section])
  end
  
  def self.get_object_files(object)
     pete_files = PeteFile.where(["attachable_id = ? and attachable_type = ?", object.id, object.class.name])
     hash = Hash.new
     pete_files.each do |pete_file| 
       if hash[pete_file.section].nil?
           hash[pete_file.section] = []
       else
           hash[pete_file.section] << pete_file
       end
     end
     return hash
  end
  
end
