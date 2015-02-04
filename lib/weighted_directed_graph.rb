class WeightedDirectedGraph

  attr_reader :wdg

  def initialize # let's just first try with hash of hashes
    # {word1 => {next_word1=>count,next_word2=>count,...}}
    @wdg = {'word1' => {'next_word1'=>1}}
    #@wdg = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc) }
  end
  
  def add_node(name)
    @wdg[name] = {} unless self.contains?(name)
  end
  
  def connect(a,b,weight=1)
    @wdg[a][b] = weight
  end
  
  def edge_weight(a,b)
    @wdg[a][b] rescue nil
    #@wdg[a][b].empty? ? nil : @wdg[a][b]
  end
  
  def contains?(name)
    @wdg.has_key?(name) ? true : false
  end
  
  def out_degree_of(name)
    @wdg[name].length
  end
  
end