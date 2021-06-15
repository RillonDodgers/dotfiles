#!/usr/bin/env python3
import sys
import os
import logging
import distutils.spawn

class Dotfiles:

    def install_all_dotfiles(self):
        self.install_vim_dotfiles()
        self.install_vscodium_dotfiles()
        self.install_flake8_config()

    def install_vim_dotfiles(self):
        self.logger("Installing vim dotfiles", "info")
        pathogen_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        pathogen_des = self.home_directory + ".vim/autoload/plug.vim"
        os.system("curl --silent -fLo %s --create-dirs %s" % (pathogen_des, pathogen_url))
        vimrc = self.home_directory + ".vimrc"
        if self.dotfile_exists(vimrc):
            self.remove_file(vimrc)
        dotfiles_vimrc = self.home_directory + ".dotfiles/vimrc"
        self.link_files(dotfiles_vimrc, vimrc)

    def install_vscodium_dotfiles(self):
        self.logger("Installing vscodium dotfiles", "info")
        os.makedirs(self.home_directory + '.config/VSCodium/User/', exist_ok=True)
        dotfiles_json = self.home_directory + '.dotfiles/config/VSCodium/User/settings.json'
        vscodium_json = self.home_directory + '.config/VSCodium/User/settings.json'
        if self.dotfile_exists(vscodium_json):
            self.remove_file(vscodium_json)
        self.link_files(dotfiles_json, vscodium_json)

    def install_flake8_config(self):
        self.logger("Installing flake8 dotfiles", "info")
        dotfiles_config = self.home_directory + '.dotfiles/flake8'
        flake8_config = self.home_directory + '.config/flake8'
        if self.dotfile_exists(flake8_config):
            self.remove_file(flake8_config)
        self.link_files(dotfiles_config, flake8_config)

    def install_packages(self):
        release = self.os_release["ID_LIKE"]
        if any(string in release for string in ["ubuntu", "debian"]):
            packages = ' '.join(self.ubuntu_packages)
            os.system(f"sudo apt install -y {packages}")
        if any(string in release for string in ["arch", "manjaro"]):
            packages = ' '.join(self.arch_packages)
            os.system("sudo pacman --noconfirm -S yay")
            os.system("yes | yay --nocleanmenu --nodiffmenu --noupgrademenu --noeditmenu -S %s" % packages)

    def link_files(self, file1, file2):
        os.symlink(file1, file2)
        self.logger("%s -> %s" % (file1, file2), "success")

    def remove_file(self, file):
        self.logger("removing %s" % file, "warning")
        os.remove(file)

    def dotfile_exists(self, file):
        return os.path.islink(file) or os.path.isfile(file)

    def logger(self, text, level="INFO"):
        level = level.upper()
        if level == "WARNING":
            text = colors.warning + text + colors.endc
        if level == "INFO":
            text = colors.info + text + colors.endc
        if level == "SUCCESS":
            text = colors.cyan + text + colors.endc
        print("%s: %s" % (level, text))

    @property
    def os_release(self):
        dictionary = {}
        with open("/etc/os-release") as file:
            for line in file:
                key, value = line.rstrip().split("=")
                dictionary[key] = value
        return dictionary

    @property
    def arch_packages(self):
        return ["vim", "vscodium-bin"]

    @property
    def ubuntu_packages(self):
        return ["vim", "vscodium"]

    @property
    def home_directory(self):
        return os.path.expanduser('~/')

class colors:
    info = '\033[95m'
    blue = '\033[94m'
    cyan = '\033[96m'
    green = '\033[92m'
    warning = '\033[93m'
    fail = '\033[91m'
    endc = '\033[0m'
    bold = '\033[1m'
    underline = '\033[4m'



if __name__ == '__main__':
    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option("-a", "--all", dest="all", action="store_true", help="Install all dotfiles")
    parser.add_option("-v", "--vim", dest="vim", action="store_true", help="Install vim dotfiles")
    parser.add_option("-p", "--packages", dest="packages", action="store_true", help="Install vim dotfiles")
    parser.add_option("-t", "--test", dest="test", action="store_true", help="Test")
    (options, args) = parser.parse_args()

    if len(args) > 1:
        print("Only select one option at a time... for now")
        sys.exit()

    dotfiles = Dotfiles()

    if options.packages:
        dotfiles.install_packages()
    if options.all:
        dotfiles.install_all_dotfiles()
    if options.vim:
        dotfiles.install_vim_dotfiles()

