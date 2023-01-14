{pkgs, font, fontSize, withGUI, ...}:
{
  programs.alacritty = {
    enable = false;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      window = {
        dimensions = {
          columns = 100;
          lines = 30;
        };
        dynamic_padding = true;
        decorations = "full";
        title = "Boboysdadda's Happy Place";
        opacity = 1;
        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };
        decorations_theme_variant = "dark";
      };
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      font = {
        normal = {
          family = font;
        };
        bold = {
          family = font;
        };
        italic = {
          family = font;
        };
        bold_italic = {
          family = font;
        };
        size = fontSize;
      };
      draw_bold_text_with_bright_colors = true;
      save_to_clipboard = true;
      window.dynamic_title = true;
      cursor = {
        style = "Underline";
      };
      live_config_reload = true;
      shell = {
        program = "/etc/profiles/per-user/boboysdadda/bin/zsh";
        args = [
          "--login"
        ];
      };
      mouse = {
        hide_when_typing = true;
      };
      key_bindings = [
        {
          key = "V";
          mods = "Control|Shift";
          action = "Paste";
        }
        {
          key = "C";
          mods = "Control|Shift";
          action = "Copy";
        }
        {
          key = "Insert";
          mods = "Shift";
          action = "PasteSelection";
        }
        {
          key = "Key0";
          mods = "Control";
          action = "ResetFontSize";
        }
        {
          key = "Equals";
          mods = "Control";
          action = "IncreaseFontSize";
        }
        {
          key = "Plus";
          mods = "Control";
          action = "IncreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Control";
          action = "DecreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Control";
          action = "DecreaseFontSize";
        }
      ];
      colors = {
        primary = {
          background = "0x0a1124";
          foreground = "0xeec49a";
        };
        cursor = {
          text = "0x0a1124";
          cursor = "0xeec49a";
        };
        normal = {
          black = "0x0a1124";
          red = "0x5F4149";
          green = "0xEB3247";
          yellow = "0xBC4349";
          blue = "0xF35645";
          magenta = "0xF6A73B";
          cyan = "0xFAD32F";
          white = "0xeec49a";
        };
        bright = {
          black = "0xa6896b";
          blue = "0xF35645";
          magenta = "0xF6A73B";
          cyan = "0xFAD32F";
          white = "0xeec49a";
        };
      };
    };
    
  };
}