# dotfiles

These are my dotfiles. They are awesome.

This repo contains my dotfiles which I use at OS X and FreeBSD systems. This set features a nice and fast zsh config, a neat vim environment and a tmux config.

![Image](https://raw.githubusercontent.com/chrisb86/dotfiles/master/screenshot.png)

The zsh prompt is handcrafted to look neat and give some extra info. When you are root the user- and hostname color changes from blue to red. If you are connected via ssh, the prompt will show some green arrows behind the working path and when you are in a git repository, it will show some git infos at the right side.

The tmux config contains some nice settings to make my work a bit easier and look nice.

My color scheme is [Smyck Color Scheme by hukl](https://github.com/hukl/Smyck-Color-Scheme) and my font is [Source Code Pro by Adobe Fonts](https://github.com/adobe-fonts/source-code-pro).

The repo ships with a Makefile that you can use to deploy and update the dotfiles.

	# bootstrap.sh help

	Usage: bootstrap.sh command {params}

	list 			List all files that will be copied
	update 			Update the git repo and the included submodules
	deploy 			Copy the files to ~
	install 		Update and deploy these dotfiles
	help 			Show this screen

The dotfiles will be copied to your **~**.

## Installation 

1. Get the dotfiles.

		git clone https://github.com/chrisb86/dotfiles.git

2. Deploy
		
		./bootstrap.sh install

3. Enjoy!

If you want to update to the newest version, run ``bootstrap.sh update`` from within the dotfiles folder and ``bootstrap.sh deploy`` to copy the updated files.


## Credits

- dotfiles based on [dotfiles by hukl](https://github.com/hukl/dotfiles)
- [Git prompt by Josh Dick](https://gist.github.com/joshdick/4415470)