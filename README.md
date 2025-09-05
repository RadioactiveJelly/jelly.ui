# ravenfield-jelly.ui
A package containing scripts to help modders create UI in Ravenscript faster.

## 📝 Description
This project was initially meant to be a direct successor to the Custom_HUD repo. However during development, I thought it'd be best to instead create a package that has a more general use case. This package contains scripts that are for general UI creation and optionally an example where they were used to create a HUD.


## ⚙ Installation

The first thing you'll need to do is install git on your machine: https://git-scm.com/downloads. 

Once that is done, open your project and open the package manager.

<img width="607" height="629" alt="install1" src="https://github.com/user-attachments/assets/3a7d5c25-54d6-4e80-8398-97fdc76ac64e" />

Next, click __"Add Package from git URL"__ 

<img width="323" height="163" alt="install2" src="https://github.com/user-attachments/assets/7fc67fad-fe49-4139-8060-e4a55a979bb8" />

Paste this URL: https://github.com/RadioactiveJelly/jelly.ui.git

Once installation is complete, you should see this:

<img width="800" height="567" alt="install3" src="https://github.com/user-attachments/assets/f67cd8cf-1036-44ee-8350-5ecc94c9d872" />

### Optional

This is optional but highly recommended for new user.

Open the __Samples__ drop down. You should see an "Example and Prefabs" option. Click "Import"

<img width="452" height="528" alt="install-extra" src="https://github.com/user-attachments/assets/856e2051-944d-49e8-82da-1f228f12a10a" />

After this, new files can be found in: Assets/Samples/Jelly.UI/<package version>

<img width="331" height="100" alt="install-extra2" src="https://github.com/user-attachments/assets/98851edf-4344-42e9-8b84-8ad794c5decb" />

These contain an example HUD created using the Jelly.UI scripts, as well as prefabs for each UI element used in the HUD.

__IMPORTANT__: I highly recommend to not create variants using the prefabs from the example. Instead, you can unpack these prefabs. This is to prevent any GUID collissions to occur in case you reimport the samples again.

## 🛠 Useful Tools

Install git UPM extension: https://github.com/mob-sakai/UpmGitExtension
This can be used to select package versions more freely. Use this in case API changes occur between versions that can potentially break your projects.
