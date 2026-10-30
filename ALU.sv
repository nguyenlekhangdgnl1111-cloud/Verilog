#include "Rect3.h"
Rect3::Rect3()
{
setWidth(0.0);
setLength(0.0);
}
void Rect3::setWidth(double w)
{
if (w >= 0)
width = w;
else
throw NegativeWidth(w);
return;
}
void Rect3::setLength(double l)
{
if (l >= 0)
length = l;
else
throw NegativeLength(l);
return;
}
double Rect3::getWidth(void)
{
return width;
}
double Rect3::getLength(void)
{
return length;
}
double Rect3::calcArea(void)
{
return (width * length);
}
