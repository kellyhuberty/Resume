# Resume
**iOS app to display content about myself.**

*Sometimes it is better to show people what you are good at instead of telling people what you are good at.*

This app downloads content from a network connection about my latest work experience and shows the data live in an iOS app. A PDF also can be exported.

If the resume data can not be downloaded from my server, it will use the `resume.json` file from the app bundle instead.

## Requirements 
* Xcode 10
* An iOS device (Unless you want to just view on the simulator.)

## Known Issues
* If using dynamic font sizes, the PDF will render at larger sizes. **Workaround:** Turn off dynamic fonts when exporting a PDF.
* Certain export options such as Mail and Message do not work in the simulator. **Workaround:** Use those on a device.
