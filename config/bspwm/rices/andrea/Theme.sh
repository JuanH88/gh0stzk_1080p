#!/usr/bin/env bash
#   █████╗ ███╗   ██╗██████╗ ██████╗ ███████╗ █████╗     ██████╗ ██╗ ██████╗███████╗
#  ██╔══██╗████╗  ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗    ██╔══██╗██║██╔════╝██╔════╝
#  ███████║██╔██╗ ██║██║  ██║██████╔╝█████╗  ███████║    ██████╔╝██║██║     █████╗
#  ██╔══██║██║╚██╗██║██║  ██║██╔══██╗██╔══╝  ██╔══██║    ██╔══██╗██║██║     ██╔══╝
#  ██║  ██║██║ ╚████║██████╔╝██║  ██║███████╗██║  ██║    ██║  ██║██║╚██████╗███████╗
#  ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝
#  Author  :  z0mbi3
#  Url     :  https://github.com/gh0stzk/dotfiles
#  About   :  This file will configure and launch the rice.
#

# Set bspwm configuration for Andrea
set_bspwm_config() {
	bspc config border_width 0
	bspc config top_padding 67
	bspc config bottom_padding 2
	bspc config left_padding 2
	bspc config right_padding 2
	bspc config normal_border_color "#161616"
	bspc config active_border_color "#161616"
	bspc config focused_border_color "#605692"
	bspc config presel_feedback_color "#67d4f1"
}

pidof -q bspc && pkill -9 bspc > /dev/null

# Reload terminal colors
set_term_config() {
	cat >"$HOME"/.config/alacritty/rice-colors.toml <<EOF
# Color scheme for Andrea Rice

# Default colors
[colors.primary]
background = "#FDF0ED"
foreground = "#151515"

# Cursor colors
[colors.cursor]
cursor = "#b0a5ed"
text = "#ededed"

# Normal colors
[colors.normal]
black = "#151515"
blue = "#65C7E3"
cyan = "#2eccca"
green = "#1EB980"
magenta = "#b0a5ed"
red = "#DA103F"
white = "#ededed"
yellow = "#FFCC57"

# Bright colors
[colors.bright]
black = "#666666"
blue = "#3FC6DE"
cyan = "#1EAEAE"
green = "#07DA8C"
magenta = "#F075B7"
red = "#F43E5C"
white = "#16161C"
yellow = "#F77D26"
EOF
}

# Set compositor configuration
#-e "s/normal = .*/normal =  { fade = true; shadow = true; }/g" \
set_picom_config() {
	sed -i "$HOME"/.config/bspwm/picom.conf \
		-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
		-e "s/corner-radius = .*/corner-radius = 6/g" \
		-e "s/\".*:class_g = 'Alacritty'\"/\"100:class_g = 'Alacritty'\"/g" \
		-e "s/\".*:class_g = 'FloaTerm'\"/\"100:class_g = 'FloaTerm'\"/g"
}

set_position_eww_player() {
	sed -i "$HOME"/.config/bspwm/eww/player/player.yuck \
		-e 's/:geometry (geometry :x "[^"]*" :y "[^"]*"/:geometry (geometry :x "14.3%" :y "-71.9%"/'
		#-e 's/:geometry (geometry :x "[^"]*"/:geometry (geometry :x "14.3%"/'
		#-e ':a;N;$!ba;s/:geometry (geometry :x "[^"]*"\n:y "[^"]*"/:geometry (geometry :x ""\n:y "-71.9%"/'
}

# Set dunst notification daemon config
set_dunst_config() {
	sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 1/g" \
		-e "s/frame_color = .*/frame_color = \"#FDF0ED\"/g" \
		-e "s/separator_color = .*/separator_color = \"#605692\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#605692'/g"
		
	sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
	cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
			[urgency_low]
			timeout = 3
			background = "#FDF0ED"
			foreground = "#151515"

			[urgency_normal]
			timeout = 6
			background = "#FDF0ED"
			foreground = "#151515"

			[urgency_critical]
			timeout = 0
			background = "#FDF0ED"
			foreground = "#151515"
_EOF_
}

# Set eww colors
set_eww_colors() {
	cat > "$HOME"/.config/bspwm/eww/colors.scss << EOF
// Eww colors for Andrea rice
\$bg: #FDF0ED;
\$bg-alt: #F0E9E2;
\$fg: #479799;
\$black: #16161C;
\$lightblack: #262831;
\$red: #DA103F;
\$blue: #65C7E3;
\$cyan: #2eccca;
\$magenta: #b0a5ed;
\$green: #1EB980;
\$yellow: #FFCC57;
\$archicon: #0f94d2;
EOF
}

# Set jgmenu colors for Andrea
set_jgmenu_colors() {
	sed -i "$HOME"/.config/bspwm/jgmenurc \
		-e 's/color_menu_bg = .*/color_menu_bg = #FDF0ED/' \
		-e 's/color_norm_fg = .*/color_norm_fg = #151515/' \
		-e 's/color_sel_bg = .*/color_sel_bg = #F0E9E2/' \
		-e 's/color_sel_fg = .*/color_sel_fg = #151515/' \
		-e 's/color_sep_fg = .*/color_sep_fg = #1A1C23/'
}

# Set Rofi launcher config
set_launcher_config () {
	sed -i "$HOME/.config/bspwm/scripts/Launcher.rasi" \
		-e 's/\(font: \).*/\1"JetBrainsMono Nerd Font Bold 9";/' \
		-e 's/\(background: \).*/\1#f5eee6;/' \
		-e 's/\(background-alt: \).*/\1#f5eee6E0;/' \
		-e 's/\(foreground: \).*/\1#151515;/' \
		-e 's/\(selected: \).*/\1#67d4f1;/' \
		-e "s/rices\/[[:alnum:]\-]*/rices\/${RICETHEME}/g"
	# NetworkManager launcher
	sed -i "$HOME/.config/bspwm/scripts/NetManagerDM.rasi" \
		-e '12s/\(background: \).*/\1#f5eee6;/' \
		-e '13s/\(background-alt: \).*/\1#F0E9E2;/' \
		-e '14s/\(foreground: \).*/\1#151515;/' \
		-e '15s/\(selected: \).*/\1#67d4f1;/' \
		-e '16s/\(active: \).*/\1#b0a5ed;/' \
		-e '17s/\(urgent: \).*/\1#F43E5C;/'
}

# Launch the bar
launch_bars() {
	eww -c ${rice_dir}/andy open --toggle bar
}



### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_picom_config
launch_bars
set_dunst_config
set_eww_colors
set_jgmenu_colors
set_launcher_config
set_position_eww_player
