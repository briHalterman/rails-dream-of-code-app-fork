require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
    it 'returns 200 OK status' do
      get '/dashboard'

      expect(response).to have_http_status(:ok)
    end
  end
end
