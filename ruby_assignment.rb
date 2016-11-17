$ID_ATTRIBUTES = {0 => "id", 1 => "dep", 2 => "math", 3 => "phy", 4 => "chem", 5 => "year"}
input_array = [
  {"id" => 1, "dep" => "a1", "math" => 43, "phy" => 54, "chem" => 65, "year"=>"2016"},
  {"id" => 2, "dep" => "a1", "math" => 66, "phy" => 52, "chem" => 65, "year"=>"2016"},
  {"id" => 3, "dep" => "a7", "math" => 87, "phy" => 32, "chem" => 43, "year"=>"2016"},
  {"id" => 1, "dep" => "a1", "math" => 21, "phy" => 52, "chem" => 65, "year"=>"2015"},
  {"id" => 2, "dep" => "a1", "math" => 68, "phy" => 50, "chem" => 65, "year"=>"2015"},
  {"id" => 3, "dep" => "a7", "math" => 85, "phy" => 22, "chem" => 43, "year"=>"2015"},
  {"id" => 4, "dep" => "a7", "math" => 21, "phy" => 22, "chem" => 13, "year"=>"2016"}
]


## Naming convention for methods and variables
## Variable Scopes (Global,local, constants, class level etc)
## Class methods ?
## Modules
## require vs include
## Add comments
## Move all logic into functions

## method sorts the passed input array depending on passed elementand returns
def sort_input(input_array, on_element)
    input_array.sort_by {|item| item[on_element] }
end

## method groups the passed input array depending on passed element and returns
def group_input(input_array, on_element)
    input_array.group_by { |item| item[on_element] }
end

## method does comparison of marks during the years passed in arugements
## and return array of row for each group in input array
def comparing_marks(input_array, years_to_compare, change_in_marks)
   first_year = 0
   second_year = 0
   input_array.each do |input_array_row|
     row_of_hash = {}
     row_of_array=[]
     for index in 2...5
       key = $ID_ATTRIBUTES[index]
       input_array_row[1].each do |input_array_col|
          if input_array_col["year"] == years_to_compare[0]
                first_year = input_array_col[key]
          elsif input_array_col["year"] == years_to_compare[1]
                second_year = input_array_col[key]
          end
       end
       row_of_hash[key] = "#{(first_year-second_year)}"
     end
    row_of_array.push(row_of_hash)
    change_in_marks.push(row_of_array)
   end
  return change_in_marks
end

## method totals the marks of all years if no comparison was asked or
## else totals the marks of years been passed and return array of row for each group in input aaray
def getting_totals(should_compare, input_array, years_to_compare, total_marks)
   input_array.each do |input_array_row|
     row_of_hash = {}
     row_of_array = []
     for index in 2...5
       total = 0
       key = $ID_ATTRIBUTES[index]
       input_array_row[1].each do |input_array_col|
          if should_compare == "false"
             total = total + input_array_col[key]
          elsif (input_array_col["year"] == years_to_compare[0]) || (input_array_col["year"] == years_to_compare[1])
             total = total + input_array_col[key]
          end
       end
       row_of_hash[key] = total
     end
    row_of_array.push(row_of_hash)
    total_marks.push(row_of_array)
   end
  return total_marks
end

## method displayes the row related to change in marks if comparison was asked
## and displayes the row related to total if total was asked
def display_row(comparison_or_total, labels_key, change_or_total_marks, display_fields, index)
  puts ""
  labels = {
    "on_compare" => "Change     ",
    "on_total" => "Topic      "
  }

  if comparison_or_total == "true"
    print labels[labels_key]
    change_or_total_marks[index].each do |cols|
      print "#{cols["math"]}     " if display_fields.include? "math"
      print "#{cols["phy"]}     " if display_fields.include? "phy"
      print "#{cols["chem"]}" if display_fields.include? "chem"
    end
  end
end

## method displayes required output on screen
def displaying_output(input_array, change_in_marks, total_marks, display_fields,should_compare , should_total)
  index = 0
  display_fields = display_fields.split(",")
  print "#{input_array[0]}      "
  display_fields.each { |e| print "| #{e}  " }
  input_array.each do |input_array_row|
     puts ""
     print "#{input_array_row[0]}"
     input_array_row[1].each do |input_array_col|
       puts ""
       print "#{input_array_col["year"]}       "
       print "#{input_array_col["math"]}     " if display_fields.include? "math"
       print "#{input_array_col["phy"]}      " if display_fields.include? "phy"
       print "#{input_array_col["chem"]}     " if display_fields.include? "chem"
     end
     display_row(should_compare, "on_compare", change_in_marks, display_fields, index)
     display_row(should_total, "on_total", total_marks, display_fields, index)
     index += 1
     puts ""
   end
   puts ""
end

## method asks user to input fields to processed
def user_input(fields)

  index = 0
  fields.each do |k, v|
      fields[k] = input[index]
      index += 1
  end
end

## program start with call to this method
def start(input_array)

  puts "group_by? sort_by? Diplay_fields? should_compare? show_total? "
  input = gets.chomp
  group_on, sort_on, display_fields, should_compare, should_total = input.split(" ")

  input_array = sort_input(input_array, sort_on)
  input_array = group_input(input_array, group_on)

  years_to_compare = []

  if should_compare == "true"
      change_in_marks = []
      puts "First_compare_year? Second_compare_year? "
      years_to_compare = gets.chomp
      years_to_compare = years_to_compare.split(" ")
      change_in_marks = comparing_marks(input_array, years_to_compare, change_in_marks)
  end

  if should_total == "true"
     total_marks = []
     total_marks = getting_totals(should_compare, input_array, years_to_compare, total_marks)
  end

  puts ""
  displaying_output(input_array, change_in_marks, total_marks, display_fields, should_compare, should_total)

end

start(input_array)
