task :default => :test
task :test do
  list = Dir.glob('./test/**/*_test.rb')
  list.map { |file| require file}
end

# exit 1
