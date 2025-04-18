require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  let(:student) do
    Student.create(first_name: 'Colby', last_name: 'Jack', email: 'colbyjack@email.com')
  end

  let(:coding_class) do
    CodingClass.create(title: 'Test Class')
  end

  let(:trimester) do
    Trimester.create(
      year: '2025',
      term: 'Winter',
      start_date: '2025-01-01',
      end_date: '2025-04-30',
      application_deadline: '2025-12-15'
    )
  end

  let(:course) do
    Course.create(coding_class_id: coding_class.id, trimester_id: trimester.id, max_enrollment: 14)
  end

  let(:enrollment) do
    Enrollment.create(course_id: course.id, student_id: student.id)
  end

  describe 'is_past_application_deadline?' do
    it 'is valid if the enrollments creation is later than the application deadline' do
      expect(enrollment.is_past_application_deadline?).to eq(false)
    end
    it 'is not valid if the enrollments creation is later than the application deadline' do
      trimester2 = Trimester.create(
        year: '2025',
        term: 'Winter',
        start_date: '2025-01-01',
        end_date: '2025-04-30',
        application_deadline: '2023-12-15'
      )
      course2 = Course.create(coding_class_id: coding_class.id, trimester_id: trimester2.id, max_enrollment: 14)
      enrollment2 = Enrollment.create(course_id: course2.id, student_id: student.id)
      expect(enrollment2.is_past_application_deadline?).to eq(true)
    end
  end
end
