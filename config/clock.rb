require 'clockwork'

require File.expand_path("../../config/boot", __FILE__)
require File.expand_path("../../config/environment", __FILE__)

module Clockwork
  #every(5.minutes, 'geocoding.job'){GeocodingWorker.perform_async}
  every(10.seconds, 'import.excel.job'){ExcelImportWorker.perform_async}
end
