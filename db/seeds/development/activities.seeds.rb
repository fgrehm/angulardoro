if Activity.count == 0
  puts 'Creating 10 activities...'
  10.times do |i|
    Fabricate(:activity, name: "Activity #{i}", priority: i)
  end
end
