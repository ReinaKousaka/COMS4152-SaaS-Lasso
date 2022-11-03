# Lasso

### Deployed App Link
https://lasso-4152.herokuapp.com/

### Run program and tests
Ruby version: 2.6.6
Rails version: 4.2.11
```
# clone/download the repo, then
cd SaaS-Lasso
# Install gems
bundle install

# Initialize the database
bin/rake db:drop:all
bin/rake db:migrate
bin/rake db:seed

# Launch local server on localhost
bin/rails server

# Run code tests (RSpec & Cucumber)
bundle exec rspec
bundle exec rake cucumber
```

### Team Members
- Tatum Hallstoos, tgh2111
- Kevin Li, kgl2123
- Yun-Yun Tsai, yt2781
- Songheng Yin, sy3079
