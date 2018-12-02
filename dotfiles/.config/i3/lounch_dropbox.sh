# Terminate already running bar instances
pkill dropbox

# Wait until the processes have been shut down
while pgrep -u $UID -x dropbox >/dev/null; do sleep 1; done

# Launch 
dropbox
