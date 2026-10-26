//Example – no polymorphism
#ifndef ISOSCELES_TRIANGLE_H_
#define ISOSCELES_TRIANGLE_H_
#include "Triangle.h"
class IsoscelesTriangle: public
Triangle {
public:
IsoscelesTriangle();
IsoscelesTriangle(double s1,
double s2, double s3);
void print_triangle(void);
};
#endif /* ISOSCELES_TRIANGLE_H_ */
