set :environment, "development"

every 1.day, :at => '12:00 am' do
  rake "todo:delete_items"
end

# Learn more: http://github.com/javan/whenever
