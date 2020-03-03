# config/initializers/stripe.rb
Rails.configuration.stripe = {
  publishable_key: ENV['pk_test_GRh4bDn89Ci0VmpY4iHC51kL0011tovAE1'],
  secret_key:      ENV['sk_test_K2QWaA1761VLCAfKDuabYmpS00PjJdy9vR']
}

# Stripe.api_key = Rails.configuration.stripe[:secret_key]
Stripe.api_key = "sk_test_K2QWaA1761VLCAfKDuabYmpS00PjJdy9vR"
