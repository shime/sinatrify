["3.0.17","3.1.8","3.2.8"].each do |rails_version|
   appraise "#{rails_version}" do 
      gem "rails", rails_version
      gem "sinatrify", :path => "../"
   end 
end

appraise "edge" do
  gem "rails",     :git => "git://github.com/rails/rails.git"
  gem "sinatrify", :path => "../"
end
