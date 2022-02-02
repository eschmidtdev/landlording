class CreateAdminService
  def call
    User.create!(email: "test@example.com", password: "test123")
  end
end
