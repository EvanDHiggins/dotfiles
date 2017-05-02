This is where I keep all my config files. Most programs just need to be install
and then have their dotfiles symlinked. 

Vim is the special case. 
On Linux we build it from source to guarantee the latest. 
On Mac we just brew install macvim and hope for the best.

If you are not me and you're reading this, to install simply run:

```
git clone https://github.com/evandhiggins/dotfiles.git $SOMEWHERE
cd $SHOMEWHERE
./install.sh
```
