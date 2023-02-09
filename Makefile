
export: 
	cp ./sway/config ~/.config/sway/config
	cp -r ./waybar/* ~/.config/waybar/.
	cp -r ./emacs.d/* ~/.emacs.d/.

import:
	cp ~/.config/sway/config ./sway/.
	cp ~/.config/waybar/config ./waybar/.
	cp ~/.config/waybar/style.css ./waybar/.
	cp ~/.emacs.d/init.el ./emacs/.
	cp -r ~/.emacs.d/themes ./emacs/. | true
