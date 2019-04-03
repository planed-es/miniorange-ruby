require 'miniorange/client'

module MiniOrange
  class Challenge < MiniOrange::Client
    def make_challenge_query phone_number
      make_query "/moas/api/auth/challenge",
                 customerKey:     customer_key,
                 phone:           phone_number,
                 authType:        :SMS,
                 transactionName: "CUSTOM-OTP-VERIFICATION"
    end

    def perform_challenge_query phone_number
      query    = make_challenge_query phone_number
      response = perform_query query
      response["txId"]
    end

    def make_validate_query transaction_id, token
      make_query "/moas/api/auth/validate",
                 txId:  transaction_id,
                 token: token
    end

    def perform_validate_query transaction_id, token
      query    = make_validate_query transaction_id, token
      response = perform_query query
      response
    end
  end
end
