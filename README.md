# calendar

GENERAL OVERVIEW:
Personal calendar + reminder app project. Possibility of adding other app functionalities as well (health, alarms, notes, travel...)
Currently developing iOS for iPhone version, using SwuiftUI and XCode. Also working on developing macOS version with a database to hold user data.
Will be looking into syncing data across devices.

GOAL:
- combined functionality of different apps into a single app for easier use
- ability to use the same account accross different platforms (iOS mobile, MacOS...)
- syncing data between devices (using the same app on the same account at the same time with different devices.)
- learn and understand differences between database and simple perisitent storage
- learn about unique UI design in different environements (iOS vs MacOS)
- gain unerstanding about iOS/MacOS design environement (Xcode, SwuiftUI...)

NEXT STEP + IDEAS:
- Implement more app functionalities
- Possibility of syncing with other apps (eg. syncing data of the Apple Calendar over to the app)
- Adding more devices to an account
- Idea: Collaboration feature where you can block off time slots and share calendars with friends in order to find availabilities and organize group activities.


NOTES AND FINDINGS:
- use of persistent storage instead of database for simpler implementation. very light use right now so no need for heavy database or third party. using coredata for macOS.
- *TODO: syncing data: possibilities - client server, database, data replication, apple iCloud
- some syntax differences between iOS and MacOS versions of swiftui (eg. iOS vs MacOS -> NavigationView (iOS) vs NavigationStack (MacOS))



APP FUNCTIONALITIES AND DESCRIPTION:
iOS app:
- home view: calendar month view with either Events or Todo Items list (scroll left or right for each view). Todo items can be checked off as "done" and they turn grey, they also turn red if it is past the due date. *TODO: persist todo items until they are completed. continue showing the item as "past due" in the next days*. home view also allows has a button to allow for a full screen view of the selected days events or todo items.
- adding items: bottom right corner of home view, "+" button to either add an event or todo item. a detailed view appears. to get a detailed view of an existing item, click on it and it will pop up. possibility to edit the item and save the edits once done. also possible to delete an item this way.
- *TODO: develop functionalities to the apps button on the bottom left corner of home view. should bring user to another page with the functionalities of "notes app", "alarms app", or "health app"*

MacOS app:
- similar concept to the iOS version but on Mac. slightly different layout since there is more space available.
- current implementation done using persistent storage (like iOS).
- *TODO: instead of persistent storage, use CoreData to implement persistence and store user data. simpler than having a database (third party).*



CODE DESCRIPTION:
iOS app:
- calendar_iosApp: "main". itemStore and eventStore hold the user data. MonthView contains the main code.
- MonthViewModel: boolean variables to display a new event/new item or the scheduleView/TodoView.
- DateValue: Date object
- Events: Event object and sample data
- ToDoItems: Item objects and sample data
- EventStore: to store persistent data for events with a load and save function
- ItemStore: to store persistent data for items with a load and save function
- Themes: colours
- MonthView: calls MyDatePicker to display calendar view at the top. *TODO: possibility to change to weekly view?*. calls ScheduleView and ToDoListView at the bottom in a scrollable portion of the screen. there is also a button in the middle that will pull up a sheet to present the ScheduleView and ToDoListView in full screen when clicked. lower navigation bar has + button to add an event or add an item (calls ScheduletodoView as a sheet view). *TODO: more app functionalities to be implemented*
- MyDatePicker: displays the calendar monthly view with dynamic months and possibility to click on different dates. linked with the ScheduleView and ToDoListView to display scheduled events and todo items for a particular chosen date. Colour changes on tap gestures.
- ScheduletodoView: displays ScheduleView and ToDoListView in a sheet in scrollable left right fashion.
- ScheduleView: filter events to display the ones on the date chosen. past time events will be grayed out.
- ToDoListView: filter items to display the ones on the date chosen. past due items are in red. checked out items are in grey. checkable box can be toggled when item is done.
- AddEventView: calls AddingEventView. has save and cancel buttons to add event to list or cancel action
- AddingEventView: placeholders for user to enter data for a new event to add
- DetailEventEditView: detailed view of information of a particular event *TODO: add a dynamic calendar option*
- EventDetailView: sheet that opens when called. displays information of event. calls DetailEventEditView if edit button clicked and deletes item if delete button clicked
- AddToDoView: calls AddingItemView. has save and cancel buttons to add item to list or cancel action
- AddingItemView: placeholders for user to enter data for a new item to add
- DetailItemEditView: detailed view of information of a particular item *TODO: add a dynamic calendar option*
- ItemDetailView: sheet that opens when called. displays information of event. calls DetailItemEditView if edit button clicked and deletes item if delete button clicked

MacOS app:
- similar classes with _mac added. slight midifications like NavigationStack instead of NavigationView used for better display on Mac view.
- *TODO: implement coreData*



