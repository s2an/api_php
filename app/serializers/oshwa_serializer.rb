class OshwaSerializer
  include JSONAPI::Serializer

  set_type :oshwa

  attribute :id do |object|
    object.id.to_s
  end

  attribute :name do |object|
    object.project_name
  end

  attribute :website do |object|
    object.project_website
  end

  attribute :description do |object|
    object.project_description
  end
end
