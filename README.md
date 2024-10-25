# Ruler Scale Indicator

A Flutter package that provides a customizable and interactive scale ruler widget. It allows users to create a horizontal scrollable ruler, suitable for measuring ranges in various applications, with customizable line spacing, ruler height, alignment, and more.

## Features

- **Adjustable Range:** Set minimum and maximum values for the ruler.
- **Customizable Line Spacing:** Define the spacing between each line.
- **Variable Ruler Height:** Adjust the height of the ruler to fit different UI designs.
- **Alignment Options:** Choose between top or bottom alignment of the scale.
- **Real-time Value Display:** Shows the current value as the user scrolls.
- **Decimal Precision:** Define the number of decimal places for displayed values.
- **Pointer Color:** Customize the color of the pointer.
- **Value Change Callback:** Get notified when the selected value changes.

## Preview

![Scale Ruler GIF](https://raw.githubusercontent.com/your-username/ruler_scale_indicator/main/assets/scale_ruler_preview.gif)

#### Installation:
To use this package in your Flutter project, add it to your pubspec.yaml file:

    dependencies:
      firebase_realtime_chat: ^version_number
Then, run `flutter pub get` to install the package.

##### Usage:
###### Import the package in your Dart file:

    import 'package:ruler_scale_indicator/ruler_scale_indicator.dart';


#### Basic Example:
##### Here's an example of how to use the `ScaleRuler` widget in your Flutter app:

      ScaleRuler(
        minRange: 0,
        maxRange: 500,
        lineSpacing: 0.5,
        rulerHeight: 150,
        decimalPlaces: 2,
        alignmentPosition: AlignmentPosition.bottom,
        ),
### Customization Options
##### The ScaleRuler widget offers several customizable parameters:
| **Parameter**       | **Type**            | **Description**                                         | **Default Value**          |
|---------------------|---------------------|---------------------------------------------------------|----------------------------|
| `minRange`          | `double`            | Minimum value of the ruler's range.                     | `0`                        |
| `maxRange`          | `double`            | Maximum value of the ruler's range.                     | `10`                       |
| `lineSpacing`       | `double`            | Spacing between each line on the ruler.                 | `0.2`                      |
| `rulerHeight`       | `double`            | Height of the ruler widget.                             | `120`                      |
| `decimalPlaces`     | `int`               | Number of decimal places for displayed values.          | `0`                        |
| `pointerColor`      | `Color`             | Color of the pointer and the displayed value.           | `Colors.blue`              |
| `alignmentPosition` | `AlignmentPosition` | Sets the alignment of the scale (top or bottom).        | `AlignmentPosition.bottom` |
| `onChange`          | `Function?`         | Callback function that is triggered when the value changes. | `null`                  |

### Contributing:
Contributions are welcome! Feel free to submit issues or pull requests on GitHub.

### License:
This package is licensed under the `GNU General Public License v3.0` License.

#### Author:
`Mudassir Mukhtar`

#### Contact:
 <a href="https://www.linkedin.com/in/mudassir-mukhtar-17aa89196/" target="_blank" rel="noopener noreferrer">
   <img src="https://img.shields.io/badge/LinkedIn-Profile-blue?logo=linkedin&logoColor=white&color=blue" />
 </a>
 <a href="mailto:mudassirmukhtar4@gmail.com" target="_blank" rel="noopener noreferrer">
   <img src="https://img.shields.io/badge/Gmail-Address-red?logo=gmail&logoColor=white&color=blue" />
 </a>
 <a href="https://wa.me/+923454335400" target="_blank" rel="noopener noreferrer">
   <img src="https://img.shields.io/badge/Whatsapp-Number-blue?logo=whatsapp&logoColor=white&color=blue" />
 </a>
  <a href="https://www.facebook.com/lovely06mian" target="_blank" rel="noopener noreferrer">
   <img src="https://img.shields.io/badge/Facebook-Profile-blue?logo=facebook&logoColor=white&color=blue" />
 </a>

##### Acknowledgments:
Thank you to the Flutter community for their contributions and support.

#### Support:
For any questions or assistance, please reach out to the author or open an issue on GitHub.

#### Disclaimer:
This package is provided as-is without any warranty. Use it at your own discretion.

# Happy Coding! 🚀