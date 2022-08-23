# frozen_string_literal: true

# Create Admin User
CreateAdminService.call('Autr', 'Mesagutov', 'autr@ipm.com', 'Test@123', SecureRandom.hex(10), DateTime.now)

CreateAdminService.call('Autr', 'Mesagutov', 'artur@ipm.com', 'Test@123', SecureRandom.hex(10), DateTime.now)

Rake::Task['zipcodes:update'].invoke
