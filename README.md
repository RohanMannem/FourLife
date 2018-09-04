# FourLife

**Purpose**

The purpose of the project is to be able keep track of your body and have a healthy, balanced lifestyle. We have four sections which we believe are the most important facts to everyone’s daily life. By inputting your daily input of food, water, exercise, and sleep, the user can view his day in numbers. Users can learn what they need more of or less of in their average day and keep track of all this information in our app.

**Navigation of Application**

The initial splash screen had 4 buttons which each represent a very important part in everyone’s lives. Clicking each of the buttons leads their own unique tab bar controller. In general, each tab bar controller should have today’s input (table view), the history (table view), and another quick tip (view). Today’s input keeps track of whatever input the user adds in for today and saves it there. Using an “Add View” controller and accessing it with an add button in the top right corner, users can add their own specified data such that it suits their needs. Anything loaded into the input is automatically counted and saved into the history. If a piece of data is removed by swiping the cell left in table view in today’s input view, then the counter in the history is also automatically updated then. Users can easily go back to each section by clicking the home button which appears on the top left corner of the today’s input table view.

**Data Persistence Mechanism**

For the various areas of our project, we used the iOS Core Data feature, as defined in our FourLife.xcdatamodeld file.  This includes three separate entities, one for tracking water consumption, one for tracking food intake, and one for tracking exercises performed.

The “Water” entity includes:

 	iTime		String		Time the user drank another cup of water and recorded it
	iName		Undefined	
	iLocation	String		Location where the user drank (not added, just an idea)
	iImage		Binary Data	Cups of water
	iDesc		Desc		Description of the event
	iDate		Date		Date to save the activity in the history

The “FoodItem” entity includes:

	iName		String		Name of the food / dish eaten
	iPicture	Binary Data	A picture of the food / dish
	iServingSize	Integer16	Serving size (useful for understanding the macros)
	iCals		Integer16	Number of calories per Serving
	iCarbs		Integer16 	Number of carbohydrate caloriess per Serving
	iProtein	Integer16	Number of protein calories per Serving
	iFats		Integer16	Number of fat calories per Serving
	iDate		Date		The date (and time) the food was consumed

The “Exercise” entity includes:

	iName		String		The name of the exercise performed
	iImage		Binary Data	An icon showing the exercise
	iDesc		String		A description of the work out
	iDate		Date		The date (and time) the exercise was performed
