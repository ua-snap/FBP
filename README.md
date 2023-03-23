# Fire Behavior Prediction Algorithm

## Project Description
This Swift project provides an implementation of the Fire Behavior Prediction (FBP) algorithm written in Swift. The project is designed to be used as a publicly available CocoaPod that can be easily integrated into iOS mobile applications and projects.

FBP is a widely used system in wildland fire management that predicts fire behavior and fire effects based on inputs such as weather, fuels, and topography. The FBP system consists of a set of mathematical models that simulate the physical processes of fire spread and behavior. It is a commonly used system in the state of Alaska and Canadian provinces.

The Swift implementation of FBP is a modern, high-performance implementation that is specifically designed to be used in iOS mobile applications for FBP calculations done at remote sites without network connectivity. This project includes code that has been translated from the algorithm used to run the FBP system on the website https://akff.mesowest.org/tools/fbp/. By integrating this implementation of the FBP algorithm into mobile applications, users can have access to fire behavior prediction and fire effects calculations even when working in remote locations with limited connectivity.

## Adding to your iOS application

1. Open your Xcode project and navigate to the project directory in the terminal.
2. Create a Podfile by running the command pod init in the terminal. This will create a Podfile in your project directory.
3. Open the Podfile in your preferred text editor and add the following line to it:
```
pod 'FBP', :git => 'https://github.com/ua-snap/FBP.git'
```
This will add the FBP CocoaPod as a dependency to your project.
4. Save the Podfile and run the command pod install in the terminal. This will download the FBP CocoaPod and create an Xcode workspace that includes the FBP library and your project.
5. Import the FBP library by adding the following line to the top of your source code file:
```
import FBP
```
You can now use the FBP library in your code by calling its functions and methods by creating a new FBPAlgorithm object.
```
let fbp = FBPAlgorithm()
```
