#!/usr/bin/env bash
#   █████╗ ██╗     ██╗███╗   ██╗███████╗    ██████╗ ██╗ ██████╗███████╗
#  ██╔══██╗██║     ██║████╗  ██║██╔════╝    ██╔══██╗██║██╔════╝██╔════╝
#  ███████║██║     ██║██╔██╗ ██║█████╗      ██████╔╝██║██║     █████╗
#  ██╔══██║██║     ██║██║╚██╗██║██╔══╝      ██╔══██╗██║██║     ██╔══╝
#  ██║  ██║███████╗██║██║ ╚████║███████╗    ██║  ██║██║╚██████╗███████╗
#  ╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝    ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝
#  Author  :  z0mbi3
#  Url     :  https://github.com/gh0stzk/dotfiles
#  About   :  This file will configure and launch the rice.
#

# Set bspwm configuration for Aline
set_bspwm_config() {
	bspc config border_width 0
	bspc config top_padding 57
	bspc config bottom_padding 2
	bspc config left_padding 2
	bspc config right_padding 2
	bspc config normal_border_color "#ca9ee6"
	bspc config active_border_color "#ca9ee6"
	bspc config focused_border_color "#8CAAEE"
	bspc config presel_feedback_color "#E78284"
}

# Reload terminal colors
set_term_config() {
	cat >"$HOME"/.config/alacritty/rice-colors.toml <<EOF
# (Rose Pine Dawn) color scheme for Aline Rice

# Default colors
[colors.primary]
background = "#faf4ed"
foreground = "#575279"

# Cursor colors
[colors.cursor]
text = "#575279"
cursor = "#cecacd"

# Normal colors
[colors.normal]
black = "#f2e9e1"
red = "#b4637a"
green = "#286983"
yellow = "#ea9d34"
blue = "#56949f"
magenta = "#907aa9"
cyan = "#d7827e"
white = "#575279"

# Bright colors
[colors.bright]
black = "#9893a5"
red = "#b4637a"
green = "#286983"
yellow = "#ea9d34"
blue = "#56949f"
magenta = "#907aa9"
cyan = "#d7827e"
white = "#575279"
EOF
}

# Set compositor configuration
#-e "s/normal = .*/normal =  { fade = true; shadow = true; }/g" \
set_picom_config() {
	sed -i "$HOME"/.config/bspwm/picom.conf \
		-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
		-e "s/corner-radius = .*/corner-radius = 6/g" \
		-e "s/\".*:class_g = 'Alacritty'\"/\"95:class_g = 'Alacritty'\"/g" \
		-e "s/\".*:class_g = 'FloaTerm'\"/\"95:class_g = 'FloaTerm'\"/g"
}

# Set stalonetray config
set_stalonetray_config() {
	sed -i "$HOME"/.config/bspwm/stalonetrayrc \
		-e "s/background .*/background \"#F4F5F8\"/" \
		-e "s/vertical .*/vertical true/" \
		-e "s/geometry .*/geometry 1x1-115+54/" \
		-e "s/grow_gravity .*/grow_gravity NE/" \
		-e "s/icon_gravity .*/icon_gravity NE/"
}

set_position_widgets() {
	sed -i "$HOME"/.config/bspwm/eww/player/player.yuck \
		-e 's/:geometry (geometry :x "[^"]*" :y "[^"]*"/:geometry (geometry :x "-33%" :y "-73.1%"/'
	sed -i "$HOME"/.config/bspwm/eww/calendar/calendar.yuck \
		-e 's/:geometry (geometry :x "[^"]*" :y "[^"]*"/:geometry (geometry :x "0%" :y "5.9%"/'
	sed -i "$HOME"/.config/bspwm/scripts/NetManagerDM.rasi \
		-e 's/\(x-offset:[[:space:]]*\)[^;]*/\136%/; s/\(y-offset:[[:space:]]*\)[^;]*/\15.9%/'
}

# Set dunst notification daemon config
set_dunst_config() {
	sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 3/g" \
		-e "s/frame_color = .*/frame_color = \"#e5eafe\"/g" \
		-e "s/separator_color = .*/separator_color = \"#fb007a\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#20bbfc'/g"
		
	sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
	cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
			[urgency_low]
			timeout = 3
			background = "#e5eafe"
			foreground = "#51576d"

			[urgency_normal]
			timeout = 6
			background = "#e5eafe"
			foreground = "#51576d"

			[urgency_critical]
			timeout = 0
			background = "#e5eafe"
			foreground = "#51576d"
_EOF_
}

# Set eww colors
set_eww_colors() {
	cat > "$HOME"/.config/bspwm/eww/colors.scss << EOF
// Eww colors for Aline rice
\$bg: #f4f5f8;
\$bg-alt: #e5eafe;
\$fg: #51576d;
\$black: #212121;
\$lightblack: #262831;
\$red: #c30771;
\$blue: #008ec4;
\$cyan: #20a5ba;
\$magenta: #523c79;
\$green: #10a778;
\$yellow: #a89c14;
\$archicon: #0f94d2;
EOF
}

# Set jgmenu colors for Aline
set_jgmenu_colors() {
	sed -i "$HOME"/.config/bspwm/jgmenurc \
		-e 's/color_menu_bg = .*/color_menu_bg = #f4f5f8/' \
		-e 's/color_norm_fg = .*/color_norm_fg = #51576d/' \
		-e 's/color_sel_bg = .*/color_sel_bg = #e5eafe/' \
		-e 's/color_sel_fg = .*/color_sel_fg = #51576d/' \
		-e 's/color_sep_fg = .*/color_sep_fg = #212121/'
}

# Set Rofi launcher config
set_launcher_config () {
	sed -i "$HOME/.config/bspwm/scripts/Launcher.rasi" \
		-e 's/\(font: \).*/\1"JetBrainsMono Nerd Font Bold 9";/' \
		-e 's/\(background: \).*/\1#f4f5f8;/' \
		-e 's/\(background-alt: \).*/\1#f4f5f8E0;/' \
		-e 's/\(foreground: \).*/\1#49495a;/' \
		-e 's/\(selected: \).*/\1#ee6388;/' \
		-e "s/rices\/[[:alnum:]\-]*/rices\/${RICETHEME}/g"
	# NetworkManager launcher
	sed -i "$HOME/.config/bspwm/scripts/NetManagerDM.rasi" \
		-e '12s/\(background: \).*/\1#faf4ed;/' \
		-e '13s/\(background-alt: \).*/\1#f2e9e1;/' \
		-e '14s/\(foreground: \).*/\1#575279;/' \
		-e '15s/\(selected: \).*/\1#d7827e;/' \
		-e '16s/\(active: \).*/\1#286983;/' \
		-e '17s/\(urgent: \).*/\1#d7827e;/'
}

# Launch the bar
launch_bars() {
	
	for mon in $(polybar --list-monitors | cut -d":" -f1); do
		MONITOR=$mon polybar -q aline-bar -c ${rice_dir}/config.ini &
	done
	
}



### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_picom_config
set_stalonetray_config
launch_bars
set_dunst_config
set_eww_colors
set_jgmenu_colors
set_launcher_config
set_position_widgets
