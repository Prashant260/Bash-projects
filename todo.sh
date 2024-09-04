#!/bin/bash
 

   	todo_file="todo.txt"

add_task(){


	if [[ ! -f $todo_file ]]; then
	       	touch "$todo_file"
	fi
#promt to enter a task description 
	read -p "enter a task description" task_description
	echo "$task_descriptiion |--> pending"

#get the next task id

task_id =$(tail -1 $todo_file | awk '{print $1}' | sed 's/)//')
	 if [[ task_id == '' ]]; then
	 task_id=1
 	else
	 task_id=$(expr $task_id +1)
 	fi

 #sppend the task to the to-do list file with the timestamp
 	echo "$task_id) : $(date +"%y-%m-%d %h:%m"): $task_description" >> "$todo_file"

 	echo "task added to the to-do list"
 }

 #function to display the current to-do list
 display_todo_list(){
	  if [[ ! -f $todo_file ]]; then
		  echo "the to-do liist is not exist"
		  return
	  fi

	  echo "current  todo list is : "
	  cat "$todo_file"|nl -s '. '
  }

  remove_task(){
	  read -p "enter the task id to remove : " task_id_remove
	  sed -i "/^$task_id_remove)/d" "$todo_file"
	 
	  echo "removed from the todo list"
  }

  completed_task(){
	  read -p "enter the task id of completed task : " task_done
	  sed -i "$task_done/i/---->completed/"
  }

  #main menu
  while true; do
	  echo "TO-DO LIST MANAGER"
	  echo "------------------"

	  echo "1. Add Task"
	  echo "2. Display Task "
	  echo "3. remove task "
	  echo "4. Task completed"
	  echo "5. Quit"


	  read -p "Enter your choice : " choice


	  case $choice in 
		  1)
			  add_task
			  ;;
		  2) 
			  display_todo_list
			  ;;
	 	  4)
			  completed_task
			  ;;
		  3)    
			  remove_task
			  ;;
	 	  5)
			  echo "Goodbye"
			  exit 0
			  ;;
		  *)
			  echo "Invalid choice . Please enter 1,2,3,4,5"
			  ;;
	  esac
  done

