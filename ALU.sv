#include "Rect3.h"
#include<iostream>
using namespace std;
int main(void){
double width;
double length;
bool try_again;
// create a rectangle
Rect3 myRect;
// get values
while (1){
cout << "Enter the rectangles width ";
cin >> width;
try_again = true;
//Attempt to recover if necessary
while (try_again){
try{
myRect.setWidth(width);
try_again = false; // no exception thrown
}
catch (Rect3::NegativeWidth &exptn){
cout << "You entered " << exptn.getValue() << endl;
cout << "Please enter a non-negative value for width: ";
cin >> width;
}
}
cout << "Enter the rectangles length ";
cin >> length;
try_again = true;
//Attempt to recover if necessary
while (try_again)
{
try
{
myRect.setLength(length);
try_again = false; // no exception thrown
}
catch (Rect3::NegativeLength &exptn)
{
cout << "You entered " << exptn.getValue() << endl;
cout << "Please enter a non-negative value for length: ";
cin >> length;
}
}
cout << "The area of the rectangle is: " << myRect.calcArea() << endl;
}
return 0;
}
