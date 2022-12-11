# 1. objects encapsulate state and behavior
# state: is the internal memory associated with an object
# behavior: is the internal logic associated with an object

# 2. a class is a blueprint for creating objects
# when dealing with classes you are telling the interpreter/complier how to build an object in memmory
class Elf
  # @param [Array(Integer)] inventory
  def initialize(inventory)
    @inventory = inventory
  end

  def total
    # in most languages you won't have sum
    # so you need to be able to use the reduce
    # function to reduce the array to a single value
    # in ruby reduce is unfortunately named `inject`
    # but is aliased to reduce so you can use that name too
    # @inventory.inject(0) do |sum, item|
    #   sum += item
    # end
    #
    # Javascript version see our cards example
    # cards.reduce((total, item) => total += item), 0)

    # sum of inventory
    @inventory.sum
  end
end

# 3. when you call the new `new` method on a class
# it allocates memory for the object by calling it's constructor
# NOTE: in ruby the constructor is called `initialize`
# elf = Elf.new([7000, 8000, 9000])

class ElfCollection
  def initialize
    @elves = []
  end

  def add(elf)
    @elves << elf
  end

  def most_calorically_dense
    # find the elf with the most calories
    @elves.max_by(&:total)

    # unwind the above magic
    # @elves.max_by(&:total)
    # &:total is indirectly a shortcut for { |elf| elf.total }
    # &:total exactly equals :total.to_proc which is Symbol.to_proc
    # and :total.to_proc is a proc that takes an elf and calls elf.total
    # irb(main):009:0> :foo.class
    # => Symbol
    # irb(main):011:0> :foo.respond_to?(:to_proc)
    # => true
    # A Symbol is an object that represents a name or identifier
    # but less importantly it has special garbage collection characteristics
    # and is always a Singleton so the symbol :foo is always the same object in memory
    #
    # You can think of a Symbol as a light weight immutible string

    # In javascript it's not so easy
    # elves.map(elf => elf.total).reduce((max, total) => total > max ? total : max)
  end
end

# Factorys in object oriented languages are objects that product some type of other objects
# in this case it is creating elves
class ElfFactory
  attr_reader :elf_collection

  def initialize(file_name)
    @elf_collection = ElfCollection.new
    # splitting on double new line seperates the elves
    File.read(file_name).split("\n\n").map do |elves_inventory|
      @elf_collection.add(Elf.new(elves_inventory.split("\n").map(&:to_i)))
    end
  end
end

# if I run this file this code runs
# if this code is loaded from another file this code does not run
if __FILE__ == $0
  elf_collection = ElfFactory.new('elf_inventory.txt').elf_collection

  puts elf_collection.most_calorically_dense.total
end
