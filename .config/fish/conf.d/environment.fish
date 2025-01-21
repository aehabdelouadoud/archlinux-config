export SCRIPTS_DIR="/home/x/dotfiles/scripts"
export CHROME_EXECUTABLE="firefox"

# AndroidSDK
export ANDROID_HOME=/opt/android-sdk
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

# Luarocks
export PATH="$HOME/.luarocks/bin/:$PATH"
# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Colorizing man pages
set -g man_blink -o red
set -g man_bold -o cyan
set -g man_standout -b yellow black
set -g man_underline -u blue

# ls colors
set -x LS_COLORS "di=1;37"  # Bold white for directories

