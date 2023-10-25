.SILENT: status

status:
	cmp --silent ~/.config/sway/config ./sway/config || echo "./sway/config is different from the local file in ~/.config/sway/config"
	cmp --silent ~/.config/waybar/config ./waybar/config || echo "./waybar/config is different from the local file in ~/.config/waybar/config"
	cmp --silent ~/.config/waybar/style.css ./waybar/style.css || echo "./waybar/style.css is different from the local file in ~/.config/waybar/style.css"
	cmp --silent ~/.emacs.d/init.el ./emacs/init.el || echo "./emacs/init.el is different from the local file in ~/.emacs.d/init.el ./emacs/init.el"


export: 
	mkdir -p ~/.config/sway
	cp ./sway/config ~/.config/sway/config
	mkdir -p ~/.config/waybar/
	cp -r ./waybar/* ~/.config/waybar/.
	mkdir -p ~/.emacs.d/
	cp -r ./emacs/* ~/.emacs.d/.

import:
	cp ~/.config/sway/config ./sway/.
	cp ~/.config/waybar/config ./waybar/.
	cp ~/.config/waybar/style.css ./waybar/.
	cp ~/.emacs.d/init.el ./emacs/.
	cp -r ~/.emacs.d/themes ./emacs/. | true
