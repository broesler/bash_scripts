#===============================================================================
#     File: rmt
#  Created: 11/25/2015, 19:28
#   Author: Bernie Roesler
#
# Last Modified: 05/20/2016, 13:38
#
#  Description: [r]un [m]atlab command from [t]mux 
#
#  Usage: $rmt cmd;    # sends "cmd" to matlab if running, or opens matlab in
#                      # the bottom-left pane of the current window if not.
#         $rmt -p cmd; # sends "cmd" to matlab and prints entire matlab window
#                      # to the current stdout
#  vim: set ft=sh syn=sh:
#===============================================================================
if [ -z "$TMUX" ]; then
  echo 'Usage: rmt [p] [command] must be run inside tmux session.' 1>&2
  exit 1
fi

# Initialize variables
printout=0
other_session=0

# Get arguments
while getopts ":ps" opt; do
  case $opt in
    p) 
      printout=1 ;;
    s) 
      other_session=1 ;;
    \?)
      echo "Invalid option: -$OPTARG" 1>&2
      exit 1
      ;;
    :)
      echo "Usage: option -$OPTARG requires an argument." 1>&2
      exit 1
      ;;
  esac
done

# shift the arguments to skip over the options to the real arguments (NOT
# including those assigned by $OPTARG above)
shift $((OPTIND-1))     
args="$@"

# Get session/window/pane ID from tmux (empty string if not running)
# NOTE: tpgrep returns the lowest tty00x number, presumably the earliest opened
#   matlab instance. Could potentially update this script to select from any
#   number of sessions, and remember choice until instance is terminated.
tmuxswp=$(tpgrep '[r]lwrap.*matlab')

#---------------------------------------------------------------------------
# Check if matlab is running
#---------------------------------------------------------------------------
if [ -n "$tmuxswp" ]; then
  #-----------------------------------------------------------------------
  # Check to see if Matlab is in another session
  #-----------------------------------------------------------------------
  this_session=$(tmux display-message -p "#{session_id}")
  if [ "${tmuxswp:0:2}" != "$this_session" ]; then
    #-------------------------------------------------------------------
    # Check for arguments
    #-------------------------------------------------------------------
    if [ -n "$args" ]; then
      # Use '-s' flag to run Matlab in other session if it is running there
      if [ "$other_session" -eq 0 ]; then
        # TODO: Need to find Matlab pane IN THIS SESSION
        # if '-s' flag not used, just open new instance of Matlab in this
        # session, bottom-left pane
        ts -t "bottom-left" "matlabrl"
        ts -t "bottom-left" "$args"
        if [ "$printout" -eq 1 ]; then
          # print output from matlab pane to stdout
          fmo "bottom-left"
        fi
      else # '-s' is used, so run command in that session
        ts -t "$tmuxswp" "$args"
        if [ "$printout" -eq 1 ]; then
          # print output from matlab pane to stdout of THIS session
          fmo "$tmuxswp"
        fi
      fi

    #---------------------------------------------------------------
    else  # no arguments, possibly switch to other session
    #---------------------------------------------------------------
      if [ "$other_session" -eq 1 ]; then
        tms "$tmuxswp"
      else
        # TODO: else switch to Matlab's pane in this session... need to find ID
        echo 'Matlab is running in this session!'
      fi
    fi # args check

  #-------------------------------------------------------------------
  else # MATLAB running in same session
  #-------------------------------------------------------------------
    # Check arguments
    if [ -n "$args" ]; then
      ts -t "$tmuxswp" "$args"
      if [ "$printout" -eq 1 ]; then
        # print output from matlab pane to stdout
        fmo "$tmuxswp"
      fi
    else
      # move to pane with instance of matlab
      tms "$tmuxswp"
    fi
  fi # session check

#-----------------------------------------------------------------------
else # MATLAB not running anywhere
#-----------------------------------------------------------------------
  # use bottom-left as default
  tmuxswp="bottom-left"

  if [ -n "$args" ]; then
    # open matlab first, then send the command
    ts -t "$tmuxswp" "matlabrl"
    ts -t "$tmuxswp" "$args"
  else
    # if no arguments given, just open MATLAB
    ts -t "$tmuxswp" 'matlabrl'
  fi
fi


exit 0
#===============================================================================
#===============================================================================
