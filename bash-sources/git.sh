function git_parent_branch {
	git show-branch | sed "s/].*//" | grep "\*" | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -n1 | sed "s/^.*\[//"
}

function git_clean {
    git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}


function wip_current_branch {
    curr_branch=$(git rev-parse --abbrev-ref HEAD)
    if [ $? -ne 0 ] || [ -z "${curr_branch}" ] ; then
        echo "Something went wrong, not continuing looking for WIP url"
    fi
    # remote: To create a merge request for feature/3-parameter_defaults_allow_none, visit:
    # remote:   https://gitlab.some.host/mr-url
    mr_url=$(git push origin "${curr_branch}" 2>&1 | grep -E "To create a (merge|pull) request" -A1 | tail -n +2 | sed 's/remote://')

    echo "Opening Merge/Pull Request URL for ${curr_branch}"
    echo "${mr_url}"
    xdg-open "${mr_url}"
}

git config --global diff.tool vimdiff
git config --global difftool.prompt false
