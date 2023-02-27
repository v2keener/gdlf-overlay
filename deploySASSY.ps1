# Don't run this in PowerShell Integrated whatever that VS Code has...
# (meant for pwsh 7.2 LTS or above)
# Must have sass available to CLI

# Note that all the following is using PowerShell (pwsh) on Windows 10/11

# directory of $dot_obsidian_folder should be `your-vault/.obsidian`
#  It's the first parameter (e.g. `.\deploySASSY.ps1 'C:\your-vault\.obsidian')
#  (The .obsidian folder)
$dot_obsidian_folder = $args[0]

# if(!(Test-Path $dot_obsidian_folder))
# {
#   Exit-PSHostProcess
# }

# echo $dot_obsidian_folder

Write-Output "This will run some jobs."
Write-Output ("CSS for the dot_obsidian_folder will be written to " + $dot_obsidian_folder)

# Print settings (settings for PDF, printing)
sass -w .\mixins\gdlf-media-print.scss "$dot_obsidian_folder\snippets\gdlf-media-print.css" --no-source-map &

# The SCSS files that combine all the mixins to be useful while 
# containing all the Style Settings for each mixin in each of 
# the two following files
sass -w ".\gdlf-overlay.scss" "$dot_obsidian_folder\snippets\gdlf-overlay.css" --no-source-map &
sass -w ".\gdlf-for-me-wrapper.scss" "$dot_obsidian_folder\snippets\gdlf-for-me.css" --no-source-map &

# Settings for other themes (Default, Prism)
# From https://github.com/mgmeyers/obsidian-style-settings/blob/main/obsidian-default-theme.css
# sass -w ".\mixins\obsidian-default-settings.scss" "$dot_obsidian_folder\snippets\obsidian-default-settings.css" --no-source-map &
# sass -w ".\mixins\gdlf-theme-prism-extras.scss" "$dot_obsidian_folder\snippets\gdlf-theme-prism-extras.css" --no-source-map &

sass -w ".\gdlf-overlay-combined.scss" "$dot_obsidian_folder\snippets\gdlf-full-overlay.css" --no-source-map &
# For the next command to work, you need an "Overlay" folder under your "themes" directory...
$overlay_path = ( Join-Path $dot_obsidian_folder "/themes/Overlay")
# echo $overlay_path
If(!(Test-Path -Path $overlay_path))
{
  # this is from https://stackoverflow.com/questions/16906170/create-directory-if-it-does-not-exist#46714857
  New-Item -ItemType Directory -Path $overlay_path
}
sass -w ".\gdlf-overlay-theme.scss" "$dot_obsidian_folder\themes\Overlay\theme.css" --no-source-map &
# Render to the root of project
sass -w ".\gdlf-overlay-theme.scss" "theme.css" --no-source-map &

# Now do plugins last
sass -w ".\mixins\plugin-reminders.scss" "$dot_obsidian_folder\snippets\plugin-reminders.css" --no-source-map &
sass -w ".\mixins\plugin-grandfather.scss" "$dot_obsidian_folder\snippets\plugin-grandfather.css" --no-source-map &
sass -w ".\mixins\plugin-todo-list.scss" "$dot_obsidian_folder\snippets\plugin-todo-list.css" --no-source-map &
