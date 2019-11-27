require_relative 'Items.rb'


class List
    def initialize(name, items = [])
        @name = name
        @items = items
    end
    def items
        @items
    end
    def add(*item)
        item.each do |x|
            if x[2] == "[" and x[4] == "]"
                @items.push(Item.new_from_line(x))
            else 
                @items.push(Item.new(x))
            end
        end       
    end
    def display
        @index = 1 
        items.each_with_index do |x,index|
            puts "#{index+1}" + "#{x.display}"
            
        end
    end
    def show_done
        length = @items.length
        if ( length == 0)
            puts "#{items}"
        else
            items.each_with_index do |x,index|
                if x.done? 
                    puts "#{index+1}" + "#{x.display}"           
                end
            end
        end
    end

    def show_undone
        length = @items.length
        if ( length == 0)
            puts "#{items}"
        else
            items.each_with_index do |x,index|
                if !x.done?
                    puts "#{index+1}"+ "#{x.display}"
            
                end
            end
        end
    end

    def remove(*act)
        a = 0
        if defined?(act)
            act.delete(nil)
            act.sort!
            act.each do |x|   
            @items.delete_at(x-1-a)
                a = a + 1          
            end
        end
        
    end

    def mark(*num)
        num.each do |x|
            @items.each_with_index do |z,index|
                if x == index + 1
                    z.mark_done!
                end
            end
        end
    end
    
    def unmark(*num)
        num.each do |x|
            @items.each_with_index do |z,index|
                if x == index +1
                    z.un_mark!
                end
            end
        end
    end

end