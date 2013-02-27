class WorkersController < ApplicationController
require 'csv'

  layout 'worker'
 
   @workers = Worker.find(:all, :include => [:effectivenes], :joins => [:effectivenes])
  def index
    
    render('lista')
    @pracownik = Worker.find(params[:id])
  end
  
  def lista
  @workers = Worker.find(:all, :include => [:effectivenes], :joins => [:effectivenes])

	end


  def pracownik
  @workers = Worker.find(:all, :include => [:effectivenes], :joins => [:effectivenes])
    
  end

  #  @effect = Worker.find(:all, :include => :effectivenes)

  def wyszukaj

    @workers = Worker.find(:all, :include => [:effectivenes], :joins => [:effectivenes])
    @worker = Worker.find(params[:id])
    @effec = Effectivene.find(:all, :conditions => ["worker_id = ?" , @worker.id])
    @worker_count = Worker.count
    @efektyw = @worker.effectivenes
  end
	
  def javascript

  end

end
# def make_labels
#   y = ["Time"]
#   for task in Task.all do
#     y.append task.name
#   end
#   return y
# end

# def make_data( time, completeness )
#   y = Worker.first.created_at + time
#   for task in Task.all do
#     y.append task[completeness]
#   end
#   return y
# end
# def wykres 
# 	@workers = Worker.find(:all, :include => [:effectivenes], :joins => [:effectivenes])
# 	@effec = Effectivenes.find(:all)
# 	def make_a_chart
# 		result = []
# 		result.push @workers.each do |workers|
# 		worker.id_worker
# 		worker.id_worker_merx
# 		worker.last_name
# 		worker.first_name
# 			worker.effectivenes.each do |effe|
# 		effe.effectivity
# 		effe.effectivity_min
# 		effe.effectivity_max
# 			end
# 		end
# 	return result
# 	end
# end


  # def new
  #   @section = Section.new
  #   @section_count = Section.count + 1
  #   @pages = Page.order('position ASC')
  # end
  
  # def create
  #   @section = Section.new(params[:section])
  #   if @section.save
  #     flash[:notice] = "Section created."
  #     redirect_to(:action => 'list')
  #   else
  #     @section_count = Section.count + 1
  #     @pages = Page.order('position ASC')
  #     render('new')
  #   end
  # end
  
  # def edit
  #   @section = Section.find(params[:id])
  #   @section_count = Section.count
  #   @pages = Page.order('position ASC')
  # end
  
  # def update
  #   @section = Section.find(params[:id])
  #   if @section.update_attributes(params[:section])
  #     flash[:notice] = "Section updated."
  #     redirect_to(:action => 'show', :id => @section.id)
  #   else
  #     @section_count = Section.count
  #     @pages = Page.order('position ASC')
  #     render('edit')
  #   end
  # end
  
  # def delete
  #   @section = Section.find(params[:id])
  # end
  
  # def destroy
  #   Section.find(params[:id]).destroy
  #   flash[:notice] = "Section destroyed."
  #   redirect_to(:action => 'list')
  # end
    



