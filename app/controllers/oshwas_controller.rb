class OshwasController < ApplicationController
  def index
    projects = OshwaFacade.get_oshwa_projects
    @oshwas = WillPaginate::Collection.create(params[:page] || 1, 10, projects.size) do |pager|
      pager.replace projects[pager.offset, pager.per_page]
    end
  end
end