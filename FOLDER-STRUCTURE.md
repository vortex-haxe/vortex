# 🟪 Folder Structure
This is how the source code will be organized.
---
📂 **vortex** - The root of Vortex itself.
   - 📂 **backend** - The backbones of the game, such as initializing the engine.
   - 📂 **debug** - Utilties for debugging your code.
   - 📂 **macros** - Utilities that run at compile time.
   - 📂 **objects** - Game objects to base things like players and enemies off of.
   - 📂 **plugins** - Togglable code that runs in the background.
   - 📂 **resources** - Resources such as Textures, Sounds, Fonts, etc.
   - 📂 **servers** - Similar to plugins, without the toggability.
   - 📂 **utils** - Utilities for the engine AND your own development.
   - 📄 **import.hx** - Some global imports, only useful for engine development.