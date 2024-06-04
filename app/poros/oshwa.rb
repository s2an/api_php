# Purpose: This class is a PORO (Plain Old Ruby Object) that is used to store the data from the OSHWA API.
# It is used to create an instance of the class with the data from the API response.

class Oshwa
  attr_accessor :id,
                :oshwa_uid,
                :responsible_party,
                :country,
                :public_contact,
                :project_name,
                :project_website,
                :project_version,
                :project_description,
                :primary_type,
                :additional_type,
                :project_keywords,
                :hardware_license,
                :software_license,
                :documentation_license,
                :certification_date

  def initialize(data)
    # id is needed for the serializer to work
    @id = data["id"]
    # @desired_attribute = data["desiredAttribute"] converts camelCase to snake_case
    @oshwa_uid = data["oshwaUid"]
    @responsible_party = data["responsibleParty"]
    @country = data["country"]
    @public_contact = data["publicContact"]
    @project_name = data["projectName"]
    @project_website = data["projectWebsite"]
    @project_version = data["projectVersion"]
    @project_description = data["projectDescription"]
    @primary_type = data["primaryType"]
    @additional_type = data["additionalType"]
    @project_keywords = data["projectKeywords"]
    @hardware_license = data["hardwareLicense"]
    @software_license = data["softwareLicense"]
    @documentation_license = data["documentationLicense"]
    @certification_date = data["certificationDate"]
  end
end
