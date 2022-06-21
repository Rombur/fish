function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -l last_status $status

    # Change the prompt when we're root
    set -l suffix '$'
    if contains -- $USER root toor
        set suffix '#'
    end

    set -l color_host green
    set -l color_cwd yellow
    set -l color_vcs red

    set -g __fish_git_prompt_showdirtystate 'yes'
    set -g __fish_git_prompt_showstashstate 'yes'
    set -g __fish_git_prompt_showuntrackedfiles 'yes'
    set -g __fish_git_prompt_showupstream 'yes'
    # This function breaks fish in Docker
    # set -g __fish_git_prompt_use_informative_chars 'yes'

    # Write pipestatus
    set -l prompt_status (__fish_print_pipestatus " [" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)
    echo -n -s (set_color $fish_color_user) "$USER" (set_color $color_host) @
         (set_color $color_host) (prompt_hostname) (set_color $color_host) ':'
         (set_color $color_cwd) (prompt_pwd) (set_color $color_vcs)(fish_vcs_prompt)
         (set_color $color_vcs) $prompt_status $suffix " "
end
