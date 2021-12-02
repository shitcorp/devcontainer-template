#!/bin/bash

echo "Installing P10k ..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Installing zsh-autocomplete ..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing zsh-syntax-highlighting ..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Unpacking p10k config ..."
cp .devcontainer/library-scripts/dotfiles/.p10k.zsh ~/.p10k.zsh
dos2unix ~/.p10k.zshrc

echo "Setting up zsh ..."
if [ -f ~/.zshrc ] ; then
  rm ~/.zshrc
fi
cp .devcontainer/library-scripts/dotfiles/.zshrc ~/.zshrc
dos2unix ~/.zshrc

echo "Making sure container uses zsh as default shell ..."
# Making sure the container starts with
# zsh as default shell instead of bash
# https://stackoverflow.com/a/55987775
echo "" >> ~/.bashrc
echo "if [ -t 1 ]; then" >> ~/.bashrc
echo "exec zsh" >> ~/.bashrc
echo "fi" >> ~/.bashrc

echo "Installing pipenv ..."
pip3 install pipenv

echo "Done."
