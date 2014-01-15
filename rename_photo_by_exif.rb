require 'pathname'
require 'exifparser'

class RenamePhotoByExif
  case
    when ARGV.size == 0 then
      puts 'Podaj ścieżkę do zdjęć.'
    when ARGV.size == 1 then
      path = ARGV[0]

      puts 'Zdjęcia w katalogu:'
      Dir.glob("#{path}/*.jpg") do |photo|
        puts Pathname.new(photo).basename
      end
    when ARGV.size >= 2 then
      puts 'Za dużo argumentów.'
    else
      puts 'Nieznany błąd.'
  end
end

