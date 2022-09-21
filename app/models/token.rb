class Token < ApplicationRecord

  def self.create_access_token
    resp = Rocket::GenerateAccessTokenService.call
    return create(access_token: resp['access_token']) unless resp.nil?
  end

end
