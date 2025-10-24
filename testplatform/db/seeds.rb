require_relative '../config/initializers/db_connections'

puts "Seeding database..."

# -------- Users --------
users = [
  { name: 'Alice Johnson', email: 'alice@example.com' }
]

users.each do |u|
  DB.exec_params(
    "INSERT INTO users (name, email) VALUES ($1, $2)",
    [u[:name], u[:email]]
  )
end
puts "Users seeded."

# -------- Single Combined Test --------
DB.exec_params(
  "INSERT INTO tests (title, description, duration_in_minutes)
   VALUES ($1, $2, $3);",
  ['Master Test', 'All questions combined into a single test', 60]
)

# Get test ID
test_id = DB.exec_params("SELECT id FROM tests WHERE title=$1 LIMIT 1", ['Master Test']).first['id']

puts "Master Test created with ID #{test_id}."

# -------- Questions --------
questions = [
  ['Which of the following is not a JavaScript framework?', 'React', 'Angular', 'Laravel', 'Vue', 'C'],
  ['In HTTP, which status code indicates a successful request?', '200', '301', '404', '500', 'A'],
  ['What does CSS stand for?', 'Cascading Script Sheets', 'Cascading Style Sheets', 'Computer Style Sheets', 'Color Styling System', 'B'],
  ['Which of the following is used to manage dependencies in Node.js?', 'PIP', 'NPM', 'Composer', 'Maven', 'B'],
  ['Which language is primarily used for developing iOS applications?', 'Kotlin', 'Dart', 'Swift', 'Java', 'C'],
  ['Flutter uses which programming language?', 'Java', 'Dart', 'Kotlin', 'TypeScript', 'B'],
  ['Which Android component is responsible for responding to user interaction with the app?', 'Fragment', 'Intent', 'Activity', 'BroadcastReceiver', 'C'],
  ['What is the purpose of Gradle in Android development?', 'UI Designing', 'Version Control', 'Build Automation', 'Code Compilation only', 'C'],
  ['The MERN stack includes:', 'MySQL, Express, React, Node', 'MongoDB, Express, React, Node', 'MongoDB, Ember, Rails, Node', 'Meteor, Express, React, Node', 'B'],
  ['Which HTTP method is used to update existing data in a REST API?', 'POST', 'PUT', 'GET', 'DELETE', 'B'],
  ['Which of the following best describes JWT (JSON Web Token)?', 'Encryption algorithm', 'Authentication token format', 'JavaScript library', 'Server configuration file', 'B'],
  ['In a CI/CD pipeline, “CI” stands for:', 'Continuous Initialization', 'Continuous Integration', 'Continuous Installation', 'Continuous Implementation', 'B'],
  ['Which principle emphasizes ''Users should not have to remember information from one part of the interface to another''?', 'Visibility of system status', 'Recognition rather than recall', 'Consistency and standards', 'Aesthetic and minimalist design', 'B'],
  ['The Golden Ratio is often used in UI design for:', 'Database relationships', 'Layout proportions', 'Color palette generation', 'Typography spacing', 'B'],
  ['Which of these tools is commonly used for UI prototyping?', 'Postman', 'Figma', 'Git', 'Jenkins', 'B'],
  ['What is the key purpose of ''Wireframing'' in UX design?', 'Define database schema', 'Show final visual design', 'Layout structure and user flow', 'Optimize code performance', 'C'],
  ['Which of the following is a supervised learning algorithm?', 'K-Means Clustering', 'Decision Tree', 'DBSCAN', 'PCA', 'B'],
  ['Overfitting occurs when:', 'The model performs poorly on training data', 'The model generalizes well', 'The model performs well on training but poorly on test data', 'The dataset is too small', 'C'],
  ['What does Gradient Descent optimize?', 'Accuracy directly', 'Cost/Loss function', 'Learning rate', 'Model weights only', 'B'],
  ['Which library is primarily used for deep learning in Python?', 'Pandas', 'TensorFlow', 'NumPy', 'Matplotlib', 'B'],
  ['Which of the following techniques allows an AI model to learn from interaction with the environment?', 'Supervised Learning', 'Reinforcement Learning', 'Semi-supervised Learning', 'Transfer Learning', 'B'],
  ['The attention mechanism is a key concept in:', 'Decision Trees', 'Recurrent Neural Networks', 'Transformers', 'Naive Bayes Classifiers', 'C'],
  ['What is the purpose of Natural Language Processing (NLP)?', 'Image classification', 'Analyzing time series', 'Understanding human language', 'Generating SQL queries', 'C'],
  ['Which data structure uses FIFO (First In, First Out) principle?', 'Stack', 'Queue', 'Tree', 'Graph', 'B'],
  ['What is the time complexity of binary search on a sorted array?', 'O(n)', 'O(log n)', 'O(n²)', 'O(1)', 'B']
]

questions.each do |q|
  DB.exec_params(
    "INSERT INTO questions (test_id, question, option_a, option_b, option_c, option_d, correct_answer)
     VALUES ($1, $2, $3, $4, $5, $6, $7)",
    [test_id, q[0], q[1], q[2], q[3], q[4], q[5]]
  )
end

puts "Questions seeded."
puts "✅ Database seeding complete."
