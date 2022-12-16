left_arr=$'\ue0c4'
right_arr=$'\ue0c6'
left_digitize_small=$'\ue0c5'
right_digitize_small=$'\ue0c2'
circle=$'\uf111'
hollow_circle=$'\uf10c'
home_circle=$'\ufcd0'
half_circle_right=$'\ue0b4'
half_circle_left=$'\ue0b6'
half_crescent_right=$'\ue0b5'
half_crescent_left=$'\ue0b7'
# TODO increase font size for manjaro icon.
user_icon=$'\u16c4'
# 0-15 are set by pywal!
term_default_bg="000"
col1="007"
col2="001"
# TODO MAYBE A PHASE OF THE MOON INDICATOR?

#local return_code="%(?..%?)"

PROMPT="%{$FG[$col1]$BG[$col2]%} $user_icon %{$FG[$col2]$BG[$col1]%}$half_circle_right$half_crescent_right %* %{$reset_color%}%F{$col1}%{$BG[$col2]%}$half_circle_right$half_crescent_right %n %F{$col2}%{$BG[$col1]%}$half_circle_right$half_crescent_right %~ %{$FG[$col1]$BG[$term_default_bg]%}$half_circle_right$half_crescent_right %{$reset_color%}"
# show error code on right side if something went awry.
if [ "${return_code}" -ne "1" ]; then
	RPS1='%{$FG[160]%}[%?] %{$reset_color%}'
fi
