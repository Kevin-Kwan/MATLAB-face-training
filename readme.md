Open "TrainingChooseOneImageFromTestFolder" in the TrainingFaceRecog folder
Go into "Faces" folder and create folders with category names of people (labels). Fill them with regular colored pictures of the people.
Go into the "test" folder and paste the images of people you want to identify after training.
At line 27, in the code, change 'for ii = 1:#' to 'for ii = 1:(number of categories/folders in Faces folder)'
For example, you have 5 categories/5 people with multiple pictures for each person. It would be 'for ii = 1:5'
In code, go to line 44. Change the decimal number in line 44 to set the percentage of pictures used for training.
At line 46, change the file name to the picture of the person you want to identify.
In code, at line 113, change the number to the percentage accuracy for the learning thing to reach before stopping. (currently 99.5%)
At line 157, change the file name to the picture of the person you want to identify.
Press "Run" and wait until it finishes. 
A figure will also pop up in another window to show the categories.

After training, the image should pop up in another figure with the label/person's name and the AI's accuracy.