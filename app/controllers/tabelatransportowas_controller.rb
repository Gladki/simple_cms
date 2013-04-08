class TabelatransportowasController < ApplicationController
 

    filter_access_to :all

 layout 'worker'
before_filter :normatywy_all, :only => [:index,:export,:create]
before_filter :normatywy_by_id, :only => [:delete]

def normatywy_by_id
    @transport = Tabelatransportowa.find(params[:id])
 end
def normatywy_all
    @transporty = Tabelatransportowa.find(:all, :order => "id desc")
end

def index
	@nowy_transport = Tabelatransportowa.new	
end

def new
	@nowy_transport = Tabelatransportowa.new	
end

def create
	@nowy_transport = Tabelatransportowa.new(params[:tabelatransportowa])	
	 if @nowy_transport.save 
    	redirect_to :action => "index"	
    	flash[:notice] = "Poprawnie dodano transport"
    else
    	flash[:notice] = "Nie udalo sie dodac transportu sprawdz poprawnosc wypelnionych pol."
    	render "index"
    end
end

 def delete
    if @transport.destroy
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
