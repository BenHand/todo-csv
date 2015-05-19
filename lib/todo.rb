require 'csv'

class Todo

  def initialize(file_name)
    @file_name = file_name
    @todos = CSV.read( @file_name, headers: true )
    # You will need to read from your CSV here and assign them to the @todos variable. make sure headers are set to true
  end

  def start
    loop do
      system('clear')

      puts "---- TODO.rb ----"

      view_todos

      puts
      puts "What would you like to do?"
      puts "1) Exit 2) Add Todo 3) Mark Todo As Complete"
      print " > "
      action = gets.chomp.to_i
      case action
      when 1 then exit
      when 2 then add_todo
      when 3 then mark_todo
      else
        puts "\a"
        puts "Not a valid choice"
      end
    end
  end

  def view_todos

    #   num = 0
    #   row = @todos[0]
    # # row.each do |name|
    #     num += 1
    #   puts "#{num}) #{row["name"]}"
    # end
      puts "Unfinished"
      num = 0
      @todo_name = @todos.select { |row| row["completed"] == 'no' }
      @todo_name.each do |row|
        num += 1
        puts "#{num}) #{row["name"]}"
      end

      puts "Completed"
      num = 0
      @todo_name = @todos.select { |row| row["completed"] == 'yes' }
      @todo_name.each do |row|
        num += 1
        puts "#{num}) #{row["name"]}"
      end

    # num = 0
    # unfinished = @todos.map { |row| row["name"] }
    # unfinished.each do |name|
    #   num += 1
    #   puts "#{num}) #{name}"
    # end
  end

  def add_todo
    puts "Name of Todo > "
    @todos << [get_input, "no"]
  end

  def mark_todo
    puts "Which todo have you finished?"
    @todos << @todos[get_input.to_i - 1]["completed"] = 'yes'
    save!
  end

  def todos
    @todos
  end

  private
  def get_input
    gets.chomp
  end

  def save!
    File.write(@file_name, @todos.to_csv)
  end
end
