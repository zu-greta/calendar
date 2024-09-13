# calendar

Personal calendar + reminder app project. Possibility of adding other app functionalities as well (health, alarms, notes, travel...)
Currently developing iOS for iPhone version, using SwuiftUI and XCode. Also working on developing macOS version with a database to hold user data.
Will be looking into syncing data across devices.

Notes:
- iOS vs MacOS -> NavigationView (iOS) vs NavigationStack (MacOS)
- use of persistent storage instead of database for simpler implementation. very light use right now so no need for heavy database or third party. using coredata for macOS.
- some syntax differences between iOS and MacOS versions of swiftui 

iOS app:
- home view: calendar month view with either Events or Todo Items list (scroll left or right for each view). Todo items can be checked off as "done" and they turn grey, they also turn red if it is past the due date. *TODO: persist todo items until they are completed. continue showing the item as "past due" in the next days*. home view also allows has a button to allow for a full screen view of the selected days events or todo items.
- adding items: bottom right corner of home view, "+" button to either add an event or todo item. a detailed view appears. to get a detailed view of an existing item, click on it and it will pop up. possibility to edit the item and save the edits once done. also possible to delete an item this way.
- *TODO: develop functionalities to the apps button on the bottom left corner of home view. should bring user to another page with the functionalities of "notes app", "alarms app", or "health app"*


MacOS app:
- similar concept to the iOS version but on Mac. slightly different layout since there is more space available.
- instead of persistent storage, use CoreData to implement persistence and store user data. simpler than having a database (third party).
