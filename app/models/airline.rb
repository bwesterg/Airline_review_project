class Airline < ApplicationRecord
    has_many :reviews

    before_create -> (airline) do
        airline.slug = airline.name.parameterize
    end

    def avg_score
        return 0 unless reviews.count.positive?
        reviews.average(:score).round(2).to_f
    end

    def calculate_average
        return 0 unless reviews.size.positive?

        avg = reviews.average(:score).to_f.round(2) * 100
        update_column(:average_score, avg)
    end
end
