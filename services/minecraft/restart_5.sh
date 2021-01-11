#!/bin/bash

tmux_session_name="mcserver"

tellraw_command="tellraw @a [{\"color\":\"red\",\"text\":\"[WARN]\"},{\"color\":\"gold\",\"text\":\" Restarting in 5 minutes!\"}]"

tmux send-keys -t "${tmux_session_name}" "${tellraw_command}" ENTER
