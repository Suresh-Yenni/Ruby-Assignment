input_array = [
  {"id" => 1, "dep" => "a1", "math" => 43, "phy" => 54, "chem" => 65, "year"=>"2016"},
  {"id" => 2, "dep" => "a1", "math" => 66, "phy" => 52, "chem" => 65, "year"=>"2016"},
  {"id" => 3, "dep" => "a7", "math" => 87, "phy" => 32, "chem" => 43, "year"=>"2016"},
  {"id" => 1, "dep" => "a1", "math" => 21, "phy" => 52, "chem" => 65, "year"=>"2015"},
  {"id" => 2, "dep" => "a1", "math" => 68, "phy" => 50, "chem" => 65, "year"=>"2015"},
  {"id" => 3, "dep" => "a7", "math" => 85, "phy" => 22, "chem" => 43, "year"=>"2015"},
  {"id" => 4, "dep" => "a7", "math" => 21, "phy" => 22, "chem" => 13, "year"=>"2016"}
]

## method sorts the passed input array depending on passed element
def sort_input!(input_array, on_element)
    input_array.sort_by! {|item| item[on_element] }
end

## method groups the passed input array depending on passed element and returns
def group_input(input_array, on_element)
    input_array.group_by { |item| item[on_element] }
end

## method does comparison of marks during the years passed in arugements
## and return array of row for each group in input array
def compare_marks!(change_in_marks, input_array, years_to_compare, display_fields)
   first_year = 0
   second_year = 0
   input_array.each do |grp_on, input_array_rows|
     marks_row = {}
     display_fields.each do |key|
       input_array_rows.each do |row|
          if row["year"] == years_to_compare["first"]
                first_year = row[key]
          elsif row["year"] == years_to_compare["second"]
                second_year = row[key]
          end
       end
       marks_row[key] = "#{(first_year-second_year)}"
     end
    change_in_marks[grp_on] = marks_row
   end
end

## method totals the marks of all years if no comparison was asked or
## else totals the marks of years been passed and return array of row for each group in input aaray
def get_totals!(total_marks, should_compare, input_array, years_to_compare, display_fields)
   input_array.each do |grp_on, input_array_rows|
     marks_row = {}
     display_fields.each do |key|
       total = 0
       input_array_rows.each do |row|
          if should_compare == "false"
             total = total + row[key]
          elsif (row["year"] == years_to_compare["first"]) || (row["year"] == years_to_compare["second"])
             total = total + row[key]
          end
       end
       marks_row[key] = total
     end
     total_marks[grp_on] = marks_row
   end
end

## method displayes the row related to change in marks if comparison was asked
## and displayes the row related to total if total was asked
def display_row(compare_or_total, labels_key, change_or_total_marks, display_fields, grp_on)
  labels = {
    "on_compare" => "\nChange     ",
    "on_total" => "\nTotal      "
  }
  if compare_or_total == "true"
    print labels[labels_key]
    row = change_or_total_marks[grp_on]
    display_fields.each { |subject| print "#{row[subject]}    "}
  end
end

## method displayes required output on screen
def display_output(input_array, change_in_marks, total_marks, display_fields,should_compare , should_total, group_on)
  input_array.each do |grp_on,  input_array_rows|
     print "\nOn = #{grp_on}"
     display_fields.each { |label| print " | #{label} " }
     input_array_rows.each do |row|
       print "\n#{row["year"]}       "
       display_fields.each { |subject| print "#{row[subject]}    "}
     end
     display_row(should_compare, "on_compare", change_in_marks, display_fields, grp_on) if group_on == "id"
     display_row(should_total, "on_total", total_marks, display_fields, grp_on)
     puts ""
   end
end

##starting point of program
def start(input_array)

  puts "group_by? sort_by? Diplay_fields? should_compare? show_total? "
  input = gets.chomp
  group_on, sort_on, display_fields, should_compare, should_total = input.split(" ")

  display_fields = display_fields.split(",")
  sort_input!(input_array, sort_on)
  input_array = group_input(input_array, group_on)

  years_to_compare = {"first" => "", "second" => ""}

  if should_compare == "true"
      change_in_marks = {}
      puts "First_compare_year? Second_compare_year? "
      years = gets.chomp
      years_to_compare["first"], years_to_compare["second"] = years.split(" ")
      compare_marks!(change_in_marks, input_array, years_to_compare, display_fields)
  end

  if should_total == "true"
      total_marks = {}
      get_totals!(total_marks, should_compare, input_array, years_to_compare, display_fields)
  end

  display_output(input_array, change_in_marks, total_marks, display_fields, should_compare, should_total, group_on)

end

start(input_array)
