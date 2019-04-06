

# install home brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# write to path
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

# install gcc
brew install gcc
