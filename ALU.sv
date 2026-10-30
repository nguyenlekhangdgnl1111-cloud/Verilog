#include "Rect2.h"
#include<iostream>
using namespace std;
int main(void){
double width;
double length;
bool try_again;
// create a rectangle
Rect2 myRect;
// get values
while(1){
cout << "Enter the rectangles width ";
cin >> width;
try_again = true;
//Attempt to recover if necessary
while(try_again){
try{
myRect.setWidth(width);
try_again = false;// no exception thrown
}
catch(Rect2::NegativeWidth &){
cout << "Please enter a non-negative value for width: 
";
cin >> width;
}
}
cout << "Enter the rectangles length ";
cin >> length;
try_again = true;
//Attempt to recover if necessary
while(try_again){
try{
myRect.setLength(length);
try_again = false;// no exception thrown
}
catch(Rect2::NegativeLength &){
cout << "Please enter a non-negative value for length: ";
cin >> length;
}
}
cout << "The area of the rectangle is: " << myRect.calcArea() << endl;
}
return 0;
}
