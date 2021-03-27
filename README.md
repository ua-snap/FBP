# Fire Behavior Prediction Algorithm

## Running tests against Fire Behavior Prediction

Open the FBP package in XCode and at the top left of the IDE, hold down the Run button and choose the Run Test button:

![Run Test](/choose_test.png)

Next, click on this Test button and all of the Automated Tests will be run against the code base found in Sources/FBP/FBP.swift.

## Updating Pod

When you are ready to make a new version of the pod for downloading to the MH iOS app, you should change the FBP.podspec file's version number. Update the minor version and push that file and any changes up to the master branch.

```bash
git add FBP.podspec
git commit -m "Updated to new version of FBP.podspec file."
git push origin master
git tag <version>
git push origin <version>
```

After this has been updated, you will need to finally push up the new Podfile in Github to be available to the MH iOS app.

```bash
pod repo push FBP FBP.podspec
```

When this finishes, you can update the available Pods in the MH iOS application by using the newest version of this repo.
