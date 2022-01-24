class CreateAdminService
  def call
    user = User.find_or_create_by!(email: "test@example.com", password: "test123")
  end
end
