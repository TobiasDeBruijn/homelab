#!/bin/bash

tmux_session_name="mcserver"

tellraw_command="save-all"

tmux send-keys -t "${tmux_session_name}" "${tellraw_command}" ENTER
