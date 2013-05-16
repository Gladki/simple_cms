class TabelanormatywowsController < ApplicationController
 

    filter_access_to :all

 layout 'worker'
before_filter :normatywy_all, :only => [:index,:export,:create]
before_filter :normatywy_by_id, :only => [:delete]

def normatywy_by_id
    @normatyw = Tabelanormatywow.find(params[:id])
 end
def normatywy_all
    @normatywy = Tabelanormatywow.find(:all, :order => "id desc")
end

def index
	@nowy_normatyw = Tabelanormatywow.new	
  respond_to do |format|
  format.html
  format.json { render json: NormatywyDatatable.new(view_context) }
  end
end

def new
	@nowy_normatyw = Tabelanormatywow.new	
end

def create
	@nowy_normatyw = Tabelanormatywow.new(params[:tabelanormatywow])	
	 if @nowy_normatyw.save 
    	redirect_to :action => "index"	
    	flash[:notice] = "Poprawnie dodano normatyw"
    else
    	flash[:notice] = "Nie udalo sie dodac normatywu sprawdz poprawnosc wypelnionych pol."
    	render "index"
    end
end

 def delete
    if @normatyw.destroy
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
