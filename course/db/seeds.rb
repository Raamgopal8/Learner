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
  },
  {
    title:"The Bits and Bytes of Computer Networking",
    description:"This is a beginner-friendly course that covers the fundamentals of modern networking, protocols, the cloud, and practical troubleshooting.",
    instructor:"Google Staffs",
    duration: 30,
    price: 6999.00,
    level:"Beginner",
    category:"Computer Networking",
    featured:false,
    rating:4.5,
    reviews_count:1235,
    course_icon:"",
    image_url:"https://i.ytimg.com/vi/qiQR5rTSshw/maxresdefault.jpg"
     
  },
  {
    title:"Programming in Python ",
    description:"A fundamental course on Python programming, covering syntax, data types, control flow, functions, and file operations.",
    instructor:"IIT Staffs",
    duration: 40,
    price: "Free",
    level:"Beginner",
    category:"Programming",
    featured:false,
    rating:4.4,
    reviews_count:256,
    course_icon:"",
    image_url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYbsJFulTRg3kb36fs2oHH0rDX5C0uJ6HBDQ&s"
     
  },
  {
    title:"Professional Data Science & AI Course",
    description:"A professional certification course that covers a broad range of topics, including data science, machine learning, and AI applications, with a focus on real-world implementation.",
    instructor:"360DigiTMG",
    duration: 300,
    price: 8999.00,
    level:"Advanced",
    category:"Data Science",
    featured:false,
    rating:4.8,
    reviews_count: 4567,
    course_icon:"",
    image_url:"https://www.cmrit.ac.in/wp-content/uploads/2021/06/artificail.jpg"
     
  },
  {
    title:"Professional Certificate in Cyber Security",
    description:"This program provides skills to protect systems and data from cyber threats through practical application.",
    instructor:"Henry Harvin",
    duration: 144,
    price: 5999.00,
    level:"Advanced",
    category:"Cyber Security",
    featured:false,
    rating:4.7,
    reviews_count: 3345,
    course_icon:"",
    image_url:"https://iirfranking.com/courses/wp-content/uploads/2022/07/Cyber-Security.jpeg"
     
  },
  {
    title:"Google Data Analytics",
    description:"Data Storytelling, Data Visualization, Data Ethics, Tableau, Spreadsheet Software",
    instructor:"Google Staffs",
    duration: 24,
    price: 4999.00,
    level:"Beginner",
    category:"Data Science",
    featured:false,
    rating:4.6,
    reviews_count:1986,
    course_icon:"",
    image_url:"https://www.constructionplacements.com/wp-content/uploads/2021/06/Data-Analytics-Professional-Certificate-Course-by-Google.jpg"
     
  },
  {
    title:"Google Project Management",
    description:"Agile Project Management, Risk Management, Quality Control, Stakeholder Analysis",
    instructor:"Google Staffs",
    duration: 34,
    price: 5666.00,
    level:"Beginner",
    category:"Project Management",
    featured:false,
    rating:4.6,
    reviews_count: 2345,
    course_icon:"",
    image_url:"https://i.ytimg.com/vi/vmwjaY13NPA/maxresdefault.jpg"
     
  },
  {
    title:"Google Digital Marketing & E-commerce",
    description:"Social Media Marketing, Google Ads, Email Marketing, SEO, Customer Retention",
    instructor:"Google Staffs",
    duration: 12,
    price: 3999.00,
    level:"Beginner",
    category:"Digital Marketing",
    featured:false,
    rating:4.2,
    reviews_count: 1345,
    course_icon:"", 
    image_url:"https://ischoolconnect.com/blog/wp-content/uploads/2021/12/Google-digital-marketing-course.jpg"
     
  },
  {
    title:"Google Cloud Platform",
    description:"Google Cloud Platform, Google Cloud Storage, Google Cloud Functions, Google Cloud Run",
    instructor:"Google Staffs",
    duration: 24,
    price: 4999.00,
    level:"Beginner",
    category:"Cloud Computing",
    featured:false,
    rating:4.6,
    reviews_count: 2345,
    course_icon:"", 
    image_url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSr9Vgkrj-sRm4595_33jdj6R_AEtTFFxebvg&s"
     
  },
  {
    title:"Machine Learning",
    description:"Machine Learning, Data Science, Data Analytics, Data Visualization, Data Ethics",
    instructor:"IIT Staffs",
    duration: 30,
    price: 1999.00,
    level:"Advanced",
    category:"Machine Learning",
    featured:false,
    rating:4.5,
    reviews_count: 3345,
    course_icon:"", 
    image_url:"https://i.ytimg.com/vi/i_LwzRVP7bg/maxresdefault.jpg"
     
  },
  {
    title:"IBM GenAI Engineering with Python & LangChain",
    description:"Python, LangChain, PyTorch, Prompt Engineering, Data Wrangling, Flask Web Framework",
    instructor:"IBM Staffs",
    duration: 25,
    price: 6999.00,
    level:"Advanced",
    category:"Machine Learning",
    featured:false,
    rating:4.5,
    reviews_count: 8345,
    course_icon:"", 
    image_url:"https://miro.medium.com/1*O4KnxR3l8-U-IHXE9opfww.png"
     
  },
  {
    title:"Product Management: An Introduction",
    description:"Product Lifecycle, Market Analysis, Stakeholder Communication",
    instructor:"IBM Staffs",
    duration: 40,
    price: 4999.00,
    level:"Beginner",
    category:"Product Management",
    featured:false,
    rating: 3.9, 
    reviews_count: 1893, 
    course_icon:"", 
    image_url:"https://images.credly.com/images/5cf962f0-d790-4652-ad72-d6ad8fa8791c/image.png"

  },
  {
    title:"Cybersecurity Compliance Framework",
    description:"Regulatory Standards, Risk Management, Incident Reporting",
    instructor:"IBM Staffs",
    duration: 35, 
    price: 2555.00, 
    level:"Complex", 
    category:"Cyber Security", 
    featured:false,
    rating: 4.5, 
    reviews_count: 1234, 
    course_icon:"", 
    image_url:"https://www.ducatindia.com/_next/image?url=https%3A%2F%2Fadmin.ducatindia.com%2Fblog%2F1722511880481Cyber%20Security%20Course.jpg&w=750&q=75"

  },
  {
    title:"Business Analysis Fundamentals",
    description:"Requirements Gathering, Data Analysis, Stakeholder Engagement",
    instructor:"Microsoft Staffs",
    duration: 30, 
    price: 2777.00, 
    level:"Beginner", 
    category:"Business Analysis", 
    featured:false,
    rating: 4.5, 
    reviews_count: 1234, 
    course_icon:"", 
    image_url:"https://trendnologies.com/wp-content/uploads/2024/10/BA-800x510-1.jpg"

  },
  {
    title:"Introduction to Computers",
    description:"Basic Computer Architecture, Operating Systems",
    instructor:"Microsoft Staffs",
    duration: 15, 
    price: 500.00, 
    level:"Beginner", 
    category:"Operating Systems", 
    featured:false,
    rating: 4.5, 
    reviews_count: 12345, 
    course_icon:"", 
    image_url:"https://goedu.ac/wp-content/uploads/2024/08/Introduction-to-Liberal-Values-1.jpg"

  },
  {
    title:"Advanced Digital Transformation (IIM Ahmedabad)",
    description:"Digital Strategy, Technology Adoption, Business Models",
    instructor:"IIM",
    duration: 40, 
    price: 999.00, 
    level:"Advanced", 
    category:"Operating Systems", 
    featured:false,
    rating: 3.8 , 
    reviews_count: 1000, 
    course_icon:"", 
    image_url:"https://elearn.nptel.ac.in/wp-content/uploads/2024/10/Digital-Transformation-1.jpg"

  },
  {
    title:"Introduction to Prompt Engineering",
    description:"Working with AI Prompts, Automation, Optimization",
    instructor:"Edx",
    duration: 20, 
    price: 999.00, 
    level:"Beginner", 
    category:"AI", 
    featured:false,
    rating: 4.5, 
    reviews_count: 900, 
    course_icon:"", 
    image_url:"https://media.licdn.com/dms/image/v2/D4D12AQHHv4bCy1yXaw/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1682788840173?e=2147483647&v=beta&t=40i5NOgFJ0V9aaZmVl6m5VkKJl8t1uNp_jr0vwdkr_E"

  },
  {
    title:"JavaScript Programming Essentials",
    description:"JavaScript Syntax, ES6, DOM Manipulation",
    instructor:"IBM",
    duration: 40, 
    price: 1999.00, 
    level:"Beginner", 
    category:"Programming", 
    featured:false,
    rating: 4.5, 
    reviews_count: 600, 
    course_icon:"", 
    image_url:"https://img-c.udemycdn.com/course/480x270/5422984_16fc_2.jpg"

  },
  {
    title:"MBA Essentials",
    description:"Business Fundamentals, Strategy, Finance",
    instructor:"University of Glasgow",
    duration: 60, 
    price: 8000.00, 
    level:"Advanced", 
    category:"Business", 
    featured:false,
    rating: 4.5, 
    reviews_count: 1500, 
    course_icon:"", 
    image_url:"https://www.aimlay.com/wp-content/uploads/2022/11/Business-Management-Course-2-1024x768.jpg"

  },
  {
    title:"Accelerate Your Learning with ChatGPT",
    description:"Learning Strategies, AI Assistance",
    instructor:"Deep Teaching Solutions",
    duration: 5, 
    price: 399.00, 
    level:"Beginner", 
    category:"AI", 
    featured:false,
    rating: 4.6, 
    reviews_count: 5500, 
    course_icon:"", 
    image_url:"https://www.classcentral.com/report/best-chatgpt-courses/chatgpt-bcg-banner/"

  },
  {
    title:"Graphic Design Essentials",
    description:"Adobe tools, Visual Hierarchy, Layout",
    instructor:"LCI Education",
    duration: 35, 
    price: 1500.00, 
    level:"Beginner", 
    category:"UI/UX", 
    featured:false,
    rating: 4.2, 
    reviews_count: 4500, 
    course_icon:"", 
    image_url:"https://maxcomputer.co.in/wp-content/uploads/2024/06/Fundamental-of-Graphic-Coreldraw-Photoshop-Advertisement-Designing-Social-Media-Post-Designing-1024x1024.png"

  },
  {
    title:"Strategy and Game Theory for Management",
    description:"Game Theory Basics, Competitive Strategy",
    instructor:"IIM",
    duration: 60, 
    price: 4500.00, 
    level:"Advanced", 
    category:"Business", 
    featured:false,
    rating: 4.3, 
    reviews_count: 12345, 
    course_icon:"", 
    image_url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBgYNFjw9NhnbfPojZ2YxZim2-uI2t2opxyg&s"

  },
  {
    title:"CS50’s Introduction to Programming with Scratch",
    description:"Intro to Programming Concepts using Scratch",
    instructor:"Hardvard",
    duration: 100, 
    price: 9000.00, 
    level:"Expert", 
    category:"Programming", 
    featured:false,
    rating: 4.8, 
    reviews_count: 12345, 
    course_icon:"", 
    image_url:"https://i.ytimg.com/vi/8mAITcNt710/sddefault.jpg"

  }
]


# Create courses
courses_data.each do |course_data|
  Course.create(course_data)
end

puts "Created #{Course.count} courses"