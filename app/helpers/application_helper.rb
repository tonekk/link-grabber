module ApplicationHelper
  # JSON for canJS
  def can_json(object, options={})
    "{\"data\":#{object.to_json(options)}}"
  end
end
