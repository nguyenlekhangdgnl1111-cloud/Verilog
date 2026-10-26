//Example – no polymorphism
#include "Isosceles_Triangle.h"
IsoscelesTriangle::IsoscelesTriangle() : Triangle(){
}
IsoscelesTriangle::IsoscelesTriangle(double s1, double s2,
double s3) : Triangle(s1, s2, s3){
}
void IsoscelesTriangle::print_triangle(void){
cout << "Isosceles triangle: " << side1
<< " - " << side2 << " - " << side3 << endl;
}
