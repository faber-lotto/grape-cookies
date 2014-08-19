# GrapeCookies  (Project-State: Proposal)
               
Make Rails cookie handling available for grape. `cookies` method 
will return an `ActionDispatch::Cookies::CookieJar` instead of `Grape::Cookie`.

 
The following classes will be monkey patched:

* `Grape::Endpoint`
* `Grape::Request`
* `ActionDispatch::Cookies::CookieJar`



## Installation

Add this line to your application's Gemfile:

    gem 'grape_cookies'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grape_cookies

## Usage

```ruby

# Only needed if you want to use signed cookies
GrapeCookies.configure do
  signed_cookie_salt 'signed cookie'
  encrypted_cookie_salt 'encrypted cookie'
  encrypted_signed_cookie_salt 'signed encrypted cookie'
  secret_key_base 'secret base'
  cookies_serializer :json
end

class API < Grape::API
  include GrapeCookies::Ext::API
  
  
  get '/test' do
    cookies.signed['test_signed'] = '1234'
    cookies['test_unsigned_signed'] = 'unsigned_1234'
  end

end

```

When `secret_key_base` is not set and a cookie is signed an `ArgumentError`
will be thrown.

## Contributing

1. Fork it ( https://github.com/faber-lotto/grape_cookies/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
