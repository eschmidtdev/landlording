# frozen_string_literal: true

# Create Admin User
CreateAdminService.new(
  'Admin User',
  'admin@ipm.com',
  'Test@123',
  SecureRandom.hex(10),
  DateTime.now
).call
