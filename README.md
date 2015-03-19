* BACKUP YOUR CURRENT CONFIGURATION (don't blame me if you mess everything.)
* Then remove `~/.vimrc`, `~/.gvimrc`, and the `~/.vim/` directory

# Rough installation instructions:

* `$ mkdir -p ~/.vim ~/.vim/bundle`
* `$ git clone https://github.com/mcagl/dotvim ~/.vim`
* `$ ln -s ~/.vim/vimrc ~/.vimrc`
* `$ git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim`
* `$ vim +NeoBundleInstall`

Enjoy! :-)

I included also a `setup` script that does the `NeoBundle` installation steps.

LICENSE: [WTFPL](http://www.wtfpl.net)
