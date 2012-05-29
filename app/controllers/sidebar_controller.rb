class SidebarController < ApplicationController

  def all_tags
    @categories = Category.popular.take(20)

    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def all_contributors
    # @authors = Author.popular.take(15)
    @authors = []

    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def overview
    @authors = Author.popular.take(8)
    @categories = Category.popular.take(10)
    @authors = []
    @categories = []


    respond_to do |format|
      format.js { render :layout => false }
    end
  end

end