module FilesByPete
  include ActiveSupport::Concern
  
  def pete_file_upload
      if defined? params[:attachable_type] == "constant"
         uploaded_io = params[:file]
         pete_file = PeteFile.new
         pete_file.attachable_type = params[:attachable_type]
         pete_file.attachable_id = params[:attachable_id]
         pete_file.section = params[:section]
         pete_file.name = params[:title].gsub(" ","-") 
         pete_file.save
         pete_file.upload_file(uploaded_io)
         render json: {pete_file: pete_file, timestamp: params[:timestamp], file_a: pete_file.get_file_a}
      end 
  end
  
  def pete_file_destroy
      unless params[:pete_file_id].nil?
         pete_file = PeteFile.find(params[:pete_file_id])
         pete_file_aux = pete_file
         pete_file.destroy
         render json: pete_file_aux
      end
  end
  
end