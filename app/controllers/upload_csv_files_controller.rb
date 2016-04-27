class UploadCsvFilesController < ApplicationController
	require 'csv'
  def index
  end
  def all_category
		@category= Category.all
		if @category.present?
		  render json:{code:'500',message:'successfully',categories:@category.as_json(except: [:created_at,:updated_at])}
	   else
	   	render json:{code:'400',message:'company does not exist'}
	  end
	end

	def sub_category
		@category=Category.find_by_id(params[:category_id])
		if @category.present?
			@sub_categories=@category.sub_categories	    
			render json:{code:'500',message:'succesfully',sub_category:@sub_categories.as_json(except:[:created_at,:updated_at])}
		else
			render json:{code:'400',message:'category does not exist'}
	  end
	end
  
  def category_message
  	@category=Category.find_by_id(params[:category_id])
  	if @category.present?	
	  	@messages=@category.messages
	  	render json:{code:'500',message:'succesfully',data:{:category=>@messages.as_json(except:[:created_at,:updated_at,:sub_category_id,:category_id,:id])}}
	  else
	  	render json:{code:'400',message:'category does not exist'}
	  end
  end
   def all_message
	   	@categories=Category.all
	   	#@results = Array.new
	   	categHash={ }
	   	@categories.each do |categ|
	   		categHash["#{categ.name}"]=categ.messages
	   		#@results<<["#{categ.name}"]
	   		#@results.each do |r|
	   		#	@res=Array.new
	   	end
	   	render json:{code:'500',message:'succesfully',data:categHash.as_json(except:[:created_at,:updated_at,:sub_category_id,:category_id,:id])}
   end
  def sub_category_message
  	@sub_category=SubCategory.find_by_id(params[:sub_category_id])
  	if @sub_category.present?
	  	@messages=@sub_category.messages
	  	render json:{code:'500',message:'succesfully','messages':@messages.as_json(except:[:created_at,:updated_at,:category_id])}
	  else
	  	render json:{code:'400',message:'category does not exist'}
	  end
  end
  
  def new
   
  end

  def upload_model
	    file=params[:upload_file][:file]
	    @i=1
		@status=false
	    if File.extname(file.original_filename)=='.csv'
	      CSV.foreach(file.path) do |row|
		      if @i==1
					   p "-------------------#{row.inspect}"
					  if row[0] == "id" and row[1] == "category" and row[2] == "sub_category" and row[3] == "quote" 
						  @status = true
					  else
						 @status = false
						  break 
					  end
					else
		        @category=Category.find_by_name(row[1])
		        if !@category
		          @category=Category.create(:name=>row[1])
		        else
	           @category.update_attributes(:name=>row[1])
	          end

		        @sub_category = row[2]
		        if @sub_category.present?
						  @sub_category = @category.sub_categories.find_by_name(row[2])
	            if !@sub_category
	              @sub_category = @category.sub_categories.create(:name=>row[2])
	            else
	             @sub_category.update_attributes(:name=>row[2])
	            end

	            @message =row[3]
              if @message.present?
		            if !@category.messages.exists?(:message=>row[3])
		              @messages=@category.messages.create(:message=>row[3],:sub_category_id=>@sub_category.id)
		            #else
		            	#@messages.update_attributes(:message=>row[3])
		            end
		          end
		        end
			    end
	        @i+=1
	      end
	       flash[:notice] = "File imported"
    		  redirect_to :back
	    else
	      flash[:notice]="file extension not same"
	      redirect_to :back
	    end 
  end
end
