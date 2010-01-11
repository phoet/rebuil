# = FileCache
#
# FileCache is a simple utility to persist arbitrary data into a file.
# Just wrap the action you want to cache into a FileCache call and it will be available for 30 minutes by default.
#
# FileCache uses the default tmp-directory of your OS, but you may override that setting via +file_cache_dir+
#
# == Example
#
#   require 'file_cache'
#   include FileCache
#
#   file_cache :cache_token_name do
#     #some_stuff_that_should_be_cached_executed_here
#   end
#
module Rebuil
  class Expression
    
    attr_accessor :exp
    
    def initialize
      @exp = ""
    end
    
    def group(expression)
      @exp << "(" << expression << ")"
      self
    end
    
    def to_s
      @exp
    end
    
    def to_r
      /#{@exp}/
    end
  end
end