
export: 
	cp ./sway/config ~/.config/sway/config
	cp -r ./waybar/* ~/.config/waybar/.

import:
	cp ~/.config/sway/config ./sway/.
	cp ~/.config/waybar/* ./waybar/.

