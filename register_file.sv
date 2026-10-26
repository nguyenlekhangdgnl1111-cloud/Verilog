#ifndef TRIANGLE_H_
#define TRIANGLE_H_
#include <iostream>
using namespace std;
class Triangle {
protected:
double side1;
double side2;
double side3;
public:
Triangle();
Triangle(double s1, double s2, double
s3);
void print_triangle(void);
};
#endif /* TRIANGLE_H_ */
