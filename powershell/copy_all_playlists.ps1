# Script Name:    copy_all_playlists.ps1
# Author:         DJ Differens
# Created:        02-11-2024
# Version:        1.0
# Description:    Script for copying all playlists to folders.

# Create a hash for tracks and a hash for playlists
$tracks = @{}
$playlists = @{}

# Determine current directory by checking the script root and removing the word powershell because we need the root directory
$scriptDirectory = $PSScriptRoot
$substringToRemove = "powershell"
$rootDirectory = $scriptDirectory -replace $substringToRemove, ""
$xmlFilePath = $($rootDirectory + 'rekordbox_export.xml')

# Check if xml file exists, if the file exists continue with the script and else raise error message  
if (Test-Path $xmlFilePath) {
	
	# Parse xml file and loop through all TRACK xml nodes. Store each track in the tracks hash by using TrackID as key and Location as value
	Select-Xml -Path $xmlFilePath -XPath '/DJ_PLAYLISTS/COLLECTION/TRACK' | ForEach-Object {
		$tracks.add($_.Node.TrackID, $($_.Node.Location -replace 'file://localhost/', ''));
	}

	# Parse xml file again but now loop through all playlist nodes
	Select-Xml -Path $xmlFilePath -XPath '/DJ_PLAYLISTS/PLAYLISTS/NODE/NODE' | ForEach-Object {		
	
		# Check if the node has a Count attribute - if true then the playlists are placed within a directory
		# Store each playlist in the playlists hash by using Name as key and search for the value by using the TRACK node ids and the tracks hash
		if ($_.Node.HasAttribute("Count")) {
			$playlistNodes = $_.Node.SelectNodes(".//NODE")
		
			foreach ($playlistNode in $playlistNodes) {
				$playlists.add($playlistNode.Name, @());
				foreach ($track in $playlistNode.TRACK) { $playlists[$playlistNode.Name] += [uri]::UnescapeDataString($tracks[$track.key]); }
				
			}
		} else {
			$playlists.add($_.Node.Name, @());
			foreach ($track in $_.Node.TRACK) { $playlists[$_.Node.Name] += [uri]::UnescapeDataString($tracks[$track.key]); }
		}
	}

	# Loop through all playlists and create a directory for each playlist and copy the tracks to the new directory
	foreach ($playlist in $playlists.Keys) {
		$playlistDirectory = $($rootDirectory + 'rekordbox\' + $playlist)
		if (-not (Test-Path -Path $playlistDirectory)) {
			New-Item -Path $playlistDirectory -ItemType Directory
			Write-Host "Folder created: $playlistDirectory"
		} else {
			Write-Host "Folder already exists: $playlistDirectory"
		}
		foreach ($source in $playlists[$playlist]) {
			$splitSource = $source -split '/'
			$trackName = $splitSource[-1]
			$trackDestination = Join-Path $playlistDirectory $trackName
			if (-not (Test-Path -Path $trackDestination)) {
				Copy-Item -Path "$source" -Destination "$playlistDirectory"
				Write-Host "File $trackName copied to $playlistDirectory"
			} else {
				Write-Host "File $trackName already exists at $playlistDirectory"
			}
		}
	}
} else {
    Write-Output "File 'rekordbox_export.xml' does not exist."
	Write-Output "Place the export file in the same directory as the 'rekordbox_copy.bat' file and try again."
}	