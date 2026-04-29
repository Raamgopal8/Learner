# Ensure first course has video
c1 = Course.first
c1.update(video_url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ") if c1

# Ensure second course has video
c2 = Course.second
c2.update(video_url: "https://www.youtube.com/watch?v=jNQXAC9IVRw") if c2

puts "Course 1: #{c1.title} - Video: #{c1.video_url}"
puts "Course 2: #{c2.title} - Video: #{c2.video_url}"

# Create or find a test user
user = User.find_or_create_by(email: "test@example.com") do |u|
  u.password = "password"
  u.password_confirmation = "password"
  u.first_name = "Test"
  u.last_name = "User"
  u.username = "testuser"
end
puts "Test User: #{user.email} / password"
