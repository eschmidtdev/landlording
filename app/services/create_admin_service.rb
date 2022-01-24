class CreateAdminService
  def call
    user = User.create!(email: "test@example.com", password: "test123")
  end
end
