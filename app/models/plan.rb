class Plan
  attr_reader :stripe_plan_id

  def initialize(stripe_plan_id)
    @stripe_plan_id = stripe_plan_id
  end

  def self.all_stripe_plan_ids
    %w(morph_basic morph_standard morph_advanced)
  end

  # Users of the top two plans are highlighted
  def self.featured_plans
    all_plans.shift(2)
  end

  # All plans, highest first
  def self.all_plans
    all_stripe_plan_ids.map { |id| Plan.new(id) }.reverse
  end

  def image_name
    "supporter-badge-#{stripe_plan_id}.png"
  end

  def name
    case stripe_plan_id
    when 'morph_basic'
      'Supporter'
    when 'morph_standard'
      'Hero'
    when 'morph_advanced'
      'Partner'
    else
      fail
    end
  end

  def price
    case stripe_plan_id
    when 'morph_basic'
      14
    when 'morph_standard'
      24
    when 'morph_advanced'
      149
    end
  end

  def price_in_cents
    price * 100 if price
  end

  def ==(plan)
    stripe_plan_id == plan.stripe_plan_id
  end
end
