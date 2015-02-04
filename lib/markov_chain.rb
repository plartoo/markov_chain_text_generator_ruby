require File.dirname(__FILE__) + '/weighted_directed_graph'
require File.dirname(__FILE__) + '/array'
require 'rubygems'
require 'ruby-debug'

class MarkovChain
  attr_accessor :graph
  
  def initialize
    @graph = WeightedDirectedGraph.new
  end
  
  def increment_probability(a,b)
    cur_weight = @graph.edge_weight(a,b)
    if cur_weight.nil?
      @graph.add_node(a)
      @graph.add_node(b)
      @graph.connect(a,b)
    else
      @graph.connect(a,b,cur_weight+1)
    end
  end

  def random_walk(start, degree=1, steps=100)
    result = []
    if !@graph.contains?(start)
      puts "No such words in the chain's seed data"
      exit(1)
    end
    result.push(start)
    cur_word = start
    while @graph.out_degree_of(cur_word) != 0 && steps >= 0
      degree.times do
        #[["Nothing", 1], ["Wollstonecraft", 2], ["Anne", 3], ["James", 3]]
        sorted = @graph.wdg[cur_word].sort{ |a,b| a[1]<=>b[1]}#.last.first # return the next word with highest probability
        word_arr = []
        weight_arr = []
        base = 0
        sorted.each{|x| 
          word_arr.push(x.first) 
          base+=x.last.to_i
        } #['all','the','world']
        sorted.each{|x|
          weight_arr.push(x.last.to_f/base)
        }
        cur_word = word_arr.get_weighted_random_item(weight_arr)
      end
      result.push(cur_word)
      steps -= 1
    end
    result
  end
end




# try to see the pattern (Original one was without flags and uniq checking
#    while @graph.out_degree_of(cur_word) != 0 && steps >= 0
#      degree.times do
#        #[["Nothing", 1], ["Wollstonecraft", 2], ["Anne", 3], ["James", 3]]
#        sorted = @graph.wdg[cur_word].sort{ |a,b| a[1]<=>b[1]}#.last.first # return the next word with highest probability
#        #debugger if cur_word == 'at'
#        cur_word = sorted.select{|x| x[1]==sorted.last[1]}.shuffle!.last if flag == 0# return ["Project", 1]
#        cur_word = sorted.shuffle!.last unless flag == 0
#        cur_word = cur_word[0]
#      end
#      #puts cur_word
#      result.push(cur_word)
#      if uniq_size == result.uniq.size
#        flag = 1
#      else
#        flag = 0
#      end
#      steps -= 1
#    end
#    result
#  end
#end