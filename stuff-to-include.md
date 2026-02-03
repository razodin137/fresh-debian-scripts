

# Fix That Horrible Middle-Click on Touchpads/Laptops

One very annoying feature on almost all linux distros is the handling of middle-click on touchpads.
Which means for just about any laptop, you're going to want to disable the right-click and change it to "two-finger-click-to-rightclick."

I've handled this on debian running xfce via the following command 
(I think it's not even up to xfce or debian it's really the xserver that's handling this).

```
xfconf-query -c pointers -p /GXTP510000_27C601E0_Touchpad/Properties/libinput_Click_Method_Enabled
```
