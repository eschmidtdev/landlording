# frozen_string_literal: true

first_name = 'Autr'
password   = 'Test@123'
last_name  = 'Mesagutov'
phone      = '2012987481'
token      = SecureRandom.hex(10)

CreateAdminService.call(first_name, last_name, 'autr@ipm.com', password, token, DateTime.now, phone, SecureRandom.uuid)

CreateAdminService.call(first_name, last_name, 'artur@ipm.com', password, token, DateTime.now, phone, SecureRandom.uuid)

Rake::Task['zipcodes:update'].invoke

Rake::Task['token:access_token'].invoke
