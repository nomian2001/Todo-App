require 'colorize'
require_relative 'Items.rb'
require_relative 'List.rb'
require_relative 'Todo.rb'


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

    
