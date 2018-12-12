
program=$1
args=${@:2}

# Terminate already running instances
pkill $program
# Wait until the processes have been shut down
while pgrep -u $UID -x $program >/dev/null; do sleep 1; done
# Launch 
command $program $args
