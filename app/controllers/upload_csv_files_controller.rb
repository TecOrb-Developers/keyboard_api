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
		@sub_categories=SubCategory.where("category_id=?",params[:category_id])
	    render json:{code:'500',message:'succesfully',sub_category:@sub_categories.as_json(except:[:created_at,:updated_at])}
	end
  
  def message
  	@messages=Message.where("sub_category_id=?",params[:sub_category_id])
  	render json:{code:'500',message:'succesfully','Message':@messages.as_json(except:[:created_at,:updated_at])}
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
			        #else
               #@car.update_attributes(:name=>row[1])
             end
			        @sub_category = row[2]
			        if @sub_category.present?

				            @sub_category = @category.sub_categories.find_by_id(row[2])
				            if !@sub_category
				              @sub_category = @category.sub_categories.create(:name=>row[2])
				            end

				            if !@sub_category.messages.exists?(:message=> row[3])
				              @messages=@sub_category.messages.create(:message=>row[3],:sub_category_id=>@sub_category.id)
				            end
			        end
		        end
		        @i+=1
		        flash[:notice] = "File imported"
      		  redirect_to :back
	       end
	    else
	      flash[:notice]="file extension not same"
	    end 
  end
end
