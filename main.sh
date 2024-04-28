#!/bin/bash


# help:
# a - move the car to left
# d - move the car to right


# Function to clear the screen
clear_screen() {
    printf "\033c"
}

read_key() {
  # Turn off terminal line buffering
  stty -echo
  stty cbreak

  # Prompt the user for input
  read -n 1 userInput

  # Turn terminal settings back to normal
  stty echo
  stty -cbreak
  echo $userInput;
}

pixels=()
reset_pixels() {
  pixels=(
    1 1 1 1 1 1 1 1 1 1 1 1 1 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 1 1 1 1 1 1 1 1 1 1 1 1 1
  )
}
reset_pixels
pixels_width=14
pixels_height=15
pixels_set() {
  local index=$(($1*$pixels_width+$2))
  eval "pixels[$index]=$3"
}
pixels_get() {
  local index=$(($1*$pixels_width+$2))
  eval "echo \${$pixels[$index]}"
}





car_design=(
0 1 0
1 1 1
0 1 0
1 0 1
)
car_width=3;
car_height=4;
car_position_x=9;
car_position_y=3;
car_design_get() {
  local index=$(($1*$car_width+$2))
  local val=${car_design[$index]}
  echo $val
}
draw_car() {
  for ((i = 0; i < $car_height; i++)); do
    for ((j = 0; j < $car_width; j++)); do
      local car_design_flag=$(car_design_get $i $j)
      if (($car_design_flag == 1)) then
        pixels_set $(($i + $car_position_x)) $(($j + $car_position_y)) 1
        # printf "$car_design_flag "
      fi
    done
    printf "\n"
  done
}
car_move_left() {
  if (( (car_position_y - 5) > 0)); then
    car_position_y=$((car_position_y - 5))
  fi
}
car_move_right() {
  if (( (car_position_y + car_width + 5) < $pixels_width)); then
    car_position_y=$((car_position_y + 5))
  fi
}
car_move_right
# car_move_left;
draw_car;








# Function to draw the 10 by 10 character screen
draw_screen() {
  clear_screen
  for ((i = 0; i < $pixels_height; i++)); do
    for ((j = 0; j < $pixels_width; j++)); do
      index=$((i * $pixels_width + j))
      if ((${pixels[$index]} == 1)); then
        printf "█"
      else
        printf " "
      fi
    done
    printf "\n"
  done
}


draw_screen;

while true; do
  read -rsn1 key
  if [ "$key" = "a" ]; then
    car_move_left
    reset_pixels
    draw_car
    draw_screen
  fi
  if [ "$key" = "d" ]; then
    car_move_right
    reset_pixels
    draw_car
    draw_screen
  fi
  # draw_screen
done


