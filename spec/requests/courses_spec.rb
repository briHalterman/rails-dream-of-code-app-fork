require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  describe 'GET /courses/:id' do
    let!(:course) do
      coding_class = CodingClass.create!(title: 'RSpec Testing')

      trimester = Trimester.create!(
        term: 'Spring',
        year: Date.today.year.to_s,
        start_date: Date.today,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )

      course = Course.create!(
        coding_class: coding_class,
        trimester: trimester,
        max_enrollment: 25
      )

      student1 = Student.create!(
        first_name: 'Colby',
        last_name: 'Johnson',
        email: 'colby.jack@email.com'
      )

      student2 = Student.create!(
        first_name: 'Reggie',
        last_name: 'Ano',
        email: 'parmigiano-reggiano@email.com'
      )

      student3 = Student.create!(
        first_name: 'Al',
        last_name: 'Fredo',
        email: 'fettucine_alfredo@email.com'
      )

      Enrollment.create!(course: course, student: student1)
      Enrollment.create!(course: course, student: student2)
      Enrollment.create!(course: course, student: student3)

      course
    end

    it 'displays the course name and enrolled students' do
      get "/courses/#{course.id}"

      expect(response.body).to include('RSpec Testing')
      expect(response.body).to include('Colby Johnson')
      expect(response.body).to include('Reggie Ano')
      expect(response.body).to include('Al Fredo')
    end
  end
end
