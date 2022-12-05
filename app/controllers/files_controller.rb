# frozen_string_literal: true

class FilesController < ApplicationController
    def index
      obtain_remote_files
    end
  
    def store
      Uploadcare::File.store_file(file_params[:id])
      flash[:success] = 'File has been successfully stored!'
      redirect_to_prev_location
    end
  
    def show
      @file = Uploadcare::File.file(file_params[:id])
    end
  
    def destroy
      Uploadcare::File.delete_file(file_params[:id])
      flash[:success] = 'File has been successfully deleted!'
      redirect_to_prev_location
    end
  
    def new_store_file_batch
      obtain_remote_files
    end
  
    def new_delete_file_batch
      obtain_remote_files
    end
  
    def store_file_batch
      files = file_params[:files].to_h.symbolize_keys
      keys = files.keys
      values = files.values
      Uploadcare::File.store_files(values)
      flash[:success] = "File(s) #{keys.join(', ')} has been successfully stored!"
      redirect_to_prev_location
    end
  
    def delete_file_batch
      files = file_params[:files].to_h.symbolize_keys
      keys = files.keys
      values = files.values
      Uploadcare::File.delete_files(values)
      flash[:success] = "File(s) #{keys.join(', ')} has been successfully deleted!"
      redirect_to_prev_location
    end
  
    private
  
    def file_params
      params.permit(:id, files: {})
    end
  
    def obtain_remote_files
      # @files_data = Uploadcare::File.files(ordering: '-datetime_uploaded')
      # @files = @files_data[:results]
      puts file_params[:id]
      @file = Uploadcare::File.file(file_params[:id])
    
    end
  end