# Script00 - Introduction to MATLAB
This is the first of the many scripts I have prepared for the training. I have discussed some key things before we get started with learning image processing in MATLAB.

## From where to learn MATLAB?
**MATLAB Onramp** - [link](https://matlabacademy.mathworks.com/en/details/matlab-onramp/gettingstarted). This course is sufficient enough to get you started.

*Note* -  You will need to log in using your university ID to access the course.


## Key difference with Python -
For scientific computing purposes, people tend to switch between ```Python``` and ```MATLAB```. If you are a heavy Python user, then the following key point will be worth keeping in mind as it will certainly become a source of bug in your code in future.

### Key difference 1
In MATLAB, the array indexing starts from 0. This is one of the major changes people encounter when switching from something similar like ```python```. Following is an example of how you create an array in MATLAb.
```matlab
>> arr1=[1,2,3,4];

>> arr1(0)
Array indices must be positive integers or logical values.  --> // Error Message //

>> arr1(1)

ans =

     1
```

Now if I want to extract the first element, I will have write ```arr1[1]``` instead of ```arr1[0]```. Also note that you will have to use ```()``` brackets instead of ```[]``` here. An equivalent operation of creation of creating an array and accessing elements in ```Python``` will look like below -
```python
>>> import numpy as np
>>> arr1=np.array([1,2,3,4])
>>> print(arr1[0])
1
```
### Key difference 2

Semicolons (```;```) are used in MATLAB to suppress output to the command window. If you don't use it, then certainly you won't get any syntax error. Following highlights the use or no-use of a semicolon
```matlab
>> arr1=[1,2,3,4]    % not using semicolon
arr1 =

     1     2     3     4
>> arr1=[1,2,3,4];  % using semicolon suppresses the output.
```

If you know ```Python```, you will see that we don't use semicolons that often.

### Take home message
Programming is very easy in MATLAB or easier than most of the other programming or scripting languages that you have used before.