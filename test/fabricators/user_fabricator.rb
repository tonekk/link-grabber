Fabricator(:user) do
  email { "#{('a'..'z').to_a.shuffle[0,8].join}@congane.de" }
  password   "secret-sauce"
  full_name "Hans Peter"
end
