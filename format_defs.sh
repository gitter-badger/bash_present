declare -A formats
formats['<Clear>']='\e[0m'           # Text Reset

# Regular Colors
formats['<Black>']='\e[0;30m'        # Black
formats['<Red>']='\e[0;31m'          # Red
formats['<Green>']='\e[0;32m'        # Green
formats['<Yellow>']='\e[0;33m'       # Yellow
formats['<Blue>']='\e[0;34m'         # Blue
formats['<Purple>']='\e[0;35m'       # Purple
formats['<Cyan>']='\e[0;36m'         # Cyan
formats['<White>']='\e[0;37m'        # White

# Bold
formats['<BBlack>']='\e[1;30m'       # Black
formats['<BRed>']='\e[1;31m'         # Red
formats['<BGreen>']='\e[1;32m'       # Green
formats['<BYellow>']='\e[1;33m'      # Yellow
formats['<BBlue>']='\e[1;34m'        # Blue
formats['<BPurple>']='\e[1;35m'      # Purple
formats['<BCyan>']='\e[1;36m'        # Cyan
formats['<BWhite>']='\e[1;37m'       # White

# Underline
formats['<UBlack>']='\e[4;30m'       # Black
formats['<URed>']='\e[4;31m'         # Red
formats['<UGreen>']='\e[4;32m'       # Green
formats['<UYellow>']='\e[4;33m'      # Yellow
formats['<UBlue>']='\e[4;34m'        # Blue
formats['<UPurple>']='\e[4;35m'      # Purple
formats['<UCyan>']='\e[4;36m'        # Cyan
formats['<UWhite>']='\e[4;37m'       # White

# Background
formats['<On_Black>']='\e[40m'       # Black
formats['<On_Red>']='\e[41m'         # Red
formats['<On_Green>']='\e[42m'       # Green
formats['<On_Yellow>']='\e[43m'      # Yellow
formats['<On_Blue>']='\e[44m'        # Blue
formats['<On_Purple>']='\e[45m'      # Purple
formats['<On_Cyan>']='\e[46m'        # Cyan
formats['<On_White>']='\e[47m'       # White

# High Intensity
formats['<IBlack>']='\e[0;90m'       # Black
formats['<IRed>']='\e[0;91m'         # Red
formats['<IGreen>']='\e[0;92m'       # Green
formats['<IYellow>']='\e[0;93m'      # Yellow
formats['<IBlue>']='\e[0;94m'        # Blue
formats['<IPurple>']='\e[0;95m'      # Purple
formats['<ICyan>']='\e[0;96m'        # Cyan
formats['<IWhite>']='\e[0;97m'       # White

# Bold High Intensity
formats['<BIBlack>']='\e[1;90m'      # Black
formats['<BIRed>']='\e[1;91m'        # Red
formats['<BIGreen>']='\e[1;92m'      # Green
formats['<BIYellow>']='\e[1;93m'     # Yellow
formats['<BIBlue>']='\e[1;94m'       # Blue
formats['<BIPurple>']='\e[1;95m'     # Purple
formats['<BICyan>']='\e[1;96m'       # Cyan
formats['<BIWhite>']='\e[1;97m'      # White

# High Intensity backgrounds
formats['<On_IBlack>']='\e[0;100m'   # Black
formats['<On_IRed>']='\e[0;101m'     # Red
formats['<On_IGreen>']='\e[0;102m'   # Green
formats['<On_IYellow>']='\e[0;103m'  # Yellow
formats['<On_IBlue>']='\e[0;104m'    # Blue
formats['<On_IPurple>']='\e[0;105m'  # Purple
formats['<On_ICyan>']='\e[0;106m'    # Cyan
formats['<On_IWhite>']='\e[0;107m'   # White
