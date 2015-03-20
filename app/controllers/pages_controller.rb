class PagesController < ApplicationController  

  caches_page :index, :tour, :profil, :unterstuetzer, :ziele, :gewichtstagebuch
  #caches_action :index

  def index       
  end  

  def show    
  end

  def tour
    
  end

end
