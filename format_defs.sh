declare -A FORMATS
FORMATS['<clear>']='\e[0m'           # Text Reset

# Regular Colors
FORMATS['<black>']='\e[0;30m'        # Black
FORMATS['<red>']='\e[0;31m'          # Red
FORMATS['<green>']='\e[0;32m'        # Green
FORMATS['<yellow>']='\e[0;33m'       # Yellow
FORMATS['<blue>']='\e[0;34m'         # Blue
FORMATS['<purple>']='\e[0;35m'       # Purple
FORMATS['<cyan>']='\e[0;36m'         # Cyan
FORMATS['<white>']='\e[0;37m'        # White

# Bold
FORMATS['<bblack>']='\e[1;30m'       # Black
FORMATS['<bred>']='\e[1;31m'         # Red
FORMATS['<bgreen>']='\e[1;32m'       # Green
FORMATS['<byellow>']='\e[1;33m'      # Yellow
FORMATS['<bblue>']='\e[1;34m'        # Blue
FORMATS['<bpurple>']='\e[1;35m'      # Purple
FORMATS['<bcyan>']='\e[1;36m'        # Cyan
FORMATS['<bwhite>']='\e[1;37m'       # White

# Underline
FORMATS['<ublack>']='\e[4;30m'       # Black
FORMATS['<ured>']='\e[4;31m'         # Red
FORMATS['<ugreen>']='\e[4;32m'       # Green
FORMATS['<uyellow>']='\e[4;33m'      # Yellow
FORMATS['<ublue>']='\e[4;34m'        # Blue
FORMATS['<upurple>']='\e[4;35m'      # Purple
FORMATS['<ucyan>']='\e[4;36m'        # Cyan
FORMATS['<uwhite>']='\e[4;37m'       # White

# Background
FORMATS['<on_black>']='\e[40m'       # Black
FORMATS['<on_red>']='\e[41m'         # Red
FORMATS['<on_green>']='\e[42m'       # Green
FORMATS['<on_yellow>']='\e[43m'      # Yellow
FORMATS['<on_blue>']='\e[44m'        # Blue
FORMATS['<on_purple>']='\e[45m'      # Purple
FORMATS['<on_cyan>']='\e[46m'        # Cyan
FORMATS['<on_white>']='\e[47m'       # White

# High Intensity
FORMATS['<iblack>']='\e[0;90m'       # Black
FORMATS['<ired>']='\e[0;91m'         # Red
FORMATS['<igreen>']='\e[0;92m'       # Green
FORMATS['<iyellow>']='\e[0;93m'      # Yellow
FORMATS['<iblue>']='\e[0;94m'        # Blue
FORMATS['<ipurple>']='\e[0;95m'      # Purple
FORMATS['<icyan>']='\e[0;96m'        # Cyan
FORMATS['<iwhite>']='\e[0;97m'       # White

# Bold High Intensity
FORMATS['<biblack>']='\e[1;90m'      # Black
FORMATS['<bired>']='\e[1;91m'        # Red
FORMATS['<bigreen>']='\e[1;92m'      # Green
FORMATS['<biyellow>']='\e[1;93m'     # Yellow
FORMATS['<biblue>']='\e[1;94m'       # Blue
FORMATS['<bipurple>']='\e[1;95m'     # Purple
FORMATS['<bicyan>']='\e[1;96m'       # Cyan
FORMATS['<biwhite>']='\e[1;97m'      # White

# High Intensity backgrounds
FORMATS['<on_iblack>']='\e[0;100m'   # Black
FORMATS['<on_ired>']='\e[0;101m'     # Red
FORMATS['<on_igreen>']='\e[0;102m'   # Green
FORMATS['<on_iyellow>']='\e[0;103m'  # Yellow
FORMATS['<on_iblue>']='\e[0;104m'    # Blue
FORMATS['<on_ipurple>']='\e[0;105m'  # Purple
FORMATS['<on_icyan>']='\e[0;106m'    # Cyan
FORMATS['<on_iwhite>']='\e[0;107m'   # White
