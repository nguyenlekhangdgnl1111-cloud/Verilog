#include "Triangle.h"
Triangle::Triangle() {
side1 = 1;
side2 = 1;
side3 = 1;
}
Triangle::Triangle(double s1, double
s2, double s3){
side1 = s1;
side2 = s2;
side3 = s3;
}
void Triangle::print_triangle(void){
cout << "triangle: " << side1 << "
- "
<< side2 << " - " << side3 << endl;
}
