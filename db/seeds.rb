# frozen_string_literal: true

admin = OpenStruct.new(
  f_name: 'Artur',
  l_name: 'Masagutov',
  phone: '2012987481',
  password: 'Test@123',
  email: 'artur@ipm.com',
  token: SecureRandom.hex(10),
  uuid: SecureRandom.uuid,
  date: DateTime.now
)

CreateAdminService.call(admin.f_name,
                        admin.l_name,
                        admin.email,
                        admin.password,
                        admin.token,
                        admin.date,
                        admin.phone,
                        admin.uuid
                       )

Rake::Task['zipcodes:update'].invoke

Rake::Task['token:access_token'].invoke
