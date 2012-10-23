# -- DO NOT EDIT --
# This file is managed by puppet. Any changes will be reverted.

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
