# Enhanced Sample Course Data Script
# Run this in Rails console: rails console

# Comprehensive syllabus with detailed modules and lessons
detailed_syllabus = {
  "modules" => [
    {
      "title" => "Introduction to Web Development",
      "lessons" => [
        {
          "title" => "What is Web Development?",
          "description" => "Explore the world of web development, understanding frontend, backend, and full-stack development. Learn about the modern web ecosystem and career opportunities.",
          "duration" => "20 min",
          "completed" => false
        },
        {
          "title" => "How the Web Works",
          "description" => "Deep dive into HTTP/HTTPS protocols, DNS, servers, and clients. Understand request-response cycles and how browsers render web pages.",
          "duration" => "25 min",
          "completed" => false
        },
        {
          "title" => "Setting Up Your Development Environment",
          "description" => "Install and configure VS Code, Node.js, Git, and essential extensions. Set up your first project structure and learn about package managers.",
          "duration" => "30 min",
          "completed" => false
        },
        {
          "title" => "Version Control with Git",
          "description" => "Master Git fundamentals including commits, branches, merges, and GitHub workflows. Learn best practices for collaborative development.",
          "duration" => "35 min",
          "completed" => false
        }
      ]
    },
    {
      "title" => "HTML5 Fundamentals",
      "lessons" => [
        {
          "title" => "HTML Document Structure",
          "description" => "Learn the anatomy of an HTML document including DOCTYPE, head, body, and meta tags. Understand document flow and nesting rules.",
          "duration" => "25 min",
          "completed" => false
        },
        {
          "title" => "Text Content and Formatting",
          "description" => "Master headings, paragraphs, lists, links, and text formatting elements. Learn when to use semantic vs presentational markup.",
          "duration" => "30 min",
          "completed" => false
        },
        {
          "title" => "Semantic HTML5 Elements",
          "description" => "Explore semantic elements like header, nav, main, article, section, aside, and footer. Understand their importance for accessibility and SEO.",
          "duration" => "35 min",
          "completed" => false
        },
        {
          "title" => "Forms and Input Elements",
          "description" => "Build interactive forms with various input types, validation, labels, and accessibility features. Learn about form submission and handling.",
          "duration" => "40 min",
          "completed" => false
        },
        {
          "title" => "Multimedia and Embedding",
          "description" => "Work with images, audio, video, iframes, and SVG graphics. Learn optimization techniques and responsive media handling.",
          "duration" => "30 min",
          "completed" => false
        },
        {
          "title" => "HTML Tables and Data Presentation",
          "description" => "Create accessible data tables with proper structure, headers, captions, and styling. Learn when tables are appropriate.",
          "duration" => "25 min",
          "completed" => false
        }
      ]
    },
    {
      "title" => "CSS3 Styling and Layout",
      "lessons" => [
        {
          "title" => "CSS Fundamentals and Selectors",
          "description" => "Master CSS syntax, selectors (element, class, ID, attribute, pseudo-classes, pseudo-elements), specificity, and the cascade.",
          "duration" => "35 min",
          "completed" => false
        },
        {
          "title" => "Box Model and Positioning",
          "description" => "Understand the CSS box model, margin, padding, border, and different positioning schemes (static, relative, absolute, fixed, sticky).",
          "duration" => "40 min",
          "completed" => false
        },
        {
          "title" => "Flexbox Layout System",
          "description" => "Master Flexbox for one-dimensional layouts. Learn flex containers, items, direction, wrapping, alignment, and common patterns.",
          "duration" => "45 min",
          "completed" => false
        },
        {
          "title" => "CSS Grid Layout System",
          "description" => "Build complex two-dimensional layouts with CSS Grid. Understand grid containers, tracks, areas, and responsive grid patterns.",
          "duration" => "50 min",
          "completed" => false
        },
        {
          "title" => "Responsive Web Design",
          "description" => "Create mobile-first responsive designs using media queries, fluid grids, flexible images, and modern CSS techniques.",
          "duration" => "45 min",
          "completed" => false
        },
        {
          "title" => "CSS Animations and Transitions",
          "description" => "Add life to your designs with CSS transitions, keyframe animations, transforms, and performance optimization techniques.",
          "duration" => "40 min",
          "completed" => false
        },
        {
          "title" => "Modern CSS Features",
          "description" => "Explore CSS variables, calc(), clamp(), min(), max(), aspect-ratio, and other modern CSS features for maintainable stylesheets.",
          "duration" => "35 min",
          "completed" => false
        }
      ]
    },
    {
      "title" => "JavaScript Programming",
      "lessons" => [
        {
          "title" => "JavaScript Basics and Syntax",
          "description" => "Learn variables, data types, operators, control structures, and basic programming concepts in JavaScript.",
          "duration" => "40 min",
          "completed" => false
        },
        {
          "title" => "Functions and Scope",
          "description" => "Master function declarations, expressions, arrow functions, closures, and scope (global, function, block).",
          "duration" => "45 min",
          "completed" => false
        },
        {
          "title" => "Arrays and Objects",
          "description" => "Work with arrays, objects, destructuring, spread operator, and modern array methods (map, filter, reduce, etc.).",
          "duration" => "50 min",
          "completed" => false
        },
        {
          "title" => "DOM Manipulation",
          "description" => "Select, create, modify, and remove DOM elements. Handle events and build interactive user interfaces.",
          "duration" => "55 min",
          "completed" => false
        },
        {
          "title" => "Asynchronous JavaScript",
          "description" => "Understand callbacks, promises, async/await, and handling asynchronous operations. Work with APIs and fetch data.",
          "duration" => "60 min",
          "completed" => false
        },
        {
          "title" => "ES6+ Modern Features",
          "description" => "Explore modern JavaScript features including modules, classes, template literals, optional chaining, and nullish coalescing.",
          "duration" => "45 min",
          "completed" => false
        }
      ]
    },
    {
      "title" => "Advanced Web Development",
      "lessons" => [
        {
          "title" => "Web Performance Optimization",
          "description" => "Learn techniques for optimizing load times, rendering performance, and user experience. Use Chrome DevTools for profiling.",
          "duration" => "50 min",
          "completed" => false
        },
        {
          "title" => "Web Accessibility (A11y)",
          "description" => "Build accessible websites following WCAG guidelines. Implement ARIA, keyboard navigation, and screen reader support.",
          "duration" => "45 min",
          "completed" => false
        },
        {
          "title" => "Progressive Web Apps (PWA)",
          "description" => "Create installable, offline-capable web apps using service workers, manifest files, and caching strategies.",
          "duration" => "60 min",
          "completed" => false
        },
        {
          "title" => "Web Security Best Practices",
          "description" => "Understand common vulnerabilities (XSS, CSRF, SQL injection) and implement security measures to protect your applications.",
          "duration" => "55 min",
          "completed" => false
        }
      ]
    },
    {
      "title" => "Real-World Projects",
      "lessons" => [
        {
          "title" => "Project 1: Portfolio Website",
          "description" => "Build a responsive portfolio website showcasing your skills, projects, and contact information using HTML, CSS, and JavaScript.",
          "duration" => "120 min",
          "completed" => false
        },
        {
          "title" => "Project 2: Interactive Dashboard",
          "description" => "Create a data visualization dashboard with charts, filters, and real-time updates using modern JavaScript and APIs.",
          "duration" => "150 min",
          "completed" => false
        },
        {
          "title" => "Project 3: E-commerce Product Page",
          "description" => "Develop a fully functional e-commerce product page with image gallery, cart functionality, and checkout flow.",
          "duration" => "180 min",
          "completed" => false
        },
        {
          "title" => "Final Capstone Project",
          "description" => "Build a complete full-stack web application of your choice, implementing all concepts learned throughout the course.",
          "duration" => "240 min",
          "completed" => false
        }
      ]
    }
  ]
}

# Comprehensive learning outcomes
detailed_outcomes = [
  "Build fully responsive, mobile-first websites from scratch using semantic HTML5, modern CSS3, and vanilla JavaScript",
  "Master advanced CSS layout techniques including Flexbox and Grid to create complex, professional layouts",
  "Implement interactive user interfaces with DOM manipulation, event handling, and asynchronous JavaScript",
  "Develop Progressive Web Apps (PWAs) with offline capabilities, service workers, and installable features",
  "Apply web accessibility (A11y) best practices following WCAG guidelines to ensure inclusive user experiences",
  "Optimize web performance using lazy loading, code splitting, image optimization, and caching strategies",
  "Secure web applications against common vulnerabilities including XSS, CSRF, and injection attacks",
  "Use Git and GitHub for version control, collaboration, and deploying projects to production",
  "Debug and troubleshoot code efficiently using browser DevTools and modern debugging techniques",
  "Build and deploy real-world projects including portfolios, dashboards, and e-commerce applications",
  "Understand modern web development workflows, build tools, and package managers (npm, webpack, Vite)",
  "Write clean, maintainable, and well-documented code following industry best practices and coding standards"
]

# Detailed course content
detailed_content = <<~CONTENT
  Welcome to the Complete Web Development Bootcamp - your comprehensive journey from absolute beginner to job-ready web developer!

  This intensive, project-based course is designed to take you through every aspect of modern web development. Whether you're looking to start a new career, build your own projects, or enhance your existing skills, this course provides everything you need to succeed in today's competitive tech industry.

  **What Makes This Course Special:**

  Unlike other courses that only scratch the surface, we dive deep into each technology while maintaining a practical, hands-on approach. You'll not only learn the "how" but also the "why" behind every concept, giving you the understanding needed to solve real-world problems independently.

  **Course Structure:**

  The course is organized into six comprehensive modules, each building upon the previous one:

  1. **Foundation Module**: Start with the fundamentals of how the web works, set up your professional development environment, and master Git for version control. You'll understand the big picture before diving into code.

  2. **HTML5 Mastery**: Learn to structure web content semantically, making your websites accessible, SEO-friendly, and maintainable. We cover everything from basic elements to advanced forms and multimedia integration.

  3. **CSS3 Excellence**: Transform your HTML into beautiful, responsive designs. Master modern layout systems (Flexbox and Grid), create smooth animations, and build mobile-first responsive websites that work flawlessly on any device.

  4. **JavaScript Proficiency**: Bring your websites to life with interactivity. From basic programming concepts to advanced asynchronous operations, you'll become proficient in modern JavaScript (ES6+) and DOM manipulation.

  5. **Advanced Concepts**: Take your skills to the next level with performance optimization, web accessibility, Progressive Web Apps, and security best practices. Learn to build production-ready applications.

  6. **Real-World Projects**: Apply everything you've learned by building four comprehensive projects, culminating in a full-stack capstone project that will be the centerpiece of your portfolio.

  **Learning Approach:**

  - **Hands-On Practice**: Every concept is reinforced with practical exercises and coding challenges
  - **Project-Based Learning**: Build real applications, not just toy examples
  - **Modern Best Practices**: Learn industry-standard tools, workflows, and coding conventions
  - **Career-Focused**: Develop skills that employers are actively seeking
  - **Continuous Support**: Access to community forums, code reviews, and instructor guidance

  **Who This Course Is For:**

  - Complete beginners with no prior programming experience
  - Self-taught developers looking to fill knowledge gaps
  - Designers wanting to implement their own designs
  - Entrepreneurs building their own web products
  - Anyone looking to transition into a tech career

  **Prerequisites:**

  No prior experience required! Just bring your curiosity, dedication, and a computer with internet access.

  **What You'll Build:**

  By the end of this course, you'll have a portfolio of professional projects including:
  - A stunning personal portfolio website
  - An interactive data visualization dashboard
  - A fully functional e-commerce product page
  - Your own custom full-stack web application

  **Career Outcomes:**

  Graduates of this course have gone on to:
  - Land junior developer positions at tech companies
  - Freelance as web developers
  - Build and launch their own web products
  - Transition from other careers into web development

  **Time Commitment:**

  With over 30 hours of content plus project work, plan to dedicate 10-15 hours per week for 8-10 weeks to complete the course. However, you can learn at your own pace - all content is available immediately and accessible forever.

  **Join thousands of successful students who have transformed their careers through web development. Your journey starts here!**
CONTENT

# Update first course with detailed data
course = Course.first
if course
  course.update(
    content: detailed_content.strip,
    learning_outcomes: detailed_outcomes,
    syllabus: detailed_syllabus,
    video_url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ" # Example video
  )
  puts "✅ Updated course: #{course.title}"
  puts "📝 Content: #{course.content.length} characters"
  puts "🎯 Learning outcomes: #{course.learning_outcomes.count} items"
  puts "📚 Syllabus modules: #{course.syllabus['modules'].count} modules"
  puts "📖 Total lessons: #{course.syllabus['modules'].sum { |m| m['lessons'].count }} lessons"
  
  total_duration = 0
  course.syllabus['modules'].each do |mod|
    mod['lessons'].each do |lesson|
      if lesson['duration'] =~ /(\d+)\s*min/
        total_duration += $1.to_i
      end
    end
  end
  puts "⏱️  Total duration: #{total_duration} minutes (#{(total_duration / 60.0).round(1)} hours)"
else
  puts "❌ No courses found. Please create a course first."
end
