require 'pathname'
require 'exifparser'

class RenamePhotoByExif
  case
    when ARGV.size == 0 then
      puts 'Please, write path to photos as argument.'
    when ARGV.size == 1 then
      path = ARGV[0]
      Dir.glob("#{path}/*.jpg") do |photo|
        exif = ExifParser.new(photo)
        new_name = exif['DateTimeOriginal'].to_s.gsub(':', '_').sub(' ', '__')
        File.rename(photo, path + '/' + new_name + '.jpg')
      end
    when ARGV.size >= 2 then
      puts 'Too many arguments.'
    else
      puts 'Unknown bug.'
  end
end

