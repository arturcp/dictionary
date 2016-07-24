namespace :google_drive do
  desc 'Import words from the Google Drive spreadsheet'
  task import: :environment do
    require 'rake-progressbar'

    file = ENV.fetch('FILE', '')

    if file.present?
      Word.delete_all

      importer = Importer.new(
        file: file,
        language: SpreadsheetLanguage::ENGLISH
      )

      import_words(importer)
    else
      show_usage
    end
  end

  def show_usage
    puts ''
    puts '**************************************************************************************'
    puts "* #{"USAGE".red}: bin/rake google_drive:import #{"FILE='<file id>'".green}                               *"
    puts '*                                                                                    *'
    puts '* File id can be retrived from the Google Drive Spreadsheet URL. It looks like this: *'
    puts "* #{"10BVvv01c6r2igfj5t8-XaFOP4lBvbbbxj1vZ6G9J1Ii".green}                                       *"
    puts '*                                                                                    *'
    puts '**************************************************************************************'
  end

  def import_words(importer)
    bar = RakeProgressbar.new(importer.rows_count)
    importer.start! do |row|
      bar.inc
      # puts row[0]
    end
    bar.finished

    puts ''
    puts 'Ignored words:'
    Word.inactive.each do |inactive|
      puts inactive.word
    end
  end
end
