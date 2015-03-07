# ! /bin/bash

help_message() {
  local HELP_MESSAGE='  bash_present.sh is a script designed to show off the advanced 
  features of the BASH language. Below you can find the options
  which are accepted by the script to change behavior:
  -a) The -a defines the default alignment for slides and
      therefore must be followed by either left, right, or center.
  -h) Displays this help message.

  -s) Declare the directory in which the slides are stored.
  
  -n) The integer value of the slide on which the presentation
      should begin. The is zero indexed.
      
  One can Control the presentation once it has begun using the
  following hotkeys:
  space, return, and l move to the next slide.
  h moves to the privious slide.
  q exits the program.'
  
  echo "${HELP_MESSAGE}"
}

term_size() {
  TERM_SIZE=$(read -p $'\e[18t' -s -r -d t size; echo ${size#*;})
  TERM_WIDTH=${TERM_SIZE/*;}
  TERM_HEIGHT=${TERM_SIZE/;*}
}

align_text() {
  if [[ "${1}" = 'left' ]]; then
    PRESET_ALIGN='left'
  elif [[ "${1}" = 'right' ]]; then
    PRESET_ALIGN='right'
  elif [[ "${1}" = 'center' ]]; then
    PRESET_ALIGN='right'
  else
    help_message
    exit 1
  fi
}

command_interface() {
  LINES=$(($TERM_HEIGHT - $LINE_COUNT - 2))
  for LINE in $(eval echo {0..$LINES}); do
    echo
  done
  read -p ':' COMMAND
  if [[ "${COMMAND}" =~ goto\ [0-9]+ ]]; then
    NEW_SLIDE="((${COMMAND#* } - 1))"
    if (( ${NEW_SLIDE} >= 0 )) && (( ${NEW_SLIDE} < ${#SLIDES[@]} )); then
      SLIDE_NUM="${NEW_SLIDE}"
    fi
  elif [[ "${COMMAND}" = 'quit' ]] || [[ "${COMMAND}" = 'q' ]]; then
    QUIT='true'
  fi
}

slide_present() {
  slide_present_tags() {
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

  local SLIDE=${1}
  local SLIDE_START=$(( TERM_HEIGHT / 6 - 1 ))
  LINE_COUNT=1
  echo "Slide: $((${SLIDE_NUM} + 1))/${#SLIDES[@]}"
  for ROW in $(eval echo "{0..$SLIDE_START}"); do
    echo
    (( LINE_COUNT++ ))
  done
  local ALIGN="${PRESET_ALIGN}"
  while IFS= read -r LINE; do
    slide_present_tags
    if [[ "${ALIGN}" = 'left' ]]; then
      local BUFFER=$(( TERM_WIDTH / 4))
    elif [[ "${ALIGN}" = 'right' ]]; then
      local BUFFER=$(( $((TERM_WIDTH - ${#LINE})) - $((TERM_WIDTH / 4)) ))
    elif [[ "${ALIGN}" = 'center' ]]; then
      local BUFFER=$(( $((TERM_WIDTH - ${#LINE})) / 2 ))
    fi    
    if [[ ! "${LINE}" =~ ^\<.*\>$ ]]; then
      for SPACE in $(eval echo "{0..$BUFFER}"); do
        echo -n ' '
      done
      echo -e "${LINE}"
      (( LINE_COUNT++ ))
    fi
  done < "${SLIDE}"
}

main() {
  local OPTION
  PRESET_ALIGN='left'
  while getopts "a:hs:n:" OPTION; do
    case "${OPTION}" in
      a)
        align_text "${OPTARG}";;
      h)
        help_message
        exit 0;;
      s)
        local SLIDES_DIR="${OPTARG}";;
      n)
        local START_SLIDE="${OPTARG}";;
      \?)
        help_message
        exit 1;;
    esac
  done
  term_size
  SLIDES=($(echo "${SLIDES_DIR=.}/*.bp"))
  SLIDE_NUM=${START_SLIDE-0}
  local QUIT='false'
  while [[ $QUIT == 'false' ]]; do
    clear
    if [[ ${SLIDES[$SLIDE_NUM]} ]]; then
      slide_present "${SLIDES[$SLIDE_NUM]}"
      read -sn 1 INPUT
      case "${INPUT}" in
        ' ')
          (( $SLIDE_NUM < ${#SLIDES[@]} - 1?SLIDE_NUM++:SLIDE_NUM ));;
        '')
          (( $SLIDE_NUM < ${#SLIDES[@]} - 1?SLIDE_NUM++:SLIDE_NUM ));;
        l)
          (( $SLIDE_NUM < ${#SLIDES[@]} - 1?SLIDE_NUM++:SLIDE_NUM ));;
        h)
          (( $SLIDE_NUM > 0?SLIDE_NUM--:SLIDE_NUM ));;
        :)
          command_interface;;
        q)
          QUIT='true';;
      esac
    fi
  done
  clear
}

main ${@}
