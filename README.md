# Configuration

This gem requires the following environment variables to be set:

```
MINIORANGE_CUSTOMER_KEY
MINIORANGE_CUSTOMER_API_KEY
MINIORANGE_CUSTOMER_TOKEN_KEY
```

You may change the API endpoint using the `MINIORANGE_API_URL` environment variable. It's default value is `https://auth.miniorange.com`.

# How to use
## OTP Challenge
```Ruby
require 'miniorange/challenge'

challenge = MiniOrange::Challenge.new
phone_number = "insert a phone number here"

# The challenge query will send a validation code to the phone number specified as parameter.
# The method will return a transaction id that you will need to store to perform the validation query.
transaction_id = challenge.perform_challenge_query phone_number

# The valiation query will confirm that the token sent to the phone matches the one generated
# by the MiniOrange service.
user_token = "12345"
response = challenge.perform_validate_query transaction_id, user_token

if response["status"] == "SUCCESS"
  puts "Token successfully validated"
else
  puts "The user token does not match the one sent by MiniOrange"
end

```
