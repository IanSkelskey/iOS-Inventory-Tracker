# iOS-Inventory-Tracker
Simple inventory tracker that I built to demonstrate my current abilities in iOS development technologies for Starbucks software development internship Summer 2022.
Inventory Tracker can be used to view or update the contents of an array of Items. In reality, the data to populate the UITableView should come from a network call, but for demonstration purposes I create it at random at launch.
Underneath the title, "Inventory Tracker," there is a UISegmentedControl that can be used to toggle between view (read-only) and edit (for updating, i.e. counts). In view mode, the UITextFields and UISteppers in each cell will not respond to touch. The UITableView will still be scrollable.
Item names are displayed at the left of the screen with their SKUs under the "Name" header.
Quantity can be updated via the UITextField under the "Qty" header or by incrementing and decrementing with the UIStepper under the "Step" header.

## Screenshot

<img src="https://raw.githubusercontent.com/IanSkelskey/iOS-Inventory-Tracker/main/screenshot%20%5B03-08-2022%5D.png" width="300">
