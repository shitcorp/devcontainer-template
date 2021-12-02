#!/bin/bash
# Usage:
# ./install_fonts -> Download Meslo fonts to install manually
# ./install_fonts install -> Download and install fonts (only works on linux)
# ./install_fonts debug -> Show debug output
# ./install_fonts install debug -> Show debug output

if [ ! -z $1 ] && [ ${1,,} = "debug" ] ; then 
  set -o xtrace
fi

if [ ! -z $2 ] && [ ${2,,} = "debug" ] ; then 
  set -o xtrace
fi

fonts_dir="${HOME}/.local/share/fonts"
if [ ! -d "${fonts_dir}" ]; then
    echo "mkdir -p $fonts_dir"
    mkdir -p "${fonts_dir}"
else
    echo "Found fonts dir $fonts_dir"
fi

declare -a fonts
fonts=("https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf" "https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold.ttf" "https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Italic.ttf" "https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf")

for font in 0 1 2 3
do
    echo $font
    fontname=${fonts[font]##*/}
    # https://reactgo.com/bash-replace-characters-string/
    fontname_corrected=${fontname//[%20]/}
    if [ ! -f $fontname_corrected ] ; then
      curl --fail --location --show-error ${fonts[font]} --output ${fontname_corrected}
    fi
    if [ -z $1 ] ; then
      continue 
    fi
    if [ $1 = "install" ] ; then
      cp ${fontname_corrected} ${fonts_dir}
      echo "Done installing: ${fontname_corrected}"
    fi
done
echo "Done"