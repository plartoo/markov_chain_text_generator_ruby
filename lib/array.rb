class Array
  def shuffle!
    size.downto(1) { |n| push delete_at(rand(n)) }
    self
  end
  #sum (and mean) found on http://snippets.dzone.com/posts/show/2161
  def sum
    inject( nil ) { |sum,x| sum ? sum+x : x }
  end

  def probability(spread = 2)
    z = 1.0
    collect {|x| z = z / spread}
  end
  def weighted_random_index(probability_array = probability(2) )
    size.times do |x|
      return x if rand < probability_array[0..x].sum
    end
    return 0
  end

  def get_weighted_random_item(probability_array = probability(2))
    self[weighted_random_index(probability_array)]
  end

  def get_weighted_random_indexes(num_items, p = probability(2))
    res = []
    escape = 1000
    while res.size < num_items and escape > 0
      escape -= 1
      tmp = weighted_random_index(p)
      res << tmp unless res.include?(tmp)
    end
    return res.sort
  end
end
