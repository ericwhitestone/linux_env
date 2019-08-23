#=========================================================
#Terminal Color Codes
#=========================================================
WHITE='\033[1;37m'
LIGHTGRAY='\033[0;37m'
GRAY='\033[1;30m'
BLACK='\033[0;30m'
RED='\033[0;31m'
LIGHTRED='\033[1;31m'
GREEN='\033[0;32m'
LIGHTGREEN='\033[1;32m'
BROWN='\033[0;33m' #Orange
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
LIGHTBLUE='\033[1;34m'
PURPLE='\033[0;35m'
PINK='\033[1;35m' #Light Purple
CYAN='\033[0;36m'
LIGHTCYAN='\033[1;36m'
DEFAULT='\033[0m'

COLORLIST="WHITE LIGHTGRAY GRAY
BLACK RED LIGHTRED GREEN LIGHTGREEN BROWN YELLOW BLUE LIGHTBLUE PURPLE PINK CYAN LIGHTCYAN DEFAULT" 

for color in $COLORLIST 
do
    echo $color
done

echo -e "${LIGHTGRAY}this is light gray"
