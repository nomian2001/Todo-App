require 'colorize'

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


show = Todo.new()
show.load_data
puts "Welcome to Ruby Todo List App".colorize(:green)
puts "Enter " + "-h".colorize(:red) + " or" + " help:".colorize(:red) + " show all command available"
puts ""
puts ""
puts "Todo List: ".colorize(:green)
puts "----------------------------------------------------------------------------".colorize(:green)
show.list.display
puts "----------------------------------------------------------------------------".colorize(:green)
option = ""
while option != "exit"
    print "Please enter an option: ".colorize(:green)
    option = gets.chomp

    case option 
        when "-h" || "help"
            puts ""
            puts "-h ".colorize(:red) + "or" + " help:".colorize(:red) + " Displays a list of all command available!"
            puts "-a ".colorize(:red) + "or" + " add:".colorize(:red) + " Allows you to add new items to your todo list!"
            puts "-d ".colorize(:red) + "or" + " display:".colorize(:red) + " Displays your todo List with all items!"
            puts "-r ".colorize(:red) + "or" + " remove:".colorize(:red) + " Allows you to remove items in your todo list."
            puts "-m ".colorize(:red) + "or" + " mark:".colorize(:red) + " Allows you to check items on the list as complete"
            puts "-um ".colorize(:red) + "or" + " unmark:".colorize(:red) + " Allows you to uncheck items as complete in your todo list!"
            puts "-dd ".colorize(:red) + "or" + " done:".colorize(:red) + " Show items which were done"
            puts "-ud ".colorize(:red) + "or" + " undone:".colorize(:red) + " Show items which weren't done"
            puts "-e ".colorize(:red) + "or" + " exit:".colorize(:red) + " Exit the program"
            puts ""
            puts "Your Todo List: ".colorize(:green)
            puts "------------------------------------------------------------".colorize(:green)
            show.list.display
            puts ""
            puts "------------------------------------------------------------".colorize(:green)
       
        when "-a" || "add"
            puts "What would you like to " + "add?".colorize(:red) + " ( you can add multiple items by use "," between them"
            optionadd = (gets.chomp).split(",")
            show.list.add(*optionadd)
            puts "Items" + "#{optionadd}" + " added in your list "
            puts ""
            puts "Your todo list now: ".colorize(:green)
            puts "------------------------------------------------------------".colorize(:green)
            show.list.display
            puts ""
            puts "------------------------------------------------------------".colorize(:green)

        
        when "-d" || "display"
            puts ""
            puts ""
            puts "Your todo list: ".colorize(:green)
            puts "------------------------------------------------------------".colorize(:green)
            show.list.display
            puts ""
            puts "------------------------------------------------------------".colorize(:green)
        when "-dd" || "display done"
            puts ""
            puts ""
            puts "Your todo list only show items done: ".colorize(:green)
            puts "------------------------------------------------------------".colorize(:green)
            show.list.show_done
            puts ""
            puts "------------------------------------------------------------".colorize(:green)
        when "-ud" || "display undone"
            puts ""
            puts ""
            puts "Your todo list only show items undone: ".colorize(:green)
            puts "------------------------------------------------------------".colorize(:green)
            show.list.show_undone
            puts ""
            puts "------------------------------------------------------------".colorize(:green)

        when "-r" || "remove"
            puts "Please input the number of items you want to " + "remove:".colorize(:red) + "( you can remove multiple items by use "," between them"
            optionremove = (gets.chomp).split(",").map { |x| x.to_i} 
            optionremove.reject! do |x|
                x <= 0
            end
            show.list.remove(*optionremove)
            puts "Items".colorize(:green) + "#{optionremove}" + "removed from your list".colorize(:green)
            puts ""
            puts "Your todo list now: ".colorize(:green)
            puts "------------------------------------------------------------".colorize(:green)
            puts ""
            show.list.display
            puts ""
            puts "------------------------------------------------------------".colorize(:green)
        when "-m" || "mark"
            puts "Please input the number of items you want to " + "mark:".colorize(:red)
            optionmark = (gets.chomp).split(",").map {|x| x.to_i}
            optionmark.reject! do |x|
                x <= 0
            end
            show.list.mark(*optionmark)
            puts "Items".colorize(:green) + "#{optionmark}" + "Marked done! ".colorize(:green)
            puts ""
            puts "Your todo list now: ".colorize(:green)
            puts ""
            show.list.display
            puts ""
            puts "------------------------------------------------------------".colorize(:green)


        when "-um" || "unmark"
            puts "Please input the number of items you want to " + " unmark: ".colorize(:red) 
            optionunmark = (gets.chomp).split(",").map {|x| x.to_i}
            optionunmark.reject! do |x|
                x <= 0
            end
            show.list.unmark(*optionunmark)
            puts "Items".colorize(:green) + "#{optionunmark}" + " Unmarked! ".colorize(:green)
            puts "" 
            puts "Your todo list now: ".colorize(:green) 
            puts ""
            show.list.display
            puts ""
            puts "------------------------------------------------------------".colorize(:green)
          
        when "-e" || "exit"
            puts "Thanks for using!".colorize(:yellow)
            break
        else
            puts "Please input true statemen! Because I don't understand! ".colorize(:red)
            puts "-h ".colorize(:red) + "or" + " help".colorize(:red) + " Displays a list of all command available!"
            puts "------------------------------------------------------------".colorize(:green) 
    end
end

    
