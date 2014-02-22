Fabricator(:lead) do
  first_name "Bernd"
  last_name { ('a'..'z').to_a.shuffle[0,8].join }

  after_build do |lead|
    lead.address = Fabricate.build(:address)
  end
end
