Fabricator(:lead_class) do
  name "Doctor"
  street_col "A"
  city_col "B"
  part_of_town_col "C"
  zip_col "D"

  custom_attributes(count: 1)
end
