class TabelaczasowdostepnychsController < ApplicationController
 

    filter_access_to :all

 layout 'worker'
before_filter :normatywy_all, :only => [:index,:export,:create]
before_filter :normatywy_by_id, :only => [:delete]

def normatywy_by_id
    @czas = Tabelaczasowdostepnych.find(params[:id])
 end
def normatywy_all
    @czasy = Tabelaczasowdostepnych.find(:all, order: "id desc")
end

def index
	@nowy_czas = Tabelaczasowdostepnych.new	
end

def new
	@nowy_czas = Tabelaczasowdostepnych.new

end

def create
	@nowy_czas = Tabelaczasowdostepnych.new(params[:tabelaczasowdostepnych])	
	 if @nowy_czas.save 
    	redirect_to :action => "index"	
    	flash[:notice] = "Poprawnie dodano czas dostepny"
    else
    	flash[:notice] = "Nie udalo sie dodac czasu dostepnego sprawdz poprawnosc wypelnionych pol."
    	render "index"
    end
end

 def delete
    if @czas.destroy
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
