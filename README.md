# Rekordbox Playlist Copy Tool

Windows tool for copying playlists to folders. It will keep the playlists structure as it is.

## Example usages

It will be useful in many cases, but here some examples:

- When you want to use your playlists in another system like Traktor Scratch for example
- When you want to copy a specific playlist from someones USB stick which is setup by Rekordbox
- When you want to backup your Rekordbox playlist structure without using Rekordbox itself

## How to use this tool?

##### Step 1
Download or clone this repository to a directory on your pc. It doesn't matter which directory. 
Keep in mind that the files which are going to be copied will end up in the same directory so there must be enough space left on your hard drive to copy all the playlists/tracks.

##### Step 2
Open Rekordbox and export your collection to XML. You can do that via the 'File' menu in the top bar.

**Important:** 
- Filename of the exported XML should be 'rekordbox_export.xml' 
- The file should be saved in the 'rekordbox_playlist_copy' directory from this repository. 

##### Step 3
Run the file 'rekordbox_copy.bat' from this repository as Administrator (Right click -> Run as administrator)

##### Step 4
Follow the instructions in the terminal. You can choose out of 3 options:
- Option one is copy all the playlists at once
- Option two is to only copy a single playlist
- Option three is to confirm each playlist individualy
