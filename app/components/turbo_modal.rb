class TurboModal < ViewComponent::Base
  include Turbo::FramesHelper
  def initialize(title:)
    @title = title
  end
end
