declare -A FONT_FORMATS
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
