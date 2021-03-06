#=========================================================
#Terminal Color Codes
#=========================================================
WHITE='\[\033[1;37m\]'
LIGHTGRAY='\[\033[0;37m\]'
GRAY='\[\033[1;30m\]'
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
LIGHTRED='\[\033[1;31m\]'
GREEN='\[\033[0;32m\]'
LIGHTGREEN='\[\033[1;32m\]'
BROWN='\[\033[0;33m\]' #Orange
YELLOW='\[\033[1;33m\]'
BLUE='\[\033[0;34m\]'
LIGHTBLUE='\[\033[1;34m\]'
PURPLE='\[\033[0;35m\]'
PINK='\[\033[1;35m\]' #Light Purple
CYAN='\[\033[0;36m\]'
LIGHTCYAN='\[\033[1;36m\]'
DEFAULT='\[\033[0m\]'

#=========================================================
# User Configuration
#=========================================================
# Colors
cLINES=$LIGHTBLUE #Lines and Arrow
cBRACKETS=$LIGHTBLUE # Brackets around each data item
cERROR=$LIGHTRED # Error block when previous command did not return 0
cTIME=$LIGHTGRAY # The current time
cMPX1=$YELLOW # Color for terminal multiplexer threshold 1
cMPX2=$RED # Color for terminal multiplexer threshold 2
cBGJ1=$YELLOW # Color for background job threshold 1
cBGJ2=$RED # Color for background job threshold 2
cSTJ1=$YELLOW # Color for background job threshold 1
cSTJ2=$RED # Color for  background job threshold 2
cSSH=$PINK # Color for brackets if session is an SSH session
cUSR=$CYAN # Color of user
cUHS=$LIGHTBLUE # Color of the user and hostname separator, probably '@'
cHST=$CYAN # Color of hostname
cRWN=$RED # Color of root warning
cPWD=$LIGHTGRAY # Color of current directory
cCMD=$DEFAULT # Color of the command you type
cBRANCH=$LIGHTGRAY
cBRDEC=$LIGHTBLUE
cBRDEC_UNSTAGED=$YELLOW

# Enable block
eNL=1  # Have a newline between previous command output and new prompt
eERR=1 # Previous command return status tracker
eSSH=1 # Track if session is SSH
eUSH=1 # Show user and host
ePWD=1 # Show current directory
errChr=$(echo -e "\u2508")
branchDec=$(echo -e "\u2508")



function updateGitBranch()
{
     
    gitBranch=$(git branch 2>/dev/null | grep '*') || unset gitBranch
    if [ -n "$gitBranch" ]; then 
        status=$(git status)
        if echo $status | grep 'tree clean'; then
            cDEC=${cBRDEC}
        else
            cDEC=${cBRDEC_UNSTAGED}
        fi

        gitBranch=${gitBranch:2};
        gitBranch="${cLINES}\342\224\202${cDEC}${branchDec} ${cBRANCH}${gitBranch} ${cDEC}${branchDec}"
    fi
}
#\342\226\221 shaded

#\342\226\240 solid
function promptcmd()
{
        PREVRET=$?
        updateGitBranch
        #=========================================================
        #check if user is in ssh session
        #=========================================================
        if [[ $SSH_CLIENT ]] || [[ $SSH2_CLIENT ]]; then
                lSSH_FLAG=1
        else
                lSSH_FLAG=0
        fi

        #=========================================================
        # Insert a new line to clear space from previous command
        #=========================================================
        PS1="\n"

        #=========================================================
        # Beginning of first line (arrow wrap around and color setup)
        #=========================================================
        PS1="${PS1}${cLINES}\342\224\214\342\224\200"

        #=========================================================
        # First Dynamic Block - Previous Command Error
        #=========================================================
        if [ $PREVRET -ne 0 ] ; then
                PS1="${PS1}${cBRACKETS}[${cERROR}${errChr}${cBRACKETS}]${cLINES}\342\224\200"
        fi

        #=========================================================
        # First static block - Current time
        #=========================================================
        PS1="${PS1}${cBRACKETS}[${cTIME}\t${cBRACKETS}]${cLINES}\342\224\200"

        #=========================================================
        # Second Static block - User@host
        #=========================================================
        # set color for brackets if user is in ssh session
        if [ $lSSH_FLAG -eq 1 ] ; then
                sesClr="$cSSH"
        else
                sesClr="$cBRACKETS"
        fi
        # don't display user if root
        if [ $EUID -eq 0 ] ; then
                PS1="${PS1}${sesClr}[${cRWN}!"
        else
                PS1="${PS1}${sesClr}[${cUSR}\u${cUHS}@${UHS}"
        fi
        PS1="${PS1}${cHST}\h${sesClr}]${cLINES}\342\224\200"

        #=========================================================
        # Third Static Block - Current Directory
        #=========================================================
        PS1="${PS1}[${cPWD}\w${cBRACKETS}]"

        #=========================================================
        # Dynamic Line - Git branch
        #=========================================================
        if [ -n "$gitBranch" ]; then
            PS1="${PS1}\n${gitBranch}"
        fi
        #=========================================================
        # Final line / Prompt
        #=========================================================

        PS1="${PS1}\n${cLINES}\342\224\224\342\224\200\342\224\200> ${cCMD}"
        export PS1 

}


PROMPT_COMMAND=promptcmd
