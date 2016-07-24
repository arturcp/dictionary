require 'google_drive'

namespace :google_drive do
  desc 'Prompts an authorization page and store credentials on a file'
  task authorize: :environment do
    GoogleDrive.saved_session('config/google_api.json')
  end
end
