Basically, a modified version of the code from one of [MathWorks' "Deep Learning for Computer Vision" Webinar](https://www.mathworks.com/matlabcentral/fileexchange/62558-demos-from-deep-learning-for-computer-vision-webinar) where I just experimented with the code, messed with it, and got it to work. This was my first time using MATLAB and I didn't really know what I was doing, so this was a little individual adventure for me to explore MATLAB and try to get something to work.

Resources Used: <br>
https://www.mathworks.com/support/search.html/videos/deep-learning-for-computer-vision-120997.html <br>
https://www.mathworks.com/support/search.html?fq[]=asset_type_name:video&fq[]=category:deeplearning/deep-learning-with-images <br>
 
below are basic instructions and the first version of the readme that i wrote in 2019, i havent finished polishing the readme, but i will sometime later in the future <br>

<p class="has-line-data" data-line-start="0" data-line-end="11">Open “TrainingChooseOneImageFromTestFolder” in the TrainingFaceRecog folder<br>
Go into “Faces” folder and create folders with category names of people (labels). Fill them with regular colored pictures of the people.<br>
Go into the “test” folder and paste the images of people you want to identify after training.<br>
At line 27, in the code, change ‘for ii = 1:#’ to ‘for ii = 1:(number of categories/folders in Faces folder)’<br>
For example, you have 5 categories/5 people with multiple pictures for each person. It would be ‘for ii = 1:5’<br>
In code, go to line 44. Change the decimal number in line 44 to set the percentage of pictures used for training.<br>
At line 46, change the file name to the picture of the person you want to identify.<br>
In code, at line 113, change the number to the percentage accuracy for the learning thing to reach before stopping. (currently 99.5%)<br>
At line 157, change the file name to the picture of the person you want to identify.<br>
Press “Run” and wait until it finishes.<br>
A figure will also pop up in another window to show the categories.</p>
<p class="has-line-data" data-line-start="12" data-line-end="13">After training, the image should pop up in another figure with the label/person’s name and the AI’s accuracy.</p>
