# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Seed data for courses
courses_data = [
  {
    title: "Complete Web Development Bootcamp",
    description: "Master HTML, CSS, JavaScript, React, Node.js, and build real-world projects from scratch.",
    instructor: "John Smith",
    duration: 40,
    price: 4999.00,
    level: "Beginner",
    category: "Web Development",
    featured: true,
    rating: 4.8,
    reviews_count: 2345,
    course_icon: "",
    image_url: "https://www.cromacampus.com/public/uploads/Blog/2024/09/week_2/web-development-course-syllabus-for-beginners-66e1713a7bcfc.webp",
    
  },
  {
    title: "UI/UX Design Fundamentals",
    description: "Learn design principles, user research, wireframing, and prototyping for modern interfaces.",
    instructor: "Emily Davis",
    duration: 25,
    price: 3999.00,
    level: "Beginner",
    category: "UI/UX Design",
    featured: true,
    rating: 4.7,
    reviews_count: 1890,
    course_icon: "",
    image_url:"https://prerit.org/wp-content/uploads/2023/11/wp-ui-ux-2.jpg"
  },
  {
    title: "Advanced Web Design",
    description: "Master advanced CSS, responsive design, animations, and modern web design trends.",
    instructor: "Sarah Johnson",
    duration: 30,
    price: 3499.00,
    level: "Intermediate",
    category: "Web Development",
    featured: true,
    rating: 4.6,
    reviews_count: 1234,
    course_icon: "",
    image_url:"https://i.ytimg.com/vi/B-ytMSuwbf8/maxresdefault.jpg"
  },
  {
    title: "Machine Learning with Python",
    description: "Learn supervised and unsupervised learning, neural networks, and build ML applications.",
    instructor: "Dr. Michael Chen",
    duration: 50,
    price: 6999.00,
    level: "Intermediate",
    category: "Machine Learning",
    featured: true,
    rating: 4.9,
    reviews_count: 3456,
    course_icon: "",
    image_url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDAZPV745SBN2A946jSesJS-ukbHuJ2UHh4w&s"
  },
  {
    title: "Data Science Fundamentals",
    description: "Master Python, Pandas, NumPy, visualization, and statistical analysis for data science.",
    instructor: "Lisa Wang",
    duration: 45,
    price: 5499.00,
    level: "Beginner",
    category: "Data Science",
    featured: true,
    rating: 4.8,
    reviews_count: 2789,
    course_icon: "",
    image_url:"https://media.geeksforgeeks.org/wp-content/uploads/20230222183754/Data-Science-Fir-beginner.png"
  },
  {
    title: "Data Structures & Algorithms",
    description: "Master fundamental data structures, algorithms, and problem-solving techniques.",
    instructor: "Prof. David Kumar",
    duration: 35,
    price: 4499.00,
    level: "Intermediate",
    category: "Data Science",
    featured: true,
    rating: 4.7,
    reviews_count: 1923,
    course_icon: "",
    image_url:"https://d3f1iyfxxz8i1e.cloudfront.net/courses/course_image/ac9c836c8dcb.jpg" 
  },
  {
    title: "React & Next.js Development",
    description: "Build modern web applications with React, Next.js, and advanced state management.",
    instructor: "Alex Rodriguez",
    duration: 28,
    price: 4299.00,
    level: "Intermediate",
    category: "Web Development",
    featured: false,
    rating: 4.8,
    reviews_count: 1567,
    course_icon: "",
    image_url:"https://shibajidebnath.com/wp-content/uploads/2024/05/ReactJS-and-Next-JS.jpg.webp"
  },
  {
    title: "Advanced UI/UX Design",
    description: "Master advanced design principles, user research, prototyping, and design systems.",
    instructor: "Emily Davis",
    duration: 32,
    price: 6999.00,
    level: "Advanced",
    category: "UI/UX Design",
    featured: false,
    rating: 4.9,
    reviews_count: 756,
    course_icon: "",
    image_url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ0l1MKP73zUH3sWSveRNp5kKb_yxY1RxA4g&s"
  },
  {
    title: "Deep Learning Specialization",
    description: "Master neural networks, CNNs, RNNs, and build AI applications with TensorFlow.",
    instructor: "Dr. Priya Sharma",
    duration: 60,
    price: 8999.00,
    level: "Advanced",
    category: "Machine Learning",
    featured: false,
    rating: 4.9,
    reviews_count: 2341,
    course_icon: "",
    image_url:"https://media.licdn.com/dms/image/v2/C5112AQHpwRXopYdAVw/article-cover_image-shrink_600_2000/article-cover_image-shrink_600_2000/0/1520135350743?e=2147483647&v=beta&t=qwoBo7bxzLewrU0bf7m6G3LeNMlPukfhCcaH0iDs8Wo"
  },
  {
    title: "Big Data Analytics",
    description: "Learn Hadoop, Spark, data warehousing, and analytics for large-scale data processing.",
    instructor: "James Wilson",
    duration: 40,
    price: 6499.00,
    level: "Advanced",
    category: "Data Science",
    featured: false,
    rating: 4.6,
    reviews_count: 987,
    course_icon: "",
    image_url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyKnST6LMgwdFCrnbMGuz5vs9LtkOEUz40Bg&s"
  },
  {
    title: "Mobile App Design",
    description: "Design beautiful and functional mobile apps with modern UI/UX principles.",
    instructor: "Tom Anderson",
    duration: 22,
    price: 3299.00,
    level: "Beginner",
    category: "UI/UX Design",
    featured: false,
    rating: 4.5,
    reviews_count: 654,
    course_icon: "",
    image_url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqQmC115q4ZakbGJpo2SXRL2zm_vpHNUuaQw&s"
  },
  {
    title: "Full Stack JavaScript",
    description: "Master MERN stack development with MongoDB, Express.js, React, and Node.js.",
    instructor: "Maria Garcia",
    duration: 55,
    price: 5999.00,
    level: "Intermediate",
    category: "Web Development",
    featured: false,
    rating: 4.8,
    reviews_count: 2034,
    course_icon: "",
    image_url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjXw_-RlA_CQ9SYF3EVkT-J4F2VL79eKGAtw&s"
  }
]

# Create courses
courses_data.each do |course_data|
  Course.create(course_data)
end

puts "Created #{Course.count} courses"
