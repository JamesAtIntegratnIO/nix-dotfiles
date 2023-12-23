{
  ## Useful aliases
  grubup = "sudo update-grub";
  fixpacman = "sudo rm /var/lib/pacman/db.lck";
  tarnow = "tar -acf ";
  untar = "tar -zxvf ";
  wget = "wget -c ";
  rmpkg = "sudo pacman -Rdd";
  psmem = "ps auxf | sort -nr -k 4";
  psmem10 = "ps auxf | sort -nr -k 4 | head -10";
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";
  "......" = "cd ../../../../..";
  dir = "dir --color=auto";
  vdir = "vdir --color=auto";
  grep = "grep --color=auto";
  fgrep = "fgrep --color=auto";
  egrep = "egrep --color=auto";
  hw = "hwinfo --short";                                   # Hardware Info
  big="expac -H M '%m\t%n' | sort -h | nl";              # Sort installed packages according to size in MB (expac must be installed)
  gitpkg = "pacman -Q | grep -i '\-git' | wc -l";			     # List amount of -git packages

  # Get fastest mirrors 
  mirror = "sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist";
  mirrord = "sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"; 
  mirrors = "sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist";
  mirrora = "sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist";

  # Help people new to Arch
  apt-get = "man pacman";
  apt = "man pacman";
  helpme = "cht.sh --shell";
  pacdiff = "sudo -H DIFFPROG=meld pacdiff";
  please = "sudo !!";
  tb = "nc termbin.com 9999";
  upd = "/usr/bin/update";

 # fix for alacritty
 aterm = "nixGL alacritty";
}
