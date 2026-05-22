# mkdir and cd in one step
# Location: ~/.config/fish/functions/mkcd.fish
function mkcd --description "Create directory and cd into it"
    mkdir -p $argv[1]; and cd $argv[1]
end
