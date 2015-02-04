require File.dirname(__FILE__) + '/markov_chain'

class TextGenerator
  attr_reader :markov_chain, :REMCHARS
  
  def initialize
    @markov_chain = MarkovChain.new
  end
  
  def set_optional_remove_chars(chargroup)
    @REMCHARS = chargroup
  end
  
  def seed(text)
    sentences = sentences(text)
    sentences.each do |s|
      word_arr = s.split(/\s/)
      word_arr.each_with_index do |w,i| # let's just split them by 'space' character
        unless word_arr[i+1].nil?
          @markov_chain.increment_probability(w,word_arr[i+1])
        else
          @markov_chain.graph.add_node(w)
        end
      end
    end
  end

  # clean up "tabs" and "line returns".
  # replace new lines with ONE space character
  # remove punctuations and garbage characters
  # finally split based upon TWO spaces (which is the 'proper' way of splitting Engilsh characters)
  def sentences(text)
    text = text.delete("\t\r").gsub(/\n/,' ')                 #.gsub(/([\s])+/,'\1') # remove lines,tabs,feeds and squeeze spaces
    set_optional_remove_chars("_~@\#$%^*+=|(){}[]\"<>/\\\\-") #("_~!@\#$%^&*+=|(){}[]:;\"<>,/\\\\-")
    text.delete(@REMCHARS).split(/\s\s+/)                     #.collect{|x| x.split('.')}
  end
  
  def generate(start)
    @markov_chain.random_walk(start).join(" ")
  end
  
end