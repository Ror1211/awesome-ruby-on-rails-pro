class Kredis::Types::Counter < Kredis::Types::Proxying
  proxying :multi, :set, :incrby, :get

  attr_accessor :expires_in

  def increment(by: 1)
    multi do
      set 0, ex: expires_in, nx: true
      incrby by
    end
  end

  def value
    get.to_i
  end
end
