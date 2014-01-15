require 'pathname'
require 'exifparser'

class RenamePhotoByExif
  case
    when ARGV.size == 0 then
      puts 'Please, write path to photos as argument.'
    when ARGV.size == 1 then
      dates = Hash.new(0)
      files = Hash.new()
      path = ARGV[0]

      Dir.glob("#{path}/*.jpg") do |photo|
        exif = Exif::Parser.new(photo)
        new_name = exif['DateTimeOriginal'].to_s.gsub(':', '_').sub(' ', '__')
        dates[new_name] += 1
        files[photo] = new_name
      end

      dates.each_key do |key|
        dates[key] += 1 if dates[key] > 1
      end

      files.each_pair do |file, name|
        if dates[name] > 1
          File.rename(file, path + '/' + name + "_#{dates[name]-1}" + '.jpg')
          dates[name] -= 1
        else
          File.rename(file, path + '/' + name + '.jpg')
        end
      end

    when ARGV.size >= 2 then
      puts 'Too many arguments.'
    else
      puts 'Unknown bug.'
  end
end

