#! /bin/bash

help_message() {
  local HELP_MESSAGE='  bash_present.sh is a script designed to render slides written 
  in a custom markup language. This script is written using only
  BASH builtins and includes the following features:

  Commandline options:
  -a) The -a defines the default alignment for slides and
      therefore must be followed by either left, right, or center.
  -h) Displays this help message.

  -s) Declare the directory in which the slides are stored.

  -n) The integer value of the slide on which the presentation
      should begin. The is zero indexed.

  Hotkeys:
  up arrow, right arrow, space, return, l, and k move to the next slide.
  down arrow, left arrow, h, and j moves to the privious slide.
  : (colon) opens the command interface.
  q exits the program.

  Command Interface:
  :goto # switches slides to the number represented by the #.
  :help prints out a list of commands.
  :quit exits the program.'

  echo "${HELP_MESSAGE}"
}

format_defs() {
  # This function creates an associative array containing color codes and
  # markup tags to be called as part of the slide_present function.
  declare -Ag FONT_FORMATS
  FONT_FORMATS['<clear>']='\e[0m'           # Text Reset

  # Regular Colors
  FONT_FORMATS['<black>']='\e[0;30m'        # Black
  FONT_FORMATS['<red>']='\e[0;31m'          # Red
  FONT_FORMATS['<green>']='\e[0;32m'        # Green
  FONT_FORMATS['<yellow>']='\e[0;33m'       # Yellow
  FONT_FORMATS['<blue>']='\e[0;34m'         # Blue
  FONT_FORMATS['<purple>']='\e[0;35m'       # Purple
  FONT_FORMATS['<cyan>']='\e[0;36m'         # Cyan
  FONT_FORMATS['<white>']='\e[0;37m'        # White

  # Bold
  FONT_FORMATS['<bblack>']='\e[1;30m'       # Black
  FONT_FORMATS['<bred>']='\e[1;31m'         # Red
  FONT_FORMATS['<bgreen>']='\e[1;32m'       # Green
  FONT_FORMATS['<byellow>']='\e[1;33m'      # Yellow
  FONT_FORMATS['<bblue>']='\e[1;34m'        # Blue
  FONT_FORMATS['<bpurple>']='\e[1;35m'      # Purple
  FONT_FORMATS['<bcyan>']='\e[1;36m'        # Cyan
  FONT_FORMATS['<bwhite>']='\e[1;37m'       # White

  # Underline
  FONT_FORMATS['<ublack>']='\e[4;30m'       # Black
  FONT_FORMATS['<ured>']='\e[4;31m'         # Red
  FONT_FORMATS['<ugreen>']='\e[4;32m'       # Green
  FONT_FORMATS['<uyellow>']='\e[4;33m'      # Yellow
  FONT_FORMATS['<ublue>']='\e[4;34m'        # Blue
  FONT_FORMATS['<upurple>']='\e[4;35m'      # Purple
  FONT_FORMATS['<ucyan>']='\e[4;36m'        # Cyan
  FONT_FORMATS['<uwhite>']='\e[4;37m'       # White

  # Background
  FONT_FORMATS['<on_black>']='\e[40m'       # Black
  FONT_FORMATS['<on_red>']='\e[41m'         # Red
  FONT_FORMATS['<on_green>']='\e[42m'       # Green
  FONT_FORMATS['<on_yellow>']='\e[43m'      # Yellow
  FONT_FORMATS['<on_blue>']='\e[44m'        # Blue
  FONT_FORMATS['<on_purple>']='\e[45m'      # Purple
  FONT_FORMATS['<on_cyan>']='\e[46m'        # Cyan
  FONT_FORMATS['<on_white>']='\e[47m'       # White

  # High Intensity
  FONT_FORMATS['<iblack>']='\e[0;90m'       # Black
  FONT_FORMATS['<ired>']='\e[0;91m'         # Red
  FONT_FORMATS['<igreen>']='\e[0;92m'       # Green
  FONT_FORMATS['<iyellow>']='\e[0;93m'      # Yellow
  FONT_FORMATS['<iblue>']='\e[0;94m'        # Blue
  FONT_FORMATS['<ipurple>']='\e[0;95m'      # Purple
  FONT_FORMATS['<icyan>']='\e[0;96m'        # Cyan
  FONT_FORMATS['<iwhite>']='\e[0;97m'       # White

  # Bold High Intensity
  FONT_FORMATS['<biblack>']='\e[1;90m'      # Black
  FONT_FORMATS['<bired>']='\e[1;91m'        # Red
  FONT_FORMATS['<bigreen>']='\e[1;92m'      # Green
  FONT_FORMATS['<biyellow>']='\e[1;93m'     # Yellow
  FONT_FORMATS['<biblue>']='\e[1;94m'       # Blue
  FONT_FORMATS['<bipurple>']='\e[1;95m'     # Purple
  FONT_FORMATS['<bicyan>']='\e[1;96m'       # Cyan
  FONT_FORMATS['<biwhite>']='\e[1;97m'      # White

  # High Intensity backgrounds
  FONT_FORMATS['<on_iblack>']='\e[0;100m'   # Black
  FONT_FORMATS['<on_ired>']='\e[0;101m'     # Red
  FONT_FORMATS['<on_igreen>']='\e[0;102m'   # Green
  FONT_FORMATS['<on_iyellow>']='\e[0;103m'  # Yellow
  FONT_FORMATS['<on_iblue>']='\e[0;104m'    # Blue
  FONT_FORMATS['<on_ipurple>']='\e[0;105m'  # Purple
  FONT_FORMATS['<on_icyan>']='\e[0;106m'    # Cyan
  FONT_FORMATS['<on_iwhite>']='\e[0;107m'   # White
}

term_size() {
  # Discover and save the width of the terminal (in characters)
  # and the height of the terminal (in lines).
  TERM_SIZE=$(read -p $'\e[18t' -s -r -d t size; echo ${size#*;})
  TERM_WIDTH=${TERM_SIZE/*;}
  TERM_HEIGHT=${TERM_SIZE/;*}
}

align_text() {
  # Sets the PRESET_ALIGN variable if it matches one of the 
  # accepted alignments in the ALIGNMENTS array. This ensures
  # that the alignment will make sense later.
  ALIGNMENTS=( 'left' 'right' 'center' )
  if [[ "${ALIGNMENTS[@]}" =~ ${1} ]]; then
    PRESET_ALIGN="${1}"
  else
    help_message
    exit 1
  fi
}

command_interface_spaces_default() {
  # The default command interface is placed at the bottom of then
  # screen by this function.
  LINES=$(($TERM_HEIGHT - $LINE_COUNT - 2))
  for LINE in $(eval echo {0..$LINES}); do
    echo
  done
  command_interface
}

command_interface_spaces_help() {
  # In addition to default command interface functionality, this
  # function adds a list of accepted commands.
  LINES=$(($TERM_HEIGHT - $LINE_COUNT - 5))
  for LINE in $(eval echo {0..$LINES}); do
    echo
  done
  echo ':goto # -- Go to a slide by number.'
  echo ':quit -- Quit the program.'
  echo ':help -- Show this text.'
  command_interface
}

command_interface() {
  # Reads in commands and executes them.
  read -p ':' COMMAND
  if [[ "${COMMAND}" =~ goto\ [0-9]+ ]]; then
    NEW_SLIDE="((${COMMAND#* } - 1))"
    if (( ${NEW_SLIDE} >= 0 )) && (( ${NEW_SLIDE} < ${#SLIDES[@]} )); then
      SLIDE_NUM="${NEW_SLIDE}"
    fi
  elif [[ "${COMMAND}" = 'quit' ]] || [[ "${COMMAND}" = 'q' ]]; then
    QUIT='true'
  elif [[ "${COMMAND}" = 'help' ]] || [[ "${COMMAND}" = '?' ]]; then
    slide_present "${SLIDES[$SLIDE_NUM]}"
    command_interface_spaces_help
  fi
}

slide_present() {
  # Responsible for printing the current slide.
  slide_present_tags() {
    # Determines what to do on lines made solely of tags. 
    if [[ "${LINE}" = '<pause>' ]]; then
      read -s PAUSE < /dev/tty
    elif [[ "${LINE}" =~ ^\<sleep ]]; then
      local SLEEP_SECONDS="${LINE#*=}"
      sleep "${SLEEP_SECONDS/>}"
    elif [[ "${LINE}" = '<left>' ]]; then
      ALIGN='left'
    elif [[ "${LINE}" = '<right>' ]]; then
      ALIGN='right'
    elif [[ "${LINE}" = '<center>' ]]; then
      ALIGN='center'
    elif [[ "${LINE}" = '</left>' ]] || [[ "${LINE}" = '</right>' ]] || [[ "${LINE}" = '</center>' ]]; then
      ALIGN="${PRESET_ALIGN}"
    fi
  }
  format_defs
  local SLIDE=${1}
  local SLIDE_START=$(( TERM_HEIGHT / 8 - 1 ))
  LINE_COUNT=1
  echo "Slide: $((${SLIDE_NUM} + 1))/${#SLIDES[@]}"
  for ROW in $(eval echo "{0..$SLIDE_START}"); do
    echo
    (( LINE_COUNT++ ))
  done
  local ALIGN="${PRESET_ALIGN}"
  while IFS= read -r LINE; do
    slide_present_tags
    for FONT_KEY in "${!FONT_FORMATS[@]}"; do
      LINE=${LINE//$FONT_KEY/${FONT_FORMATS[$FONT_KEY]}}
    done
    if [[ "${ALIGN}" = 'left' ]]; then
      local BUFFER=$(( TERM_WIDTH / 10))
    elif [[ "${ALIGN}" = 'right' ]]; then
      local BUFFER=$(( $((TERM_WIDTH - ${#LINE})) - $((TERM_WIDTH / 10)) ))
    elif [[ "${ALIGN}" = 'center' ]]; then
      local BUFFER=$(( $((TERM_WIDTH - ${#LINE})) / 2 ))
    fi
    if [[ ! "${LINE}" =~ ^\<[a-z0-9=\/]*\>$ ]]; then
      for SPACE in $(eval echo "{0..$BUFFER}"); do
        echo -n ' '
      done
      echo -e "${LINE}"
      (( LINE_COUNT++ ))
    fi
  done < "${SLIDE}"
}

main() {
  # The main function provides the interface and command line argument features.
  local OPTION
  PRESET_ALIGN='left' # Sets the default text alignment to left.
  # Performs the getoots loop to detect and injest command line arguments.
  while getopts "a:hs:n:" OPTION; do
    case "${OPTION}" in
      a)
        # If the -a command is entered, open the align_text function with the
        # contents of the option following the argument.
        align_text "${OPTARG}";;
      h)
        # If the -h arugment is called, print the help message and exit with 
        # a sucessful exit code (0). Do not process any other arguments once 
        # detected.
        help_message
        exit 0;;
      s)
        # If the -s arugment is detected, set the SLIDES_DIR variable with the 
        # contents of the options following the argument. This will override 
        # default used in the assignment of the SLIDES array below.
        local SLIDES_DIR="${OPTARG}";;
      n)
        # If the -n argument is called, test to see if the subsequent option is
        # greater than zero, if so set the option to one less than requested, to
        # resolve the slides being indexed by zero issues, if the option is zero
        # then do not change it. Then pass fixed option into the START_SLIDE
        # variable.
        (( ${OPTARG} > 0?OPTARG--:OPTARG ))
        local START_SLIDE="${OPTARG}";;
      \?)
        # If any argument other than the ones above are detected, print the
        # help message then exit with a failure exit code (1). Do not process
        # any other arguments.
        help_message
        exit 1;;
    esac
  done
  term_size # Run the term_size function to detect the size of the terminal.
  SLIDES=($(echo "${SLIDES_DIR=.}/*.bp")) # All slides must end with .bp in
                                          # order to be detected. Also, sets
                                          # the default slides directory to
                                          # the current working directory if
                                          # not set by the -s command line
                                          # argument.
  SLIDE_NUM=${START_SLIDE-0} # Opens the first slide, zero indexed, if not
                             # specified by the -n command line argument.
  local QUIT='false'
  # Detects key presses to move between slides, to open the command interface,
  # or to quit.
  while [[ $QUIT == 'false' ]]; do 
    clear
    if [[ ${SLIDES[$SLIDE_NUM]} ]]; then # Determines if the requested slide
                                         # exists. If not, do nothing.
      slide_present "${SLIDES[$SLIDE_NUM]}" # Passes the requested slide number
                                            # to the slide_present function.
      read -r -sn 1 INPUT # Silently reads the first character entered as INPUT.
      case "${INPUT}" in
        ' '|''|l|k|A|C)
          # If the character entered is either a space, return character, l, k,
          # A, or C move to the next slide. A and C are the up and right arrow
          # keys.The ternary operation below ensures that the next slide will
          # not go past the last slide.
          (( $SLIDE_NUM < ${#SLIDES[@]} - 1?SLIDE_NUM++:SLIDE_NUM ));; 
        h|j|B|D)
          # If the character entered is an h, j, B, or D go back one slide. B 
          # and D are the down and left arrow keys. If the requested slide is
          # lower than the first slide, do nothing.
          (( $SLIDE_NUM > 0?SLIDE_NUM--:SLIDE_NUM ));;
        :)
          # The colon (":") key opens the command interface through the 
          # command_interface_spaces_default. See commentsunder the 
          # command_interface function for details.
          command_interface_spaces_default;;
        q)
          # If the character enters is q quit the program.
          QUIT='true';;
      esac
    fi
  done
  reset # Reset the terminal, this ensures that no formating done during the
        # presentation will linger once the presentation is over.
}

main "${@}"
