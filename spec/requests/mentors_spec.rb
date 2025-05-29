require 'rails_helper'

RSpec.describe 'Mentors', type: :request do
  describe 'GET /mentors' do
    context 'mentors exist' do
      before do
        Mentor.create!(
          first_name: 'Colby',
          last_name: 'Jack',
          email: 'colby.jack@mail.com',
          max_concurrent_students: 4
        )

        Mentor.create!(
          first_name: 'Reggie',
          last_name: 'Ano',
          email: 'reggiano@mail.com',
          max_concurrent_students: 10
        )
      end

      it 'returns a page containing names of all mentors' do
        get '/mentors'
        expect(response.body).to include('First name:')
        expect(response.body).to include('Last name:')
        expect(response.body).to include('Colby')
        expect(response.body).to include('Jack')
        expect(response.body).to include('Reggie')
        expect(response.body).to include('Ano')
      end
    end

    context 'mentors do not exist', type: :request do
      it 'has title "Mentors" and no <li> tags' do
        get '/mentors'
        expect(response.body).to include('Mentors')
        expect(response.body).not_to include('<li>')
      end
    end
  end

  describe 'GET /mentors/:id' do
    let!(:mentor) do
      Mentor.create!(
        first_name: 'Colby',
        last_name: 'Jack',
        email: 'colby.jack@mail.com',
        max_concurrent_students: 4
      )
    end

    it 'returns a page containing the details of a selected mentor' do
      get "/mentors/#{mentor.id}"
      expect(response.body).to include('First name:')
      expect(response.body).to include('Colby')
      expect(response.body).to include('Last name:')
      expect(response.body).to include('Jack')
      expect(response.body).to include('colby.jack@mail.com')
      expect(response.body).to include('4')
    end
  end
end
