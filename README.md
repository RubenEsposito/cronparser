# cronparser
An example of a Swift-based console app to parse cron files

IMPORTANT: In order to run the command, you need to use it like:

$> cat input.txt | ./cronparser 16:10

STEPS:

As a first step, I create a new console project and add the test target manually. I would personally prefer to start with a TDD approach for this kind of projects, but given the time constraints to complete the task I opt to add the tests later and ensure that I comply with the requirements as a first priority.

I start from the CronParser, that will be the main file and will contain the code to analyze the arguments, run the parser to check the input and perform the calculations.

I soon see the need to add a String extension to check the correctness of the time argument and to identify the starting point of a cron line. Using this extension is easy and makes the code more readable. I also create a ConsoleIO class to deal with input and output from and to the console.

Next I add the code to control the input. I soon discover that I need to handle arguments and input separately, as one will come along with the command call and the other will come from stdin. I add the help argument as well. I decide to create the OptionType enum to represent the arguments, reducing the probability of an error and improving code readability. 

I separate the argument reading and the input reading in their own functions (to comply better with the single responsibility principle). In readInput(), the function to read from stdin, I decide that it will feel more organized to have a CronFieldParse to deal with each cron line parsing and a CronField struct to represent that line.

In CronFieldParser, I add a new function getCronFields() to parse the cron lines on the file.

I decide that it’s better that the check on validity is performed over each element of a cron field instead of the entire cron field, so we can check if the hours and minutes are valid independently.

I decide to also move the argument processing code in CronParser to its own function.

Now it’s starting to take more time than initially expected, over 2h already. But I’m very close and really want to see the command in action, so I start writing the code to calculate the next execution time of each CronField. I create the calculateNextExecutionTimes() function on CronParser. I add then a new function on the CronField struct that returns the next execution time of it given the current time.

To keep things organized and encapsulated, I decide to move isTimeArgument() from StringExtensions to the TimeArgument struct as a static func. I do the same with isValidCronComponent(), that I move from StringExtensions to the CronField struct as a static function. I remove StringExtension.

I finally write the nextExecutionTime() function that prints the next time the cron command is executed. I first lay the code as it logically	comes to my mind and then refactor.

Finally, I add unit tests for Models and Parsers, making sure to cover all the functions and different logic flows and also making sure that all the tests pass.
