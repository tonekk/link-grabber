require 'zip'
class AddTopos < Mongoid::Migration
  def self.up
    Dir.glob(Rails.root.join('data', '*.topojson').to_s) do |file|
      filename = File.basename(file, File.extname(file))
      a = filename.scan(/([a-z_]+)_(\d+)$/)[0]
      class_name = a.first.camelcase
      id = a.second

      object = eval(class_name).find_or_create(id)
      object.topology = IO.read(file)
      object.save!

      puts "Added topology to #{object.class.to_s} with identifier #{object.identifier}"
    end
  end

  def self.down
  end
end
