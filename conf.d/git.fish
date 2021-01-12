# Aliase and function for git - picked from : git@github.com:jhillyerd/plugin-git.git
#

#Functions
#

# Get the current branch name - used by other functions
function __git.current_branch -d "Output git's current branch name"
  begin
    git symbolic-ref HEAD; or \
    git rev-parse --short HEAD; or return
  end 2>/dev/null | sed -e 's|^refs/heads/||'
end

# ggsup
function ggsup --description 'git set upstream to origin/<current branch>'
    git branch --set-upstream-to=origin/(__git.current_branch)
end

# grename
function grename --description Rename\ \'old\'\ branch\ to\ \'new\',\ including\ in\ origin\ remote --argument old new
    if test (count $argv) -ne 2
        echo "Usage: "(status -u)" old_branch new_branch"
        return 1
    end
    git branch -m $old $new
    git push origin :$old
    and git push --set-upstream origin $new
end

# gbage
function gbage --description 'List local branches and display their age'
    git for-each-ref --sort=committerdate refs/heads/ \
    --format="%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))"
end

# Aliases / Abbreviations
#

abbr -a -U gloo		"git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short"
abbr -a -U gss 		"git status -s"
abbr -a -U gcm		"git commit -m"
abbr -a -U gcam		"git commit -a -m"

#alias  gloo    "git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short"

