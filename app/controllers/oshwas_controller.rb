class OshwasController < ApplicationController
  def index
    @projects = OshwaFacade.get_oshwa_projects
  end
end