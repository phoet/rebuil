# = Rebuil
#
# some description here
#
# == Example
#
#   some code here
#
module Rebuil
  class Expression
    
    attr_accessor :exp
    
    def initialize
      @exp = ""
      @options = []
    end
    
    def group(expression="", &block)
      @exp << "("
      apply_params expression, &block
      @exp << ")"
      self
    end
    
    def characters(characters)
      @exp << "[" << characters << "]" and self
    end
    
    def escape(characters)
      @exp << Regexp.escape(characters) and self
    end
    
    alias_method :<<, :escape
    
    def line_start
      @exp << "^" and self
    end
    
    def line_end
      @exp << "$" and self
    end

    def line(expression="", &block)
      line_start
      apply_params expression, &block
      line_end
    end
        
    def string_start
      @exp << "\A" and self
    end
    
    def string_end
      @exp << "\z" and self
    end
    
    def any
      @exp << "." and self
    end
    
    def many
      @exp << ".*" and self
    end
    
    def to_s
      @exp
    end
    
    def to_r
      Regexp.new(@exp, @options.flatten)
    end
    
    def =~(obj)
      to_r =~ obj
    end
    
    def match(str)
      to_r.match str
    end
    
    private
    
    def apply_params(expression, &block)
      @exp << expression
      block.arity < 1 ? instance_eval(&block) : block.call(self) if block_given?
    end
    
  end
end

class Object
  def rebuil(expression="", &block)
    re = Rebuil::Expression.new
    re << expression
    block.arity < 1 ? re.instance_eval(&block) : block.call(re) if block_given?
    re
  end
end