#!/bin/bash

# Show active tasks (pending)
echo "Active tasks due today:"
task status:pending due:today

echo ""

# Show completed tasks (marked text with a line)
echo -e "\033[9mCompleted tasks due today:\033[0m" # Strike-through (not all terminals support this)
task status:completed due:today | while read task; do
  echo -e "\033[9m$task\033[0m" # Strikethrough effect on completed tasks
done

