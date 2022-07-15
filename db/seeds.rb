# frozen_string_literal: true

# Create Admin User
CreateAdminService.call('Autr', 'Mesagutov',
                        'autr@ipm.com', 'Test@123',
                        SecureRandom.hex(10), DateTime.now)
CreateAdminService.call('Autr', 'Mesagutov',
                        'artur@ipm.com', 'Test@123',
                        SecureRandom.hex(10), DateTime.now)

After running seed file run following command

#  1- For development env
     #  rake zipcodes:update
#  2- For production env(heroku)
     #  heroku rake zipcodes:update
