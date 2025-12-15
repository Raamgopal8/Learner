require_relative '../config/initializers/db_connections'

puts "Seeding database..."

# -------- Multiple Master Tests --------
master_tests = [
  { title: 'Master Test 1', description: 'All questions combined into a single test', duration: 30 },
  { title: 'Master Test 2', description: 'Mixed domain questions - Technology & Programming', duration: 30 },
  { title: 'Master Test 3', description: 'Mixed domain questions - Systems & Architecture', duration: 30 },
  { title: 'Master Test 4', description: 'Mixed domain questions - Development & Operations', duration: 30 },
  { title: 'Master Test 5', description: 'Mixed domain questions - Advanced Concepts', duration: 30 },
  { title: 'Master Test 6', description: 'Web Development Specialist Test', duration: 30 },
  { title: 'Master Test 7', description: 'Mobile Development Specialist Test', duration: 30 },
  { title: 'Master Test 8', description: 'Data Science & AI Specialist Test', duration: 30 },
  { title: 'Master Test 9', description: 'DevOps & Cloud Specialist Test', duration: 30 },
  { title: 'Master Test 10', description: 'Security & Networking Specialist Test', duration: 30 }
]

test_ids = {}
master_tests.each do |test|
  current_time = Time.now
  DB.exec_params(
    "INSERT INTO tests (title, description, duration_in_minutes, created_at, updated_at)
     VALUES ($1, $2, $3, $4, $5);",
    [test[:title], test[:description], test[:duration], current_time, current_time]
  )
  test_id = DB.exec_params("SELECT id FROM tests WHERE title=$1 LIMIT 1", [test[:title]]).first['id']
  test_ids[test[:title]] = test_id
  puts "#{test[:title]} created with ID #{test_id}."
end

# -------- Questions for Each Master Test --------

# Master Test 1 Questions (Original 25 questions)
master_test_1_questions = [
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
  ['In a CI/CD pipeline, "CI" stands for:', 'Continuous Initialization', 'Continuous Integration', 'Continuous Installation', 'Continuous Implementation', 'B'],
  ['Which principle emphasizes "Users should not have to remember information from one part of the interface to another"?', 'Visibility of system status', 'Recognition rather than recall', 'Consistency and standards', 'Aesthetic and minimalist design', 'B'],
  ['The Golden Ratio is often used in UI design for:', 'Database relationships', 'Layout proportions', 'Color palette generation', 'Typography spacing', 'B'],
  ['Which of these tools is commonly used for UI prototyping?', 'Postman', 'Figma', 'Git', 'Jenkins', 'B'],
  ['What is the key purpose of "Wireframing" in UX design?', 'Define database schema', 'Show final visual design', 'Layout structure and user flow', 'Optimize code performance', 'C'],
  ['Which of the following is a supervised learning algorithm?', 'K-Means Clustering', 'Decision Tree', 'DBSCAN', 'PCA', 'B'],
  ['Overfitting occurs when:', 'The model performs poorly on training data', 'The model generalizes well', 'The model performs well on training but poorly on test data', 'The dataset is too small', 'C'],
  ['What does Gradient Descent optimize?', 'Accuracy directly', 'Cost/Loss function', 'Learning rate', 'Model weights only', 'B'],
  ['Which library is primarily used for deep learning in Python?', 'Pandas', 'TensorFlow', 'NumPy', 'Matplotlib', 'B']
]

# Master Test 2 Questions (Technology & Programming)
master_test_2_questions = [
  ['Which programming language is known as "write once, run anywhere"?', 'C++', 'Java', 'Python', 'JavaScript', 'B'],
  ['What is the primary use case for Rust programming language?', 'Web development only', 'System programming with memory safety', 'Mobile app development', 'Data science', 'B'],
  ['Which JavaScript framework was created by Facebook?', 'Angular', 'Vue', 'React', 'Svelte', 'C'],
  ['What does TypeScript add to JavaScript?', 'Database connectivity', 'Static typing', 'Better performance', 'Automatic testing', 'B'],
  ['Which of the following is a NoSQL database?', 'PostgreSQL', 'MySQL', 'MongoDB', 'SQLite', 'C'],
  ['What is the main advantage of using GraphQL over REST?', 'Faster response times', 'Single endpoint for complex queries', 'Better security', 'Easier to learn', 'B'],
  ['Which Python framework is commonly used for machine learning?', 'Django', 'Flask', 'TensorFlow', 'FastAPI', 'C'],
  ['What is the purpose of Webpack in modern web development?', 'Database management', 'Module bundling', 'User authentication', 'API testing', 'B'],
  ['Which protocol is used for real-time communication in web applications?', 'HTTP', 'HTTPS', 'WebSocket', 'FTP', 'C'],
  ['What is the main difference between SQL and NoSQL databases?', 'Performance', 'Data structure and scalability', 'Security', 'Cost', 'B'],
  ['Which of the following is a functional programming language?', 'Java', 'C++', 'Haskell', 'Python', 'C'],
  ['What is the purpose of a package manager like npm?', 'Code compilation', 'Dependency management', 'Database administration', 'User authentication', 'B'],
  ['Which technology is used for styling web applications?', 'HTML', 'CSS', 'JavaScript', 'SQL', 'B'],
  ['What is the primary benefit of using microservices architecture?', 'Better performance', 'Independent deployment and scaling', 'Lower cost', 'Easier development', 'B'],
  ['Which of the following is a version control system?', 'Jenkins', 'Docker', 'Git', 'Kubernetes', 'C'],
  ['What is the purpose of API documentation?', 'Code optimization', 'Guide developers on how to use APIs', 'Database design', 'User interface design', 'B'],
  ['Which programming paradigm emphasizes immutability and pure functions?', 'Object-oriented', 'Functional', 'Procedural', 'Imperative', 'B'],
  ['What is the main advantage of using TypeScript in large projects?', 'Better performance', 'Type safety and better tooling', 'Smaller bundle size', 'Faster compilation', 'B'],
  ['Which of the following is a front-end framework?', 'Express.js', 'Django', 'Angular', 'Laravel', 'C'],
  ['What is the purpose of unit testing?', 'Database optimization', 'Verify individual components work correctly', 'User interface design', 'Network security', 'B']
]

# Master Test 3 Questions (Systems & Architecture)
master_test_3_questions = [
  ['What is the primary purpose of load balancing?', 'Data backup', 'Distribute network traffic across servers', 'Code compilation', 'User authentication', 'B'],
  ['Which cloud service model provides virtual machines?', 'IaaS', 'PaaS', 'SaaS', 'FaaS', 'A'],
  ['What is the main benefit of containerization?', 'Better user interface', 'Application portability and consistency', 'Database optimization', 'Network security', 'B'],
  ['Which of the following is a message queue system?', 'Redis', 'RabbitMQ', 'PostgreSQL', 'MongoDB', 'B'],
  ['What is the purpose of a reverse proxy?', 'Database connection', 'Client authentication', 'Server load distribution', 'Code compilation', 'C'],
  ['Which database type is best for relationships between entities?', 'Document', 'Key-value', 'Graph', 'Relational', 'D'],
  ['What is the primary advantage of serverless computing?', 'Better performance', 'Pay-per-use without server management', 'More control', 'Better security', 'B'],
  ['Which of the following is a container orchestration tool?', 'Docker', 'Kubernetes', 'Jenkins', 'Git', 'B'],
  ['What is the purpose of CDN (Content Delivery Network)?', 'Database replication', 'Distribute content geographically', 'Code compilation', 'User authentication', 'B'],
  ['Which architecture pattern separates user interface from business logic?', 'Monolithic', 'Microservices', 'MVC', 'Serverless', 'C'],
  ['What is the main purpose of caching?', 'Data backup', 'Improve performance by storing frequently accessed data', 'Code compilation', 'User authentication', 'B'],
  ['Which of the following is a NoSQL database type?', 'Relational', 'Document', 'Hierarchical', 'Network', 'B'],
  ['What is the purpose of API Gateway?', 'Database management', 'Single entry point for multiple services', 'Code compilation', 'User interface design', 'B'],
  ['Which scaling approach involves adding more machines?', 'Vertical scaling', 'Horizontal scaling', 'Database scaling', 'Application scaling', 'B'],
  ['What is the primary benefit of using microservices?', 'Better performance', 'Independent deployment and technology diversity', 'Lower cost', 'Easier development', 'B'],
  ['Which of the following is a service mesh tool?', 'Docker', 'Istio', 'Jenkins', 'Nginx', 'B'],
  ['What is the purpose of blue-green deployment?', 'Database optimization', 'Zero-downtime deployment strategy', 'Code testing', 'User authentication', 'B'],
  ['Which cloud deployment model uses shared infrastructure?', 'Public cloud', 'Private cloud', 'Hybrid cloud', 'Multi-cloud', 'A'],
  ['What is the main advantage of using Kubernetes?', 'Better database performance', 'Container orchestration and management', 'Code compilation', 'User interface design', 'B'],
  ['Which of the following is a configuration management tool?', 'Docker', 'Ansible', 'Git', 'Jenkins', 'B']
]

# Master Test 4 Questions (Development & Operations)
master_test_4_questions = [
  ['What does CI/CD stand for?', 'Continuous Integration/Continuous Deployment', 'Code Integration/Code Development', 'Continuous Testing/Continuous Deployment', 'Code Integration/Continuous Development', 'A'],
  ['Which tool is commonly used for continuous integration?', 'Docker', 'Jenkins', 'Kubernetes', 'Redis', 'B'],
  ['What is the primary purpose of infrastructure as code?', 'Database optimization', 'Manage infrastructure through code', 'User interface design', 'Code compilation', 'B'],
  ['Which of the following is a monitoring tool?', 'Git', 'Docker', 'Prometheus', 'Jenkins', 'C'],
  ['What is the purpose of logging in applications?', 'Code optimization', 'Track events and debug issues', 'Database design', 'User authentication', 'B'],
  ['Which deployment strategy involves gradual traffic shift?', 'Blue-green', 'Canary', 'Rolling', 'Big bang', 'B'],
  ['What is the main benefit of automated testing?', 'Better user interface', 'Consistent and fast validation', 'Database optimization', 'Network security', 'B'],
  ['Which of the following is a configuration management tool?', 'Git', 'Docker', 'Puppet', 'Jenkins', 'C'],
  ['What is the purpose of health checks in microservices?', 'Database optimization', 'Monitor service availability', 'Code compilation', 'User authentication', 'B'],
  ['Which tool is used for containerization?', 'Kubernetes', 'Docker', 'Jenkins', 'Git', 'B'],
  ['What is the primary goal of DevOps?', 'Better user interface', 'Faster and more reliable software delivery', 'Database optimization', 'Network security', 'B'],
  ['Which of the following is a version control system?', 'Jenkins', 'Docker', 'Git', 'Kubernetes', 'C'],
  ['What is the purpose of feature flags?', 'Database management', 'Enable/disable features without deployment', 'Code compilation', 'User authentication', 'B'],
  ['Which monitoring approach focuses on business metrics?', 'Infrastructure monitoring', 'Application monitoring', 'Business monitoring', 'Network monitoring', 'C'],
  ['What is the main advantage of using infrastructure as code?', 'Better performance', 'Consistency and reproducibility', 'Lower cost', 'Better security', 'B'],
  ['Which of the following is a CI/CD pipeline tool?', 'Docker', 'GitLab CI', 'Kubernetes', 'Redis', 'B'],
  ['What is the purpose of chaos engineering?', 'Database optimization', 'Test system resilience through failure injection', 'Code compilation', 'User authentication', 'B'],
  ['Which deployment strategy maintains two identical environments?', 'Blue-green', 'Canary', 'Rolling', 'Big bang', 'A'],
  ['What is the main benefit of observability?', 'Better user interface', 'Understanding system behavior through metrics, logs, and traces', 'Database optimization', 'Network security', 'B'],
  ['Which of the following is a secret management tool?', 'Git', 'Docker', 'Vault', 'Jenkins', 'C']
]

# Master Test 5 Questions (Advanced Concepts)
master_test_5_questions = [
  ['What is the primary focus of quantum computing?', 'Better graphics', 'Quantum mechanical phenomena for computation', 'Faster internet', 'Better batteries', 'B'],
  ['Which AI technique mimics the human brain structure?', 'Decision Trees', 'Neural Networks', 'Random Forest', 'Support Vector Machines', 'B'],
  ['What is the main advantage of blockchain technology?', 'Faster processing', 'Decentralized and immutable ledger', 'Better graphics', 'Lower cost', 'B'],
  ['Which of the following is a distributed consensus algorithm?', 'RSA', 'Proof of Work', 'AES', 'MD5', 'B'],
  ['What is the primary purpose of edge computing?', 'Better graphics', 'Process data closer to the source', 'Faster internet', 'Better batteries', 'B'],
  ['Which technology enables machines to learn from data?', 'Blockchain', 'Machine Learning', 'Cloud Computing', 'Internet of Things', 'B'],
  ['What is the main benefit of 5G networks?', 'Better graphics', 'Higher speed and lower latency', 'Better batteries', 'Lower cost', 'B'],
  ['Which of the following is a cybersecurity framework?', 'NIST', 'Agile', 'Scrum', 'Kanban', 'A'],
  ['What is the primary focus of augmented reality?', 'Virtual worlds only', 'Enhance real world with digital information', 'Better graphics', 'Faster processing', 'B'],
  ['Which technology connects physical devices to the internet?', 'Blockchain', 'Internet of Things', 'Cloud Computing', 'Machine Learning', 'B'],
  ['What is the main advantage of serverless architecture?', 'Better graphics', 'No server management and automatic scaling', 'Better batteries', 'Lower cost', 'B'],
  ['Which of the following is a big data processing framework?', 'React', 'Hadoop', 'Django', 'Laravel', 'B'],
  ['What is the primary purpose of natural language processing?', 'Better graphics', 'Enable computers to understand human language', 'Faster processing', 'Better batteries', 'B'],
  ['Which technology enables secure data sharing without decryption?', 'Blockchain', 'Homomorphic Encryption', 'Quantum Computing', 'Edge Computing', 'B'],
  ['What is the main benefit of microservices architecture?', 'Better performance', 'Independent deployment and scaling', 'Better graphics', 'Lower cost', 'B'],
  ['Which of the following is a cloud-native technology?', 'FTP', 'Kubernetes', 'Telnet', 'SMTP', 'B'],
  ['What is the primary focus of computer vision?', 'Database optimization', 'Enable computers to interpret visual information', 'Network security', 'Code compilation', 'B'],
  ['Which technology enables distributed ledger without central authority?', 'Cloud Computing', 'Blockchain', 'Machine Learning', 'Internet of Things', 'B'],
  ['What is the main advantage of container orchestration?', 'Better graphics', 'Automated container management and scaling', 'Better batteries', 'Lower cost', 'B'],
  ['Which of the following is a zero-trust security principle?', 'Trust but verify', 'Never trust, always verify', 'Trust internal networks', 'Trust external networks', 'B']
]

# Master Test 6 Questions (Web Development)
master_test_6_questions = [
  ['Which HTML5 element is used for navigation links?', '<navigation>', '<nav>', '<menu>', '<links>', 'B'],
  ['What is the purpose of CSS Grid?', 'Database design', 'Two-dimensional layout system', 'Code compilation', 'User authentication', 'B'],
  ['Which JavaScript method is used to select an element by ID?', 'getElementByClass()', 'getElementById()', 'querySelector()', 'selectElement()', 'B'],
  ['What is the main advantage of using CSS preprocessors?', 'Better performance', 'Variables, mixins, and nested rules', 'Smaller file size', 'Faster loading', 'B'],
  ['Which HTTP status code indicates "Not Found"?', '200', '301', '404', '500', 'C'],
  ['What is the purpose of responsive web design?', 'Database optimization', 'Adapt layout to different screen sizes', 'Code compilation', 'User authentication', 'B'],
  ['Which JavaScript framework uses a virtual DOM?', 'Angular', 'Vue', 'React', 'Ember', 'C'],
  ['What is the main purpose of CORS?', 'Database connection', 'Enable cross-origin resource sharing', 'Code compilation', 'User authentication', 'B'],
  ['Which CSS property is used for flexbox layout?', 'display: grid', 'display: flex', 'display: block', 'display: table', 'B'],
  ['What is the purpose of semantic HTML?', 'Better performance', 'Meaningful markup for accessibility and SEO', 'Smaller file size', 'Faster loading', 'B'],
  ['Which JavaScript concept allows handling asynchronous operations?', 'Synchronous programming', 'Promises and async/await', 'Object-oriented programming', 'Functional programming', 'B'],
  ['What is the main advantage of using CSS frameworks?', 'Better performance', 'Pre-built components and utilities', 'Smaller file size', 'Faster development', 'B'],
  ['Which web API is used for making HTTP requests?', 'WebSocket API', 'Fetch API', 'Storage API', 'Geolocation API', 'B'],
  ['What is the purpose of web accessibility?', 'Database optimization', 'Make websites usable for people with disabilities', 'Code compilation', 'User authentication', 'B'],
  ['Which CSS unit is relative to the font size?', 'px', 'em', 'rem', 'vh', 'B'],
  ['What is the main purpose of Progressive Web Apps (PWAs)?', 'Database design', 'Native app-like experience on web', 'Code compilation', 'User authentication', 'B'],
  ['Which JavaScript feature allows destructuring arrays and objects?', 'Classes', 'Destructuring assignment', 'Promises', 'Generators', 'B'],
  ['What is the purpose of CSS animations?', 'Database optimization', 'Create smooth transitions and effects', 'Code compilation', 'User authentication', 'B'],
  ['Which web standard is used for real-time communication?', 'HTTP', 'WebSocket', 'FTP', 'SMTP', 'B'],
  ['What is the main advantage of using TypeScript?', 'Better performance', 'Static typing and better tooling', 'Smaller file size', 'Faster compilation', 'B']
]

# Master Test 7 Questions (Mobile Development)
master_test_7_questions = [
  ['Which platform uses Swift for native development?', 'Android', 'iOS', 'Windows', 'Web', 'B'],
  ['What is the primary purpose of React Native?', 'Database design', 'Build native apps using React', 'Code compilation', 'User authentication', 'B'],
  ['Which Android component manages UI fragments?', 'Service', 'BroadcastReceiver', 'FragmentManager', 'ContentProvider', 'C'],
  ['What is the main advantage of using Flutter?', 'Better performance', 'Single codebase for multiple platforms', 'Smaller app size', 'Faster development', 'B'],
  ['Which mobile development approach uses web technologies?', 'Native development', 'Hybrid development', 'Cross-platform development', 'Desktop development', 'B'],
  ['What is the purpose of mobile app permissions?', 'Database optimization', 'Control access to device features', 'Code compilation', 'User authentication', 'B'],
  ['Which Android layout is best for complex UIs?', 'LinearLayout', 'RelativeLayout', 'ConstraintLayout', 'FrameLayout', 'C'],
  ['What is the main purpose of mobile app testing?', 'Database design', 'Ensure app functionality and usability', 'Code compilation', 'User authentication', 'B'],
  ['Which iOS framework is used for UI development?', 'Core Data', 'SwiftUI', 'Core Location', 'AVFoundation', 'B'],
  ['What is the purpose of mobile app analytics?', 'Database optimization', 'Track user behavior and app performance', 'Code compilation', 'User authentication', 'B'],
  ['Which mobile development tool is used for debugging?', 'Git', 'Android Studio', 'Jenkins', 'Docker', 'B'],
  ['What is the main advantage of native mobile development?', 'Better performance', 'Optimized for specific platform', 'Smaller app size', 'Faster development', 'B'],
  ['Which mobile app distribution platform is for iOS?', 'Google Play', 'App Store', 'Microsoft Store', 'Amazon Appstore', 'B'],
  ['What is the purpose of mobile app security?', 'Database design', 'Protect user data and prevent attacks', 'Code compilation', 'User authentication', 'B'],
  ['Which Android component handles background tasks?', 'Activity', 'Service', 'BroadcastReceiver', 'ContentProvider', 'B'],
  ['What is the main purpose of mobile app optimization?', 'Database optimization', 'Improve performance and battery life', 'Code compilation', 'User authentication', 'B'],
  ['Which iOS development language is newer than Objective-C?', 'Java', 'Swift', 'Kotlin', 'C#', 'B'],
  ['What is the purpose of mobile app prototyping?', 'Database design', 'Create early versions for testing', 'Code compilation', 'User authentication', 'B'],
  ['Which mobile development framework is from Google?', 'React Native', 'Flutter', 'Xamarin', 'Ionic', 'B'],
  ['What is the main advantage of mobile app updates?', 'Better performance', 'Fix bugs and add features', 'Smaller app size', 'Faster development', 'B']
]

# Master Test 8 Questions (Data Science & AI)
master_test_8_questions = [
  ['Which Python library is primarily used for data manipulation?', 'TensorFlow', 'Pandas', 'Scikit-learn', 'PyTorch', 'B'],
  ['What is the purpose of data cleaning?', 'Database design', 'Remove errors and inconsistencies', 'Code compilation', 'User authentication', 'B'],
  ['Which machine learning algorithm is used for classification?', 'Linear Regression', 'Decision Tree', 'K-Means', 'PCA', 'B'],
  ['What is the main purpose of exploratory data analysis?', 'Database optimization', 'Understand data patterns and relationships', 'Code compilation', 'User authentication', 'B'],
  ['Which neural network architecture is best for image recognition?', 'RNN', 'CNN', 'GAN', 'Autoencoder', 'B'],
  ['What is the purpose of feature engineering?', 'Database design', 'Create meaningful input features', 'Code compilation', 'User authentication', 'B'],
  ['Which evaluation metric is used for regression models?', 'Accuracy', 'Precision', 'Mean Squared Error', 'F1 Score', 'C'],
  ['What is the main advantage of deep learning?', 'Better performance', 'Automatic feature extraction', 'Smaller models', 'Faster training', 'B'],
  ['Which Python library is used for deep learning?', 'NumPy', 'Matplotlib', 'TensorFlow', 'Beautiful Soup', 'C'],
  ['What is the purpose of cross-validation?', 'Database optimization', 'Assess model performance on unseen data', 'Code compilation', 'User authentication', 'B'],
  ['Which data visualization library is popular in Python?', 'TensorFlow', 'Pandas', 'Matplotlib', 'Scikit-learn', 'C'],
  ['What is the main purpose of natural language processing?', 'Database design', 'Enable computers to understand human language', 'Code compilation', 'User authentication', 'B'],
  ['Which machine learning technique is unsupervised?', 'Linear Regression', 'Random Forest', 'K-Means Clustering', 'Support Vector Machines', 'C'],
  ['What is the purpose of data preprocessing?', 'Database optimization', 'Prepare data for machine learning', 'Code compilation', 'User authentication', 'B'],
  ['Which AI concept involves machines learning from experience?', 'Rule-based systems', 'Machine Learning', 'Expert systems', 'Symbolic AI', 'B'],
  ['What is the main advantage of ensemble methods?', 'Better performance', 'Combine multiple models for better accuracy', 'Smaller models', 'Faster training', 'B'],
  ['Which Python library is used for statistical computing?', 'TensorFlow', 'SciPy', 'Pandas', 'Matplotlib', 'B'],
  ['What is the purpose of model evaluation?', 'Database design', 'Assess model performance and accuracy', 'Code compilation', 'User authentication', 'B'],
  ['Which deep learning framework is from Facebook?', 'TensorFlow', 'PyTorch', 'Keras', 'MXNet', 'B']
]

# Master Test 9 Questions (DevOps & Cloud)
master_test_9_questions = [
  ['Which cloud service model provides managed databases?', 'IaaS', 'PaaS', 'SaaS', 'FaaS', 'B'],
  ['What is the primary purpose of Docker?', 'Database design', 'Containerize applications', 'Code compilation', 'User authentication', 'B'],
  ['Which tool is used for container orchestration?', 'Docker', 'Kubernetes', 'Jenkins', 'Git', 'B'],
  ['What is the main advantage of cloud computing?', 'Better performance', 'Scalability and pay-per-use pricing', 'Smaller infrastructure', 'Faster development', 'B'],
  ['Which DevOps practice involves frequent code integration?', 'Continuous Deployment', 'Continuous Integration', 'Continuous Testing', 'Continuous Monitoring', 'B'],
  ['What is the purpose of infrastructure as code?', 'Database optimization', 'Manage infrastructure through code', 'Code compilation', 'User authentication', 'B'],
  ['Which cloud provider offers AWS services?', 'Microsoft', 'Google', 'Amazon', 'IBM', 'C'],
  ['What is the main purpose of monitoring in DevOps?', 'Database design', 'Track system performance and issues', 'Code compilation', 'User authentication', 'B'],
  ['Which tool is used for configuration management?', 'Git', 'Docker', 'Ansible', 'Kubernetes', 'C'],
  ['What is the purpose of load balancing?', 'Database optimization', 'Distribute traffic across servers', 'Code compilation', 'User authentication', 'B'],
  ['Which deployment strategy involves gradual rollout?', 'Blue-green deployment', 'Canary deployment', 'Rolling deployment', 'Big bang deployment', 'B'],
  ['What is the main advantage of microservices?', 'Better performance', 'Independent deployment and scaling', 'Smaller codebase', 'Faster development', 'B'],
  ['Which cloud deployment model uses shared infrastructure?', 'Public cloud', 'Private cloud', 'Hybrid cloud', 'Multi-cloud', 'A'],
  ['What is the purpose of CI/CD pipelines?', 'Database design', 'Automate software delivery', 'Code compilation', 'User authentication', 'B'],
  ['Which tool is used for continuous integration?', 'Docker', 'Jenkins', 'Kubernetes', 'Ansible', 'B'],
  ['What is the main purpose of logging in DevOps?', 'Database optimization', 'Track events and debug issues', 'Code compilation', 'User authentication', 'B'],
  ['Which cloud storage service is object-based?', 'Block storage', 'File storage', 'Object storage', 'Database storage', 'C'],
  ['What is the purpose of auto-scaling?', 'Database design', 'Automatically adjust resources based on demand', 'Code compilation', 'User authentication', 'B'],
  ['Which DevOps concept emphasizes collaboration?', 'Waterfall', 'Agile', 'DevOps culture', 'Siloed development', 'C'],
  ['What is the main advantage of serverless computing?', 'Better performance', 'No server management', 'Smaller applications', 'Faster deployment', 'B']
]

# Master Test 10 Questions (Security & Networking)
master_test_10_questions = [
  ['Which encryption algorithm is symmetric?', 'RSA', 'AES', 'ECC', 'DSA', 'B'],
  ['What is the purpose of a firewall?', 'Database design', 'Filter network traffic', 'Code compilation', 'User authentication', 'B'],
  ['Which network protocol is secure?', 'HTTP', 'HTTPS', 'FTP', 'Telnet', 'B'],
  ['What is the main purpose of authentication?', 'Database optimization', 'Verify user identity', 'Code compilation', 'User authorization', 'B'],
  ['Which security concept prevents unauthorized access?', 'Confidentiality', 'Integrity', 'Availability', 'Authorization', 'D'],
  ['What is the purpose of VPN?', 'Database design', 'Secure remote connection', 'Code compilation', 'User authentication', 'B'],
  ['Which attack involves sending fake emails?', 'Phishing', 'DDoS', 'SQL Injection', 'Cross-site Scripting', 'A'],
  ['What is the main purpose of network segmentation?', 'Better performance', 'Isolate network sections for security', 'Smaller networks', 'Faster communication', 'B'],
  ['Which security principle requires multiple authentication factors?', 'Single factor authentication', 'Multi-factor authentication', 'No authentication', 'Biometric authentication', 'B'],
  ['What is the purpose of penetration testing?', 'Database optimization', 'Identify security vulnerabilities', 'Code compilation', 'User authentication', 'B'],
  ['Which network device forwards data packets?', 'Hub', 'Switch', 'Modem', 'Router', 'B'],
  ['What is the main purpose of SSL/TLS?', 'Database design', 'Encrypt network communication', 'Code compilation', 'User authentication', 'B'],
  ['Which security concept ensures data is not altered?', 'Confidentiality', 'Integrity', 'Availability', 'Authentication', 'B'],
  ['What is the purpose of access control?', 'Database optimization', 'Manage resource permissions', 'Code compilation', 'User authentication', 'B'],
  ['Which attack targets web applications?', 'Phishing', 'DDoS', 'SQL Injection', 'Man-in-the-middle', 'C'],
  ['What is the main purpose of network monitoring?', 'Database design', 'Track network performance and security', 'Code compilation', 'User authentication', 'B'],
  ['Which security framework provides guidelines?', 'NIST', 'Agile', 'Scrum', 'Kanban', 'A'],
  ['What is the purpose of data encryption?', 'Database optimization', 'Protect data confidentiality', 'Code compilation', 'User authentication', 'B'],
  ['Which network protocol is used for email?', 'HTTP', 'SMTP', 'FTP', 'SSH', 'B'],
  ['What is the main advantage of zero-trust security?', 'Better performance', 'Never trust, always verify', 'Simpler implementation', 'Lower cost', 'B']
]

# Insert questions for each master test
[
  { test_name: 'Master Test 1', questions: master_test_1_questions },
  { test_name: 'Master Test 2', questions: master_test_2_questions },
  { test_name: 'Master Test 3', questions: master_test_3_questions },
  { test_name: 'Master Test 4', questions: master_test_4_questions },
  { test_name: 'Master Test 5', questions: master_test_5_questions },
  { test_name: 'Master Test 6', questions: master_test_6_questions },
  { test_name: 'Master Test 7', questions: master_test_7_questions },
  { test_name: 'Master Test 8', questions: master_test_8_questions },
  { test_name: 'Master Test 9', questions: master_test_9_questions },
  { test_name: 'Master Test 10', questions: master_test_10_questions }
].each do |test_data|
  test_id = test_ids[test_data[:test_name]]
  current_time = Time.now
  test_data[:questions].each do |q|
    DB.exec_params(
      "INSERT INTO questions (test_id, question, option_a, option_b, option_c, option_d, correct_answer, created_at, updated_at)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)",
      [test_id, q[0], q[1], q[2], q[3], q[4], q[5], current_time, current_time]
    )
  end
  puts "#{test_data[:questions].length} questions seeded for #{test_data[:test_name]}."
end

puts "Questions seeded."
puts "✅ Database seeding complete."
