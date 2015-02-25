#! /bin/bash

term_size() {
  TERM_SIZE=$(read -p $'\e[18t' -s -r -d t size; echo ${size#*;})
  TERM_WIDTH=${TERM_SIZE/*;}
  TERM_HEIGHT=${TERM_SIZE/;*}
}

slide_present() {
  clear
  local SLIDE=${1}
  local SLIDE_START=$(( TERM_HEIGHT / 5 ))
  for ROW in $(eval echo "{0..$SLIDE_START}"); do
    echo
  done
  while IFS= read -r LINE; do
    local BUFFER=$(( $((TERM_WIDTH - ${#LINE})) / 2 ))	
    for SPACE in $(eval echo "{0..$BUFFER}"); do
      echo -n ' '
    done
    echo "${LINE}"
  done < "${SLIDE}"
}

help_message() {
  local HELP_MESSAGE='advanced_bash.sh is a script designed
  to show off the advanced features of the BASH
  language. Below you can find the options which
  are accepted by the script to change behavior:

  -h) Displays this help message.

  -s) Declare the directory in which the slides are stored.'
  echo "${HELP_MESSAGE}"
}

main() {
  local OPTION
  while getopts "hs:" OPTION; do
    case "$OPTION" in
      h)
        help_message
        exit 0;;
      s)
        SLIDES_DIR="${OPTARG}";;
      ?)
        echo "${OPTION} is an invalid option."
        help_message
        exit 1;;
    esac
  done
  term_size
  for SLIDE in $(ls -1 ${SLIDES_DIR}); do
    slide_present "${SLIDES_DIR}/${SLIDE}"
    read ENTER
  done
  clear
}


main ${@}
