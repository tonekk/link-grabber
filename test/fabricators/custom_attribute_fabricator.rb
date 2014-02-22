Fabricator(:custom_attribute) do
  # css / js attribute
  target 'size'

  # name of attribute in the database
  name 'attribute'

  # Translated / Pretty Name
  pretty_name 'Attribut'

  # metrics, either: :eq, :gt, :lt, :gte or :lte
  metrics :gt

  # column from xls sheet that is used for this attribute
  xls_col 'A'
end
