class Item
    def initialize(name, done = false)
        @name = name
        @done = done
        
    end
    def done?
        !!@done
    end
    def mark_done!
        @done = true 
    def un_mark!
        @done = false
    end
    end
    def display
        if done?
            "#{@index}. [x] #{@name}".colorize(:blue)
                   
        else
            "#{@index}. [ ] #{@name}".colorize(:yellow)
        end
    end
    def self.new_from_line(line)
        name = line[6..-1]
        done = line[3] == "x"
        Item.new(name, done)
    end
end