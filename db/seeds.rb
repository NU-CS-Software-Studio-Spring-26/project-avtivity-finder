# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Activity.destroy_all

activities = [
  { title: "Sunrise Ridge Hike", description: "Beginner-friendly morning hike with scenic views.", location: "Ridge Trailhead", city: "Seattle", category: "Hike", event_date: Date.today + 2 },
  { title: "Downtown Taco Crawl", description: "Visit 4 taco spots in one evening.", location: "Pike Street", city: "Seattle", category: "Food Crawl", event_date: Date.today + 3 },
  { title: "Coffee and Code Meetup", description: "Casual meetup for students to code together.", location: "Bean House Cafe", city: "Seattle", category: "Coffee Meetup", event_date: Date.today + 4 },
  { title: "Campus Trivia Night", description: "Team trivia with prizes for top 3 teams.", location: "Student Center", city: "Seattle", category: "Trivia Night", event_date: Date.today + 5 },
  { title: "First Friday Art Walk", description: "Walk through local galleries and street art.", location: "Arts District", city: "Seattle", category: "Art Walk", event_date: Date.today + 6 },
  { title: "Outdoor Yoga Basics", description: "Beginner yoga class in the park.", location: "Green Lake Park", city: "Seattle", category: "Fitness Class", event_date: Date.today + 7 },
  { title: "Farmers Market Saturday", description: "Fresh produce and local crafts.", location: "Capitol Market", city: "Seattle", category: "Farmers Market", event_date: Date.today + 8 },
  { title: "Lakeside Run Club", description: "5k community run at easy pace.", location: "Lake Loop", city: "Seattle", category: "Fitness Class", event_date: Date.today + 9 },
  { title: "Weekend Photography Walk", description: "City photo walk for all skill levels.", location: "Waterfront", city: "Seattle", category: "Art Walk", event_date: Date.today + 10 },
  { title: "Neighborhood Board Game Night", description: "Bring your favorite board game.", location: "Community Hall", city: "Seattle", category: "Trivia Night", event_date: Date.today + 11 },
  { title: "Forest Trail Hike", description: "Moderate hike through forest trails.", location: "Cedar Trail", city: "Portland", category: "Hike", event_date: Date.today + 12 },
  { title: "Brunch Bites Crawl", description: "Sample brunch from 3 local cafes.", location: "Pearl District", city: "Portland", category: "Food Crawl", event_date: Date.today + 13 },
  { title: "Latte Art Meetup", description: "Practice latte art and meet coffee fans.", location: "Roast Lab", city: "Portland", category: "Coffee Meetup", event_date: Date.today + 14 },
  { title: "Pub Quiz Evening", description: "General knowledge quiz teams welcome.", location: "Bridge Pub", city: "Portland", category: "Trivia Night", event_date: Date.today + 15 },
  { title: "Street Mural Tour", description: "Guided walking tour of city murals.", location: "Central Avenue", city: "Portland", category: "Art Walk", event_date: Date.today + 16 },
  { title: "Pilates in the Park", description: "Low-impact pilates session outdoors.", location: "Riverside Park", city: "Portland", category: "Fitness Class", event_date: Date.today + 17 },
  { title: "Sunday Farmers Bazaar", description: "Local produce, food trucks, and music.", location: "Old Town Square", city: "Portland", category: "Farmers Market", event_date: Date.today + 18 },
  { title: "Hilltop Sunset Hike", description: "Evening hike timed for sunset.", location: "Summit Trail", city: "San Francisco", category: "Hike", event_date: Date.today + 19 },
  { title: "Night Market Food Tour", description: "Try small bites from local vendors.", location: "Mission Street", city: "San Francisco", category: "Food Crawl", event_date: Date.today + 20 },
  { title: "Writers Coffee Circle", description: "Bring writing projects and meet peers.", location: "Northside Coffee", city: "San Francisco", category: "Coffee Meetup", event_date: Date.today + 21 }
]

Activity.create!(activities)
