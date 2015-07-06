namespace :error_pages do
  desc 'Copy compiled error pages to public dir'
  task :list => :environment do

    pages = Rails.root.join('app', 'assets', 'error_pages', '*')
    xx = Dir[pages].map do |page|
      Rails.application.assets.find_asset(page).digest_path

      # asset = Rails.application.assets.find_asset(page).digest_path
      # asset_path =
      #
      # basename = File.basename(page).split('.').first
      # html_path = Rails.root.join('public', "#{basename}.html")
      #
      # execute :cp, "#{asset_file} #{current_path}/public/#{page}.html"
      #
      # FileUtils.cp asset_path, html_path
    end

    puts xx

    # puts "test me successfully, #{Rails.env}"
  end
end
