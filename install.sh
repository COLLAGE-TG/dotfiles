#...

DOTPATH=~/.dotfiles

#if you can use git
if has "git"; then
	git clone --recursive "GITHUB_URL" "$DOTPATH"

#if you cannot use git, use curl or wget
elif has "curl" || has "wget"; then
	tarball="https://github.com/b4b4r07/dotfiles/archive/master.tar.gz"

	#download with curl or wget and pass to tar
	if has "curl"; then
		curl -L "$tarball"
	elif has "wget" then
		wget -0 - "$tarball"
	fi | tar zxv

	#unziped the folder, place at DOTPATH
	mv -f dotfiles-master "$DOTPATH"
else
	die "curl or wget required"
fi

cd ~/.dotfiles
if [$? -ne 0 ]; then
	die "not found: $DOTPATH"
fi

#if you was able to move, run the link
for f in .??*
do
	[ "$f" = ".git" ] && continue
	
	ln -snfv "$DOTPATH/$f" "$HOME/$f"
done

