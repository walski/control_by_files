RAILS_ROOT = '.'
$LOAD_PATH << RAILS_ROOT + '/vendor/plugins/control_by_files/lib/'

require 'controllers/base'
require 'controllers/rake'

controllers = [ControlByFiles::Controllers::Rake.new]

controllers.each do |controller|
  controller.run
end
