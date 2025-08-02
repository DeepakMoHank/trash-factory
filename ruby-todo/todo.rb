# Simple Ruby CLI To-Do List

TASKS_FILE = "tasks.txt"

# Load tasks from file
def load_tasks
  return [] unless File.exist?(TASKS_FILE)
  File.readlines(TASKS_FILE, chomp: true)
end

# Save tasks to file
def save_tasks(tasks)
  File.open(TASKS_FILE, "w") { |file| tasks.each { |task| file.puts(task) } }
end

# Display menu
def menu
  puts "\n=== Ruby To-Do List ==="
  puts "1. View Tasks"
  puts "2. Add Task"
  puts "3. Mark Task as Done"
  puts "4. Exit"
  print "Choose an option: "
end

# Main loop
tasks = load_tasks

loop do
  menu
  choice = gets.chomp

  case choice
  when "1"
    if tasks.empty?
      puts "No tasks yet!"
    else
      puts "\nYour Tasks:"
      tasks.each_with_index do |task, i|
        puts "#{i + 1}. #{task}"
      end
    end
  when "2"
    print "Enter new task: "
    task = gets.chomp
    tasks << task
    save_tasks(tasks)
    puts "Task added!"
  when "3"
    print "Enter task number to mark as done: "
    num = gets.chomp.to_i
    if num.between?(1, tasks.size)
      tasks[num - 1] += " ✅"
      save_tasks(tasks)
      puts "Task marked as done!"
    else
      puts "Invalid task number!"
    end
  when "4"
    puts "Goodbye!"
    break
  else
    puts "Invalid option!"
  end
end
