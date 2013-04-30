class RealizacjanormsController < ApplicationController
 

    filter_access_to :all

 layout 'worker'
before_filter :normatywy_all, :only => [:index,:export,:create]
before_filter :normatywy_by_id, :only => [:delete]

def normatywy_by_id
    @norma = Realizacjanorm.find(params[:id])
 end
def normatywy_all
    @normy = Realizacjanorm.find(:all, :order => "id desc")
end

def index
	@nowa_norma = Realizacjanorm.new	
end

def new
	@nowa_norma = Realizacjanorm.new	
end

def create
	@nowa_norma = Realizacjanorm.new(params[:realizacjanorm])	
	 if @nowa_norma.save 
    	redirect_to :action => "index"	
    	flash[:notice] = "Poprawnie dodano normatyw"
    else
    	flash[:notice] = "Nie udalo sie dodac normatywu sprawdz poprawnosc wypelnionych pol."
    	render "index"
    end
end

 def delete
    if @norma.destroy
      redirect_to :action => "index" 
      flash[:notice] = "Poprawnie usunieto normatyw z bazy"
    else
      redirect_to :action => "index" 
      flash[:notice] = "Nie udalo sie usunac normatywu"
    end
  end

def export
	respond_to do |format|
    	format.html
    	format.xls 	
	end
end

end
