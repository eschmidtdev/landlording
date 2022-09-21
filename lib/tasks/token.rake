namespace :token do
  desc "Create Access Token"
  task access_token: :environment do
    unless Token.exists?
      puts "--------------------BEGIN CREATE ACCESS TOKEN--------------------"
      resp = Rocket::GenerateAccessTokenService.call
      Token.create!(access_token: resp['access_token']) unless resp.nil?
      puts "--------------------END CREATE ACCESS TOKEN----------------------"
    end
  end

end
