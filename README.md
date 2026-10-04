# Eclipse Mixer
A custom-built audio manager that allows for dynamic creation of playlists with local MP3 files.

## Installation
This program is provided as a Godot project. The repository can be cloned and opened as-is with Godot 4.7.2 or higher. It can then be edited or exported locally.

## How To Use
Put the full file path of the folder with the music you want to use in the box next to the Import button. Then press Import. If successful, the import region should fill with all MP3's found at the given path. Those can then be added to the playlist individually. Any sub-folders found at the given path will also be read, and MP3's within them will automatically be sorted into presets, named after the sub-folder they are found in.
Elements added to the playlist can be rearranged, removed, or played individually. The entire playlist can be played through straight or randomly.
The current playlist can be saved as a preset that is re-nameable.

## Plans
- Graphical Overhaul
- Previous/Next Functions

## Known Issues
- When removing a song from the playlist, there is a chance that multiple elements will be removed (particularly noticeable with duplicates)
