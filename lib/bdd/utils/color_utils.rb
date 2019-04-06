module Bdd
  module ColorUtils
    module_function

    def color(key, string)
      case key
      when :skipped
        add(string, :yellow, :bold)
      when :failed
        add(string, :red, :bold)
      else
        add(string, :green, :bold)
      end
    end

    def add(string, color, mode = :default)
      "\033[#{SHELL_MODES[mode]};#{SHELL_COLORS[color]}m#{string}\033[0m"
    end

    SHELL_COLORS = {
      :black   => 30, :light_black    => 90,
      :red     => 31, :light_red      => 91,
      :green   => 32, :light_green    => 92,
      :yellow  => 33, :light_yellow   => 93,
      :blue    => 34, :light_blue     => 94,
      :magenta => 35, :light_magenta  => 95,
      :cyan    => 36, :light_cyan     => 96,
      :white   => 37, :light_white    => 97,
      :default => 39
    }

    SHELL_MODES = {
      :default   => 0, # Turn off all attributes
      :bold      => 1, # Set bold mode
      :underline => 4, # Set underline mode
      :blink     => 5, # Set blink mode
      :swap      => 7, # Exchange foreground and background colors
      :hide      => 8  # Hide text (foreground color would be the same as background)
    }
  end
end
