SimpleCms::Application.routes.draw do
   
  get "sessions/new"
    #root :to => "workers#lista"
    root :to => "sessions#new"
    match '/pracownicy/lista' => 'workers#lista', :as => :lista_pracownikow
    match '/tabela-normatywow/export' => 'tabelanormatywow#export', :as => :export_normatywow
    match '/typy-czynnosci/export' => 'typyczynnosci#export', :as => :export_czynnosci
    match 'wyszukiwanie/:id/raport' => 'searches#lista', :as => :raport_pracownicy_efektywnosc
    match '/szukaj/nowe', :controller => 'searches', :action => 'new', :as => 'nowe_szukanie'
    match '/szukaj/:id' => 'searches#show', :as => 'szukaj_po_id'

    get "rejestruj" => "users#new", :as => "rejestruj"
    get "zaloguj" => "sessions#new", :as => "zaloguj"
    post "wyloguj" => "sessions#destroy", :as => "wyloguj"
    
    match 'import' => 'workers#import_render', :as => 'import_danych'
    match 'pracownik/szczegoly/:id' => 'workers#szczegoly', :as => 'szczegoly_po_id'
    match 'pracownik/dodaj' => 'workers#new', :as => 'nowy_pracownik'
    match '/searches/nowe', :controller => 'searches', :action => 'new'
    match '/pracownicy' => 'workers#index', :as => :index
    match '/workers/wyszukaj/:id', :controller => 'workers', :action => 'wyszukaj' , :as => :info_pracownik
    match '/pomocnicze/nowa-predkosc' => 'pomocniczes#create' , :as => 'predkoscis'
    match '/pomocnicze/nowy-dodatek' => 'pomocniczes#create' , :as => 'dodatkis'
    match '/pomocnicze/nowy-dodatek' => 'pomocniczes#create' , :as => 'obszars'
    match '/tabela-normatywow/nowy-normatyw' => 'tabelanormatywows#create' , :as => 'tabelanormatywows'
    match '/tabela-transportowa/nowy-transport' => 'tabelatransportowas#create' , :as => 'tabelatransportowas'
    match '/tabela-czasow-dostepnych/nowy-czas' => 'tabelaczasowdostepnychs#create' , :as => 'tabelaczasowdostepnyches'
    match '/tabela-realizacji-norm/nowa-realizacja' => 'realizacjanorms#create' , :as => 'realizacjanorms'
    match '/pomocnicze' => 'pomocniczes#index' , :as => 'pomocnicze'
    #EFEKTYWNOSCI
    match 'efektywnosci/kalendarz' => 'effectivenes#calendar' , :as => 'effectivenes_calendar'
    match 'efektywnosc/nowa' => 'effectivenes#create', :as => 'effectivenes_index'
    #TABELE
    match 'tabela-normatywow' => 'tabelanormatywows#index', :as => 'tabela_normatywow'
    match 'tabela-transportowa' => 'tabelatransportowas#index', :as => 'tabela_transportowa'
    match 'typy-czynnosci' => 'typyczynnoscis#index', :as => 'typy_czynnosci'
    match 'tabela-czasow-dostepnych' => 'tabelaczasowdostepnychs#index', :as => 'tabela_czasow_dostepnych'
    match 'tabela-realizacji-norm' => 'realizacjanorms#index', :as => 'tabela_realizacji_norm'

    #EDYCJA
    match 'obszar/edytuj/:id' => 'pomocniczes#edit_obszar', :as => 'edit_obszar'
    match 'obszar/update/:id' => 'pomocniczes#update_obszar', :as => 'obszar'
    match 'dodatek/edytuj/:id' => 'pomocniczes#edit_dodatek', :as => 'edit_dodatek'
    match 'dodatek/update/:id' => 'pomocniczes#update_dodatek', :as => 'dodatki'
    match 'predkosc/edytuj/:id' => 'pomocniczes#edit_predkosc', :as => 'edit_predkosc'
    match 'predkosc/update/:id' => 'pomocniczes#update_predkosc', :as => 'predkosci'

    #USUWANIE
    match 'pracownik/usun/:id' => 'workers#delete', :as => 'usun_po_id'
    match 'typy-czynnosci/usun/:id' => 'typyczynnoscis#delete', :as => 'usun_po_id_czynnosc'
    match 'tabela-czynnosci/usun/:id' => 'tabelanormatywows#delete', :as => 'usun_po_id_normatyw'
    match 'tabela-transportowa/usun/:id' => 'tabelatransportowas#delete', :as => 'usun_po_id_transport'
    match 'tabela-czasow-dostepnych/usun/:id' => 'tabelaczasowdostepnychs#delete', :as => 'usun_po_id_czas_dostepny'
    match 'tabela-realizacji-norm/usun/:id' => 'realizacjanorms#delete', :as => 'usun_po_id_realizacja_norm'
    match 'pomocnicze/usun/:id' => 'pomocniczes#delete', :as => 'usun_po_id_predkosc'
    match 'pomocnicze/usun-dodatek/:id' => 'pomocniczes#delete_dodatek', :as => 'usun_po_id_dodatek'
    match 'pomocnicze/usun-obszar/:id' => 'pomocniczes#delete_obszar', :as => 'usun_po_id_obszar'
    match 'pracownik/:id2/cel/usun/:id' => 'celes#delete', :as => 'usun_po_id_cel'
    match 'pracownik/:id2/premia/usun/:id' => 'premies#delete', :as => 'usun_po_id_premia'
    match 'pracownik/:id2/efektywnosc/usun/:id' => 'effectivenes#delete', :as => 'usun_po_id_efektywnosc'

    resources :typyczynnoscis do
      collection {get :index}
    end

    resources :searches
    resources :sessions
    resources :users
    resources :celes
    resources :premies
    resources :effectivenes
    resources :effectivene

    # resources :pomocniczes    
    # resources :tabelanormatywows
    # resources :tabelatransportowas

    
    #EXPORTY
    match '/tabela-normatywow/export' => 'tabelanormatywow#export', :as => :export_normatywow
    match '/tabela-transportowa/export' => 'tabelatransportowas#export', :as => :export_tabela_transportowa
    match '/typy-czynnosci/export' => 'typyczynnosci#export', :as => :export_czynnosci
    match '/tabela-czasow-dostepnych/export' => 'tabelaczasowdostepnychs#export', :as => :export_czasy_dostepne


    #IMPORTY
    resources :workers do 
      collection {post :import , :import_tn, :import_tc, :import_tt,:import_tdc, :import_rn}
    end


  #get "demo/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id))(.:format)'
end
