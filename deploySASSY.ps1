# Don't run this in PowerShell Integrated whatever that VS Code has...
# (meant for pwsh 7.2 LTS or above)
# Must have sass available to CLI

# Note that all the following is using PowerShell (pwsh) on Windows 10/11

# directory of $snippets should be `your-vault/.obsidian/snippets`
#  It's the first parameter (e.g. `.\deploySASSY.ps1 'C:\your-vault\.obsidian\snippets')
#  (The snippets folder is used as a relative path to themes as well)
$snippets = $1

Write-Output "This will run some jobs"
Write-Output ("CSS Snippets will be written to " + $snippets)

# Print settings (settings for PDF, printing)
sass -w .\mixins\gdlf-media-print.scss "$snippets\gdlf-media-print.css" --no-source-map &

# The SCSS files that combine all the mixins to be useful while 
# containing all the Style Settings for each mixin in each of 
# the two following files
sass -w ".\gdlf-overlay.scss" "$snippets\gdlf-overlay.css" --no-source-map &
sass -w ".\gdlf-for-me-wrapper.scss" "$snippets\gdlf-for-me.css" --no-source-map &

# Settings for other themes (Default, Prism)
# From https://github.com/mgmeyers/obsidian-style-settings/blob/main/obsidian-default-theme.css
# sass -w ".\mixins\obsidian-default-settings.scss" "$snippets\obsidian-default-settings.css" --no-source-map &
# sass -w ".\mixins\gdlf-theme-prism-extras.scss" "$snippets\gdlf-theme-prism-extras.css" --no-source-map &

sass -w ".\gdlf-overlay-combined.scss" "$snippets\gdlf-full-overlay.css" --no-source-map &
# For the next command to work, you need an "Overlay" folder under your "themes" directory...
sass -w ".\gdlf-overlay-theme.scss" "$snippets\..\themes\Overlay\theme.css" --no-source-map &
sass -w ".\gdlf-overlay-theme.scss" "theme.css" --no-source-map &

# Now do plugins last
sass -w ".\mixins\plugin-reminders.scss" "$snippets\plugin-reminders.css" --no-source-map &
sass -w ".\mixins\plugin-grandfather.scss" "$snippets\plugin-grandfather.css" --no-source-map &
sass -w ".\mixins\plugin-todo-list.scss" "$snippets\plugin-todo-list.css" --no-source-map &
