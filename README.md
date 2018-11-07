# Annex the Commonwealth, contributions for `v0.4.0`
Build and expand empires across the land like never before!

[Public Release](https://www.nexusmods.com/fallout4/mods/32170)

## Compatibility
This mod does not require a new game, has no external requirements and, has no quest requirements.

* **Unofficial Fallout 4 Patch:** `v2.0.0` and lower broke the workshop script API and is the only direct incompatibility with this mod. This was fixed in `v2.0.1` so, either do not use UFO4P or use `v2.0.1` or later.
* **Fallout 4 Script Extender:** This mod does not require the F4SE but has some enhanced features if it is installed.
* **Sim Settlements & Rise of the Commonwealth:** This mod does not require these mods but has some enhanced features.
* **Otherwise:** This mod is not incompatible with any other mod. That being said, it may be redundant with certain other mods.

# Prototype
The goal is to render a settlement's borders on the map menu in a way that considers it's current sub-divisions.

The "main" border along settlements have two separate but individually contiguous sections. The way the actual marker nodes work is they are linked in a circle around a sub-division with a specific keyword for that sub-division. So multiple sub-division borders may share source nodes. Each border enabler will house the points for it's [x] sections, each sub-division will have [y] border enablers, each settlement will have [z] sub-divisions.

Instead of detecting and parsing that in the game, the final data needed to pass it to Scaleform will be generated ahead of time. The UI has to be able to handle multiple sets of points to use for drawing the borders. There should be no issues with storing multiple individual arrays for the points if needed.

When drawing a line from one point to the next, ordering will be handled inherently by the array index of any given point. For example, the point at index `0` will draw a line to the point at index `1`, and so on. The last `Point` in the array will have the same `Point` as the first to ensure the region is rendered as a "closed loop".

**Steps**
* Setup plumbing for the project, papyrus, and scaleform.
* Create a standalone ATC map menu that may be opened and closed freely.
* * Create an AS3 texture loader to display the vanilla map texture on screen.
* * Add a very simple draw test for primitives in AS3. How about 4 `Points` to draw a square.
* Create some mock `Point` data in Papyrus that loosely represents sub-division borders.
* Add interoperation between AS3 and Papyrus scripts.
* * Pass `Point` data array to ATC map menu.
* Add rendering for the papyrus point data to display sub-division borders in AS3.


## Specification
This is a mockup of the potential point data to render.
```
Point
{
    float X
    float Y
}
```
