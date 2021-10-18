{ config, pkgs, ... }:
{
  programs.kakoune = {
    enable = true;

    plugins = with pkgs; [
      kak-lsp
      kakounePlugins.prelude-kak
      kakounePlugins.connect-kak
      kakounePlugins.kakoune-vertical-selection
    ];

    config = {
      colorScheme = "gruvbox";
      autoReload = "ask";
      
      alignWithTabs = false;
      tabStop = 2;
      indentWidth = 2;

      showMatching = true;
      # showWhitespace.enable = true;
      
      scrollOff.lines = 8;
      scrollOff.columns = 3;

      numberLines = {
        enable = true;
        relative = true;
        separator = "⋅"; # ⋮ ⦙ ⋅ ∘ ⌋ ∣
      };

      ui = {
        enableMouse = true;
        # assistant = "none";
        statusLine = "bottom";
      };
      
      wrapLines = {
        enable = false;
        indent = true;
        marker = "⏎";
      };

      hooks = [
        {
        	# kak-lsp
          name = "WinSetOption";
          option = "filetype=(sh|javascript|typescript|lua|nix)";
          commands = "lsp-enable-window";
        }
      ];
    };

    extraConfig = ''
      # Plugin Manager
      # ────────────────────────────────────────────────────
      source "%val{config}/plugins/plug.kak/rc/plug.kak"
      plug "andreyorst/plug.kak" noload

      # Loads & Sources
      # ────────────────────────────────────────────────────
      require-module prelude
      require-module connect

      source "%val{config}/kakrc.local"

      # Default Options
      # ────────────────────────────────────────────────────
      set-option global makecmd 'make -j 8'
      set-option global grepcmd 'rg --column'
      set-option global ui_options terminal_assistant=none

      # LSP Server
      # ────────────────────────────────────────────────────
      try %sh{
        kak-lsp --kakoune -s $kak_session
      }

      # Plugins
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "https://github.com/alexherbo2/alacritty.kak" config %{
        alacritty-integration-enable
      }
      plug "alexherbo2/lib.kak" config %{
        enable-detect-indent
        enable-auto-indent
        set global disabled_hooks '(?!auto)(?!detect)\K(.+)-(trim-indent|insert|indent)'
        make-directory-on-save
      }

      # Powerline
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "https://github.com/andreyorst/powerline.kak" defer powerline %{
        set-option global powerline_ignore_warnings true
        set-option global powerline_format 'git line_column bufname smarttab mode_info filetype client session position'
        set-option global powerline_separator ""
        set-option global powerline_separator_thin ""
      } defer powerline_bufname %{
        	set-option global powerline_shorten_bufname "short"
      } defer powerline_gruvbox %{
        	powerline-theme gruvbox
      } config %{
          powerline-start
      }

      # Auto-Pairing
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "https://github.com/alexherbo2/auto-pairs.kak" config %{
        enable-auto-pairs
      }

      # KakTreeFM
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "https://github.com/andreyorst/kaktree" defer kaktree %{
        map global user 'f' ": kaktree-toggle<ret>" -docstring "toggle filetree panel"
        set-option global kaktree_show_help false
        %{
          set-option global kaktree_double_click_duration "0.5"
          set-option global kaktree_indentation 1
          set-option global kaktree_dir_icon_open  "▾ 🗁 "
          set-option global kaktree_dir_icon_close "▸ 🗀 "
          set-option global kaktree_file_icon      "⠀⠀🖺"
          set-option global kaktree_split vertical
          set-option global kaktree_size 30%
        }
      } config %{
        hook global WinSetOption filetype=kaktree %{
          remove-highlighter buffer/numbers
          remove-highlighter buffer/matching
          remove-highlighter buffer/wrap
          remove-highlighter buffer/show-whitespaces
        }
        kaktree-enable
      }

      # Smart-Tab
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "https://github.com/andreyorst/smarttab.kak" defer smarttab %{
        set-option global softtabstop 2
        set-option global smarttab_expandtab_mode_name   '⋅a⋅'
        set-option global smarttab_noexpandtab_mode_name '→a→'
        set-option global smarttab_smarttab_mode_name    '→a⋅'
      } config %{
        	hook global WinSetOption filetype=(lua|markdown|kak|lisp|scheme|sh|perl) expandtab
        	hook global WinSetOption filetype=(makefile|gas) noexpandtab
        	hook global WinSetOption filetype=(c|cpp) smarttab
      }
     
      # Fuzzy-Finder
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "https://github.com/andreyorst/fzf.kak" config %{
        map global normal <c-p> ': fzf-mode<ret>'
      }
      
      # Snippets
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "https://github.com/occivink/kakoune-snippets" config %{
        # set-option -add global snippets_directories "%opt{plug_install_dir}/kakoune-snippet-collection/snippets"
      }
      # plug "https://github.com/andreyorst/kakoune-snippet-collection"

      # Emmet
      # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
      plug "https://github.com/JJK96/kakoune-emmet" config %{
        map global insert <a-e> "<esc>x: emmet<ret>"
      }

    '';
  };
}
