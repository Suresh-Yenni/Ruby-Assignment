array = [
{"id" => 1, "dep" => "a1" , "math" => 43 , "phy" => 54 , "chem" => 65 ,"year"=>"2016"},
{"id" => 2 , "dep" => "a1" , "math" => 66, "phy" => 52, "chem" => 65,"year"=>"2016"},
{"id" => 3, "dep" => "a7" , "math" => 87, "phy" => 32, "chem" => 43,"year"=>"2016"},
{"id" => 1, "dep" => "a1" , "math" => 21, "phy" => 52, "chem" => 65,"year"=>"2015"},
{"id" => 2, "dep" => "a1" , "math" => 68, "phy" => 50, "chem" => 65,"year"=>"2015"},
{"id" => 3, "dep" => "a7" , "math" => 85, "phy" => 22, "chem" => 43,"year"=>"2015"},
{"id" => 4, "dep" => "a7" , "math" => 21, "phy" => 22, "chem" => 13,"year"=>"2016"}
]

def sort_input(array, on)
    out = array.sort_by {|item| item[on] } 	
    return out
end

def group_input(out, on)
     puts out.inspect
     out = out.group_by { |item| item[on] }
     puts out.inspect
     return out
end

def give_key(index)
    if index == 0
        return "id"
    elsif index == 1
        return "dep"
    elsif index == 2
        return "math"
    elsif index == 3
        return "phy"
    elsif index == 4
        return "chem"
    elsif index == 5
        return "year"
    end
end

def if_should_compare(input, out, compare, change)
   current = 0
   past = 0
   
   out.each do |x|
     hash = {}
     a=[]
     for index in 2...5
       key = give_key(index)
       x[1].each do |y|
          if y["year"] == compare[0]
                current = y[key]
          elsif y["year"] == compare[1]
                past = y[key]
          end
       end
       hash[key] = "#{(current-past)}"
     end
    a.push(hash)
    change.push(a)
   end
  return change
end

def if_total(input, out, compare, total)
   out.each do |x|
     hash = {}
     a=[]
     for index in 2...5
       tot = 0
       key = give_key(index)
       x[1].each do |y|
          if input[3] == "false"
             tot = tot + y[key]
          elsif (y["year"] == compare[0]) || (y["year"] == compare[1])
             tot = tot + y[key]
          end
       end
       hash[key] = tot
     end
    a.push(hash)
    total.push(a)
   end
  return total
end

def for_display(out, change, total, input)
  count = 0
  display = input[2].split(",")
  print "#{input[0]}      "
  display.each { |e| print "| #{e}  " }
  out.each do |x| 
     puts x.inspect
     puts ""
     print "#{x[0]}"
     x[1].each do |y|
       puts ""
       print "#{y["year"]}       "
       print "#{y["math"]}     " if display.include? "math" 
       print "#{y["phy"]}      " if display.include? "phy"
       print "#{y["chem"]}     " if display.include? "chem"
     end
     puts ""
     if input[3] == "true"
       print "Change     "
       change[count].each do |f|
         print "#{f["math"]}     " if display.include? "math" 
         print "#{f["phy"]}     " if display.include? "phy"
         print "#{f["chem"]}" if display.include? "chem"
       end
     end
     puts ""
     if input[4] == "true"
       print "Topic      "
       total[count].each do |u|
         print "#{u["math"]}     " if display.include? "math" 
         print "#{u["phy"]}     " if display.include? "phy"
         print "#{u["chem"]}" if display.include? "chem"
       end
     end
     count += 1
     puts ""
   end
   puts ""
end

puts "group_by? sort_by? Diplay_fields? should_compare? show_total? "
input = gets.chomp
input = input.split(" ")

out = sort_input(array, input[1])
out = group_input(out, input[0])

puts out.inspect

compare=[]

if input[3] == "true"
    change = []
    puts "First_compare_element? Second_compare_element? "
    compare = gets.chomp
    compare = compare.split(" ")
    change = if_should_compare(input, out, compare, change)
end

if input[4] == "true"
   total = []
   total = if_total(input, out, compare, total)
end

puts ""
for_display(out, change, total, input)



     

