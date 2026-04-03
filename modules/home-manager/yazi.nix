## .nixfiles/modules/home-manager/packages-home.nix
{pkgs, ...}: {
      #Yazi plugins
    #bookmarks
    #drag
    #recycle-bin
    #chmod
    #compress
    #sudo
    #wl-clipboard
    #gvfs
    #glow
    #lsar
    #mediainfo #or rich-review
    #mount
    #restore
    #smart-enter
    #smart-filter
    #smart-paste

home.packages = with pkgs; [
  trash-cli
];

  programs.yazi = {
    enable = true;
    enableFishIntegration = false;
settings = {
      opener = {

        edit = [
      {
        run = "nvim \"$@\"";
        desc = "Edit with Neovim";
        block = true;
      }
    ];

        codium = [
          {
            run = "codium \"$@\"";
            desc = "Open with VSCodium";
            block = true;
          }
        ];
        gwenview = [
          {
            run = "gwenview \"$@\"";
            desc = "Open with Gwenview";
            block = false;
            orphan = true;
          }
        ];
        haruna = [
          {
            run = "haruna \"$@\"";
            desc = "Open with Haruna";
            block = false;
            orphan = true;
          }
        ];
        firefox = [
          {
            run = "firefox \"$@\"";
            desc = "Open with Firefox";
            block = false;
            orphan = true;
          }
        ];
      };
      
      open = {
        prepend_rules = [
          # Text/code files
          { mime = "text/*"; use = ["edit" "codium"]; }
          { mime = "application/json"; use = "codium"; }
          { mime = "application/x-yaml"; use = "codium"; }
          { mime = "application/xml"; use = "codium"; }
          { mime = "application/x-shellscript"; use = "codium"; }
          
          # Images
          { mime = "image/*"; use = "gwenview"; }
          
          # Videos
          { mime = "video/*"; use = "haruna"; }

          # Music
          { mime = "audio/*"; use = "haruna"; }
          
          # PDFs
          { mime = "application/pdf"; use = "firefox"; }
        ];
      };
    };
    plugins = with pkgs.yaziPlugins; {
      smart-enter = smart-enter;
      smart-paste = smart-paste;
      smart-filter = smart-filter;
      restore = restore;
      recycle-bin = recycle-bin;
      bookmarks = bookmarks;
      compress = compress;
      sudo = sudo;
      cmod = chmod;
      mount = mount;
      wl-clipboard = wl-clipboard;
    };

    keymap = {
      mgr.prepend_keymap = [
        
        # Tabs
        { run = "close"; on = [ "<C-w>" ]; }
        { run = "tab_create --current"; on = [ "<C-t>" ]; }
        
        # Search (slow)
        { run = "search --via=fd"; on = [ "f" ]; }
        { run = "search --via=rg"; on = [ "F" ]; }

        # Sorting
        { run = ["sort mtime --reverse=no" "linemode mtime"]; on = [ "s" "m" ]; }
        { run = ["sort mtime --reverse=yes" "linemode mtime"]; on = [ "s" "M" ]; }

        { run = ["sort btime --reverse=no" "linemode mtime"]; on = [ "s" "b" ]; }
        { run = ["sort btime --reverse=yes" "linemode mtime"]; on = [ "s" "B" ]; }

        { run = "sort extension --reverse=no"; on = [ "s" "e" ]; }
        { run = "sort extension --reverse=yes"; on = [ "s" "E" ]; }

        { run = "sort alphabetical --reverse=no"; on = [ "s" "a" ]; }
        { run = "sort alphabetical --reverse=yes"; on = [ "s" "A" ]; }

        { run = "sort natural --reverse=no"; on = [ "s" "n" ]; }
        { run = "sort natural --reverse=yes"; on = [ "s" "N" ]; }

        { run = ["sort size --reverse=no" "linemode mtime"]; on = [ "s" "f" ]; }
        { run = ["sort size --reverse=yes" "linemode mtime"]; on = [ "s" "F" ]; }

        # Delete (trash)
        { run = "remove"; on = [ "<Delete>" ]; }

        # wl-clipboard
        { run = "plugin wl-clipboard"; on = [ "<C-y>" ]; }
        # smart-paste
        { run = "plugin smart-paste"; on = [ "p" ]; }
        # restore
        { run = "plugin restore"; on = [ "u" ]; }
        { run = "plugin restore -- --interactive"; on = [ "U" ]; }
        # bookmarks
        { run = "plugin bookmarks save"; on = [ "m" ]; }
        { run = "plugin bookmarks delete"; on = [ "b" "d" ]; }
        { run = "plugin bookmarks jump"; on = [ "'" ]; }
      ];
    };
  };
}
