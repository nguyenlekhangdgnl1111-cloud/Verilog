//Example – no polymorphism
#ifndef RIGHT_TRIANGLE_H_
#define RIGHT_TRIANGLE_H_
#include "Triangle.h"
class RightTriangle: public Triangle {
public:
RightTriangle();
RightTriangle(double s1, double s2,
double s3);
void print_triangle(void);
};
#endif /* RIGHT_TRIANGLE_H_ */
