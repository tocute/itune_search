# itunes_search
User can search music from iTunes

## Getting Started
![Alt text](ScreenShot.png?raw=true "Title")

## Key Function
1. Support background playback
2. Playback without issue even search new keywords
3. Playback cannot be stopped when device in silent mode

## Other Function
1. App can avoid user continue type.
2. Show error when search failed.
3. Set Player as singleton.
4. Click the song which is playing will stop.

## File Architecture
├─ Page  
│  ├─ ViewController.swift  
│  ├─ ViewModel.swift         -- capture data from iTunes and offer result to ViewController    
├─ Shared
│  ├─ MusicPlayer.swift       -- This is a singleton for play music 
│  └─ URL+extension.swift     -- support URL with query parameter 
└─ Model
   └─ Search.swift            -- search result data model  


