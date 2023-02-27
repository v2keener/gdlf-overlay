# Don't run this in PowerShell Integrated whatever that VS Code has...
# (meant for pwsh 7.2 LTS or above)
# Must have sass available to CLI

# Note that all the following is using PowerShell (pwsh) on Windows 10/11

# directory of $dot_obsidian_folder should be `your-vault/.obsidian`
#  It's the first parameter (e.g. `.\deploySASSY.ps1 'C:\your-vault\.obsidian')

#  (The .obsidian folder)

$dot_obsidian_folder = $args[0]

# Don't do this if the folder isn't a folder
if(!(Test-Path $dot_obsidian_folder))
{
  # (Note that Test-Path didn't care if the 
  # folder is really a vault's .obsidian folder)
  
  Write-Host (".obsidian folder of '" + $dot_obsidian_folder + "' not found")
  Exit
}

Write-Output @'
This will run some jobs to create:

- snippets/gdlf-overlay.css
- snippets/gdlf-for-me.css
- snippets/gdlf-full-overlay.css
- themes/Overlay/theme.css

- (optional, uncomment the lines)
  - snippets/plugin-reminders.css
  - snippets/plugin-grandfather.css 
  - snippets/plugin-todo-list.css

  Of the optional ones, the grandfather.css CSS is most current

'@
Write-Output ("CSS for the dot_obsidian_folder will be written to " + $dot_obsidian_folder)

# Print settings (settings for PDF, printing)
sass -w .\mixins\gdlf-media-print.scss "$dot_obsidian_folder\snippets\gdlf-media-print.css" --no-source-map &

# The SCSS files that combine all the mixins to be useful while 
# containing all the Style Settings for each mixin in each of 
# the two following files
sass -w ".\gdlf-overlay.scss" "$dot_obsidian_folder\snippets\gdlf-overlay.css" --no-source-map &
sass -w ".\gdlf-for-me-wrapper.scss" "$dot_obsidian_folder\snippets\gdlf-for-me.css" --no-source-map &

# Overlay with stuff for me included
sass -w ".\gdlf-overlay-combined.scss" "$dot_obsidian_folder\snippets\gdlf-full-overlay.css" --no-source-map &

# For the next command to work, you need an "Overlay" 
# folder under your "themes" directory...

$overlay_path = $( Join-Path $dot_obsidian_folder "/themes/Overlay" )
If(!(Test-Path -Path $overlay_path))
{
  # adapted from https://stackoverflow.com/questions/16906170/create-directory-if-it-does-not-exist#46714857 
  New-Item -ItemType Directory -Path $overlay_path -Force | Out-Null
  Copy-Item .\manifest.json $overlay_path -Force | Out-Null
}

# Render the actual theme.css
sass -w ".\gdlf-overlay-theme.scss" "$dot_obsidian_folder\themes\Overlay\theme.css" --no-source-map &

# # Now do plugins last
# sass -w ".\mixins\plugin-reminders.scss" "$dot_obsidian_folder\snippets\plugin-reminders.css" --no-source-map &
# sass -w ".\mixins\plugin-grandfather.scss" "$dot_obsidian_folder\snippets\plugin-grandfather.css" --no-source-map &
# sass -w ".\mixins\plugin-todo-list.scss" "$dot_obsidian_folder\snippets\plugin-todo-list.css" --no-source-map &
