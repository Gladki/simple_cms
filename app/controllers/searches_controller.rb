class SearchesController < ApplicationController
  
  layout 'search'

  def index
    @searchess = Search.all
    @searches = Worker.where("last_name like ? or first_name like ?", "%#{params[:q]}%", "%#{params[:q]}%")
    respond_to do |format|
    format.html
    format.json { render :json => @searches.map{|contact|
     {:id => contact.id, :name => contact.last_name + " " + contact.first_name }}}
  end
  end

  def show
    @search = Search.find(params[:id])
  end

  def new
    @search = Search.new
    @searches = Worker.where("last_name like ? or first_name like ?", "%#{params[:q]}%", "%#{params[:q]}%")
    respond_to do |format|
    format.html
    format.json { render :json => @searches.map{|contact|
     {:id => contact.id, :name => contact.last_name + " " + contact.first_name }}}
  end
  end

  def create
    @search = Search.new(params[:search])
    if @search.save
      redirect_to szukaj_po_id_path(@search.id) , :notice => "Poprawnie przeprowadzono wyszukiwanie"
    else
      render :action => 'new'
    end
  end

  def edit
    @search = Search.find(params[:id])
  end

  def update
    @search = Search.find(params[:id])
    if @search.update_attributes(params[:search])
      redirect_to @search, :notice  => "Successfully updated search."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @search = Search.find(params[:id])
    @search.destroy
    redirect_to searches_url, :notice => "Successfully destroyed search."
  end
end
