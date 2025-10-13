puts "Seeding TutorX Test Platform..."

# ------------------------
# 1. Users
# ------------------------
admin = User.create!(
  email: 'admin@tutorx.com',
  password: 'admin123',
  first_name: 'Admin',
  last_name: 'User',
  role: 'admin'
)

teacher = User.create!(
  email: 'teacher@tutorx.com',
  password: 'teacher123',
  first_name: 'John',
  last_name: 'Teacher',
  role: 'teacher'
)

student = User.create!(
  email: 'student@tutorx.com',
  password: 'student123',
  first_name: 'Alice',
  last_name: 'Student',
  role: 'student'
)

# ------------------------
# 2. Tests
# ------------------------
math_test = Test.create!(
  title: 'Basic Algebra Quiz',
  duration_minutes: 30,
  created_by: teacher
)

science_test = Test.create!(
  title: 'General Science Knowledge',
  duration_minutes: 25,
  created_by: teacher
)

# ------------------------
# 3. Questions & Options
# Math Test
# ------------------------
math_q1 = Question.create!(
  test: math_test,
  text: 'What is the value of x in: 2x + 3 = 7?',
  position: 1
)
math_q1_opt1 = Option.create!(question: math_q1, text: 'x = 2', correct: true)
Option.create!(question: math_q1, text: 'x = 3', correct: false)
Option.create!(question: math_q1, text: 'x = 4', correct: false)

math_q2 = Question.create!(
  test: math_test,
  text: 'Solve: 3y - 5 = 10',
  position: 2
)
Option.create!(question: math_q2, text: 'y = 3', correct: false)
math_q2_opt2 = Option.create!(question: math_q2, text: 'y = 5', correct: true)
Option.create!(question: math_q2, text: 'y = 7', correct: false)

math_q3 = Question.create!(
  test: math_test,
  text: 'What is the square root of 144?',
  position: 3
)
Option.create!(question: math_q3, text: '10', correct: false)
math_q3_opt2 = Option.create!(question: math_q3, text: '12', correct: true)
Option.create!(question: math_q3, text: '14', correct: false)

# Science Test
science_q1 = Question.create!(
  test: science_test,
  text: 'What is the chemical symbol for gold?',
  position: 1
)
Option.create!(question: science_q1, text: 'Go', correct: false)
science_q1_opt2 = Option.create!(question: science_q1, text: 'Au', correct: true)
Option.create!(question: science_q1, text: 'Ag', correct: false)

science_q2 = Question.create!(
  test: science_test,
  text: 'Which planet is known as the Red Planet?',
  position: 2
)
Option.create!(question: science_q2, text: 'Venus', correct: false)
science_q2_opt2 = Option.create!(question: science_q2, text: 'Mars', correct: true)
Option.create!(question: science_q2, text: 'Jupiter', correct: false)

# ------------------------
# 4. Attempt & Answers
# ------------------------
# Creating an attempt for the student on math_test
attempt = Attempt.create!(
  user: student,
  test: math_test,
  started_at: 1.hour.ago,
  finished_at: 45.minutes.ago,
  submitted: true
)

# Answers (link correct options explicitly)
Answer.create!(attempt: attempt, question: math_q1, option: math_q1_opt1)
Answer.create!(attempt: attempt, question: math_q2, option: math_q2_opt2)
Answer.create!(attempt: attempt, question: math_q3, option: math_q3_opt2)

puts "Seed data created successfully!"
puts "Summary:"
puts "Users: #{User.count}, Tests: #{Test.count}, Questions: #{Question.count}, Options: #{Option.count}, Attempts: #{Attempt.count}, Answers: #{Answer.count}"
