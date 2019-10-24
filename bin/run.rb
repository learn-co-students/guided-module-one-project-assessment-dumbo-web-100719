require_relative '../config/environment'

cli = CommandLineInterface.new
# cli.music
cli.render_ascii_art
cli.greet
cli.login_prompt


