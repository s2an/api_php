class OshwaFacade
  def self.get_oshwa_projects
    response = OshwaService.get_projects
    response["items"].map { |project_data| Oshwa.new(project_data) }
  end

  def self.search_oshwa_projects(q)
    response = OshwaService.search_projects(q)
    response["items"].map { |project_data| Oshwa.new(project_data) }
  end
end
