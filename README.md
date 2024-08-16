# calendar

Personal calendar + reminder app project. Possibility of adding other app functionalities as well (health, alarms, notes, travel...)
Currently developing iOS for iPhone version, using SwuiftUI and XCode. Also working on developing macOS version with a database to hold user data.
Will be looking into syncing data across devices.

Notes:
- iOS vs MacOS -> NavigationView (iOS) vs NavigationStack (MacOS)
- use of persistent storage instead of database for simpler implementation. very light use right now so no need for heavy database or third party. using coredata for macOS.
