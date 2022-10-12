# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(DocumentsController, type: :request) do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    allow_any_instance_of(ApplicationController).to(receive(:authenticate_user!).and_return(true))
  end

  describe 'While testing DocumentsController' do
    let(:user) { create(:user) }
    let(:document) { create(:document, user:) }

    describe 'GET /index' do
      it 'Should renders a successful response' do
        login_as(user, scope: :user)
        document
        get '/documents'
        expect(response).to(be_successful)
      end
    end

    describe 'POST /update' do
      context 'with valid parameters' do
        let(:valid_attributes) do
          {
            name: Faker::Company.name
          }
        end

        it 'Should updates the requested document' do
          post '/update/document', params: { document: valid_attributes, id: document.id }
          document.reload
        end

        it 'Should redirects to the documents list' do
          post '/update/document', params: { document: valid_attributes, id: document.id }
          document.reload
          expect(response).to(redirect_to(documents_url))
        end
      end

      context 'with invalid parameters' do
        let(:invalid_attributes) do
          {
            names: nil
          }
        end
        it 'Should redirect documents list' do
          post '/update/document', params: { document: invalid_attributes, id: document.id }
          expect(response).to(redirect_to(documents_url))
        end
      end
    end

    describe 'POST /destroy' do
      it 'destroys the requested Document' do
        access_token_response = Rocket::GenerateAccessTokenService.call
        interview_response = Rocket::CreateInterviewService.call(access_token_response['access_token'], user)
        interview_id = interview_response['interview_id']
        document = Document.create!(name: Faker::Company.name, user_id: user.id, interview_id:)
        post('/delete/document', params: { id: document.id })
        expect(response).to(redirect_to(documents_url))
      end
    end

    describe 'GET /create/interview' do
      context 'with valid Access-Token' do
        it 'Should create a new interview & a new document' do
          expect do
            login_as(user, scope: :user)
            get('/create/interview')
          end.to(change(Document, :count).by(1))
        end
      end
    end
  end
end
