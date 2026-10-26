//Example – no polymorphism
#include "Right_Triangle.h"
RightTriangle::RightTriangle() : Triangle(){
}
RightTriangle::RightTriangle(double s1, double s2, double
s3) : Triangle(s1, s2, s3){
}
void RightTriangle::print_triangle(void){
cout << "Right triangle: " << side1 << " - "
<< side2 << " - " << side3 << endl;
}
