class Kredis::Types::Set < Kredis::Types::Proxy
  attr_accessor :typed

  def members
    Kredis.strings_to_types(smembers || [], typed)
  end
  alias to_a members

  def add(members)
    sadd Kredis.types_to_strings(members) if Array(members).flatten.any?
  end
  alias << add

  def remove(members)
    srem Kredis.types_to_strings(members) if Array(members).flatten.any?
  end

  def replace(members)
    multi do
      del
      add members
    end
  end

  def include?(member)
    sismember(Kredis.type_to_string(member))
  end

  def size
    scard
  end

  def take
    spop
  end

  def clear
    del
  end
end
