Fabricator(:admin) do
  email { "#{('a'..'z').to_a.shuffle[0,8].join}@congane.de" }
  password   "secret-sauce"
end
