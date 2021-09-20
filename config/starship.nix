{
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        $username $hostname $directory $git_branch $git_status
        \$ '';
        username = {
          format = "[$user]($style)";
          style_user = "bold bright-red";
          style_root = "bold red";
          disabled = false;
          show_always = true;
        };
        hostname = {
          format = "at [$hostname]($style)";
          style = "bold yellow";
          ssh_only = false;
        };
        directory = {
          format = "in [$path]($style)";
          style = "bold green";
          truncate_to_repo = false;
          truncation_length = 0;
        };
        git_branch = {
          format = "on [$branch]($style)";
          style = "bold purple";
        };
        git_status = { style = "bold blue"; };
    };
  };
}
