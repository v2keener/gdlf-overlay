# The Overlay Theme

This is a minimal theme for Obsidian. It's also a Snippet you can use against other themes, though how well the snippet works is untested on any theme other than the Default.

The theme offers these features:
- Bold and italics based on Accent color
- Background for active line in Editor
- Background colors based on Accent color
- Secondary Background based on Accent color
- Header tags based on Accent color
- Highlights (mark tag) based on Accent color
- Editor font-family (for Edit mode)
- Editor font-size adjustment by percent
- Tag font-size adjustment
- Frontmatter font-size adjustment
- Code block font-size adjustment
- Inline code font-size adjustment
- Inline code text color (defaults to Obsidian's app.css default)
- "Solid" instead of floating Status bar
- "Standardized" header (tag) sizes
- No Image animations
- External links with 🔗 emoji
- Embed blocks become a bit larger
- Adds a ✨ emoji to the file header / title
- Adds a ⊞ to the fold ellipsis
- Adds some formatting for Footnotes
- Tags have a "pill" shape
- Tags are colored by name
- Rainbow cursor (mostly for Vim mode)
- Removal of embedded document's title
- Add a GDLF vault icon
- Add a GDLF font-family based on my handwriting
- Hide some folders based on their name
- Show emojis for some folders based on their name

Aside from the dozens of features I listed, this theme is intended as minimally changing what Obsidian offers with the Default theme. Also, this project is built with an eye forward to Obsidian's current `app.css` CSS classes and variables. 

## Style Settings

For the Overlay used as a snippet, all settings must be toggled with the Style Settings plugin.

Using the Overlay theme, most settings are default, but you may still adjust font sizes and whether the primary (document) and secondary (app) backgrounds are based on the Accent color. 

## Screenshots

In practice, this is what the Overlay theme looks like:

TODO (Image with default color)

TODO (Image with not-default color - maybe one image with 4 to 6 colors)

## Overlay as a Snippet

The snippet isn't intended to be used alongside the Overlay theme. It would probably break some of the styles and/or how they operate. Overlay's snippet offers the most options and may not work with any theme other than the Default Obsidian theme. Ideally, using the Overlay snippet against the Default theme with all options enabled will look exactly like the Overlay theme itself. This is the intent of having the SCSS build in a few different ways (See "Building the Project).

## Building the Project

To build this project, `sass` needs to be available at your command line. `deploySASSY.ps1` is an example of creating the Theme and related Snippets in PowerShell. The current `theme.css` also builds/renders to the root folder of this project.

Here are the files generated with the example PowerShell script:
- gdlf-overlay.css - The Overlay snippet minus stuff I built just for me
- gdlf-full-combined.css - The complete Overlay snippet
- two theme.css files - The Overlay theme, one renders to the themes folder, and the other to the base folder of this project
- gldf-media-print.css - Some @media print settings I haven't tested in maybe over a year... 

Bonus CSS, which are separate Snippets:
- plugin-reminders.css - Custom CSS for the Reminders plugin
- plugin-grandfather.css - Custom CSS for the Grandfather plugin
- plugin-todo-list.css - Custom CSS for the Todo List plugin 
