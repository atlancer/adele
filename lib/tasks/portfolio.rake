namespace :portfolio do
  desc 'Process & copy portfolio files'
  task :process => :environment do
    folder_to   = Rails.root.join('app', 'assets', 'images', 'portfolio')
    from_folder = Rails.root.join('portfolio_files')
    from_files  = File.join(from_folder, '*', '*.jpg')
    watermark_file = Rails.root.join('app', 'assets', 'images', 'watermark.png')

    Dir.glob(from_files, File::FNM_CASEFOLD).each do |from_filepath|
      subfolder     = File.dirname(from_filepath).split('/').last
      target_folder = File.join(folder_to, subfolder)
      Dir.mkdir(target_folder) unless Dir.exist?(target_folder)

      filename_origin = File.basename(from_filepath).downcase.gsub(' ', '_')
      filename_ext    = File.extname(filename_origin)
      filename_thumb  = File.basename(filename_origin, filename_ext) << '_thumb' << filename_ext

      filepath_to_origin = File.join(target_folder, filename_origin)
      filepath_to_thumb  = File.join(target_folder, filename_thumb)

      # ----------------------------------------------------------------------------------------------------------------
      result =
        if File.exist?(filepath_to_origin)
          :exist
        else
          begin
            # convert DSC_0010.JPG -resample 72 -resize 75% -quality 70 -strip DSC_0010-75-70-strip.jpg
            MiniMagick::Tool::Convert.new do |convert|
              convert << from_filepath
              convert << '-resample' << '72'
              convert << '-resize'  << '75%'
              convert << '-quality' << '70'
              convert << '-strip'
              convert << filepath_to_origin
            end

            # composite -dissolve 40% -gravity center water3.png file.jpg file__.jpg
            MiniMagick::Tool::Composite.new do |composite|
              composite << '-dissolve' << '40%'
              composite << '-gravity' << 'center'
              composite << watermark_file
              composite << filepath_to_origin
              composite << filepath_to_origin
            end

            :converted
          rescue
            :ERROR
          end
        end

      puts result.to_s << ' ' << filepath_to_origin

      # ----------------------------------------------------------------------------------------------------------------
      result =
        if File.exist?(filepath_to_thumb)
          :exist
        else
          begin
            # convert DSC_0010-75-70-strip.jpg -resize '263x166^' -gravity center -crop '263x166+0+0' output.jpg
            MiniMagick::Tool::Convert.new do |convert|
              # convert << filepath_to_origin
              convert << from_filepath
              convert << '-resample' << '72'
              convert << '-resize' << '338x216^'
              convert << '-gravity' << 'center'
              convert << '-crop' << '338x216+0+0'
              convert << filepath_to_thumb
            end
            :converted
          rescue
            :ERROR
          end
        end

      puts result.to_s << ' ' << filepath_to_thumb
    end
  end
end
