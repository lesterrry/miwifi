# Miwifi
With miwifi authenticating to your Mi router and getting list of connected devices is as simple as that:
```ruby
router = Miwifi::Router.new("192.168.31.1", "password")
router.auth
devices = router.device_list
```

## Installation
1. [Authenticate](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-rubygems-registry#authenticating-to-github-packages) to GitHub Packages

2. Add these lines to your application's Gemfile:
```ruby
source "https://rubygems.pkg.github.com/lesterrry" do
  gem "miwifi"
end
```

## Development
After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Support 
- Xiaomi Router 3 (R3)