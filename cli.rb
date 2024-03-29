#!/usr/bin/env ruby
require 'mysql2'

def display_menu
  print "Command: "
end

client = Mysql2::Client.new(
  host: 'localhost',
  username: 'root',
  database: 'my_ruby_cli'
)

loop do
  display_menu
  command = gets.chomp

  case command
  when "1"
    puts "Hello, World!"
  when "exit"
    puts "Exiting..."
    break
  when "new"
    # Insert the new to-do item into the todos table
    print "Title: "
    title = gets.chomp
    print "Description: "
    description = gets.chomp
    print "Status: "
    status = gets.chomp
    print "Priority: "
    priority = gets.chomp
    print "Due date: "
    due_date = gets.chomp

    # Create an array of column names and corresponding values
    columns = ["title"]
    values = ["'#{title}'"]
    # Add optional columns and values if they are provided
    columns << "description" if !description.empty?
    values << "'#{description}'" if !description.empty?
    columns << "status" if !status.empty?
    values << "'#{status}'" if !status.empty?
    columns << "priority" if !priority.empty?
    values << "'#{priority}'" if !priority.empty?
    columns << "due_date" if !due_date.empty?
    values << "'#{due_date}'" if !due_date.empty?
    # Build the INSERT INTO statement
    insert_query = "INSERT INTO todo_items (#{columns.join(', ')}) VALUES (#{values.join(', ')})"
    # Execute the INSERT INTO statement
    client.query(insert_query)
  when "list"
    results = client.query("SELECT * FROM todo_items")
    results.each do |row|
      puts row.inspect
    end
  else
    puts "Invalid choice. Please try again."
  end
end
