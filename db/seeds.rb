# frozen_string_literal: true

first_name = 'Autr'
phone = '2012987481'
password = 'Test@123'
last_name = 'Mesagutov'
token = SecureRandom.hex(10)

CreateAdminService.call(first_name, last_name, 'autr@ipm.com', password, token, DateTime.now, phone, SecureRandom.uuid)

CreateAdminService.call(first_name, last_name, 'artur@ipm.com', password, token, DateTime.now, phone, SecureRandom.uuid)

Rake::Task['zipcodes:update'].invoke
