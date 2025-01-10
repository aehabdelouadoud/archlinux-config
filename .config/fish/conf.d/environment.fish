#
export DISTRO="arch" # To know the distro.
export SCRIPTS_DIR="/home/x/dotfiles/scripts"

export CHROME_EXECUTABLE="google-chrome-stable"

# Android sdk
export ANDROID_HOME=/opt/android-sdk
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

#
set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths

# Eza colors
set -x LS_COLORS "di=1;37"  # Bold white for directories

# Colored man pages
set -g man_blink -o red
set -g man_bold -o yellow
set -g man_standout -b black red
set -g man_underline -u magenta
