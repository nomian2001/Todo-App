require_relative 'Items.rb'
require_relative 'List.rb'


class Todo
    def initialize(filename = "todo.md")
        @filename = filename
        @list = List.new("Today") #If we want to keep one list! 
    end
  
    def list
        @list
    end

    def load_data
        data = File.read(@filename)
        data.each_line do |line|
            line.delete!("\n")
            @list.add(line)
        end
    end   
end
