namespace :google_drive do
  DICTIONARIES = {
    SpreadsheetLanguage::PORTUGUESE => '',
    SpreadsheetLanguage::ENGLISH => Dictionaries::TheFreeDictionary,
    SpreadsheetLanguage::ITALIAN => ''
  }

  desc 'Import words from the Google Drive spreadsheet'
  task import: :environment do
    require 'rake-progressbar'

    file = ENV.fetch('FILE', '')
    language = ENV.fetch('LANGUAGE', SpreadsheetLanguage::ENGLISH).to_i

    if file.present?
      prepare_database

      importer = Importer.new(
        file: file,
        language: language,
        dictionary: DICTIONARIES[language]
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
    # TODO: CHECK THE NOKOGIRI GEM: https://github.com/sparklemotion/nokogiri
  end

  def prepare_database
    return unless delete_option = ENV.fetch('DELETE', '').downcase

    if delete_option == 'all'
      Word.delete_all
    elsif delete_option == 'language'
      language = ENV.fetch('LANGUAGE', SpreadsheetLanguage::ENGLISH)
      Word.where(language: language).delete_all
    end
  end
end
