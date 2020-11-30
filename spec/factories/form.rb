FactoryBot.define do
  factory :form do
    postal_code    { '000-0000' }
    area_id        { 2 }
    municipality   { '横浜市緑区' }
    house_number   { '青山1-1-1Z' }
    phone_number   { '00000000000' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
