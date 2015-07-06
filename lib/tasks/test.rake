namespace :test do
  desc 'test me'
  task :me => :environment do
    puts "test me successfully, #{Rails.env}"
  end
end
