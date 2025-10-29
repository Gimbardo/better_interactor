class TestOrganizer
  include Interactor::Organizer

  def condition_true
    true
  end

  def condition_false
    false
  end

  organize []
end
