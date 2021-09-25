# Exercise-02d-Menu-and-HUD
Exercise for MSCH-C220, 16 September 2021

A demonstration of this exercise is available at [https://youtu.be/tgZPOtYoJZ4](https://youtu.be/tgZPOtYoJZ4)

This exercise is designed to explore control nodes and changing scenes. I am hoping this gives you what you need to complete your project.

Fork this repository. When that process has completed, make sure that the top of the repository reads [your username]/Exercise-02d-Menu-and-HUD. *Edit the LICENSE and replace BL-MSCH-C220-F21 with your full name.* Commit your changes.

Press the green "Code" button and select "Open in GitHub Desktop". Clone the repository to a Local Path on your computer.

Open Godot. In the Project Manager, tap the "Import" button. Tap "Browse" and navigate to the repository folder. Select the project.godot file and tap "Open".

In the viewport, you should see the 2D space shooter-style game we have been working on. The A and D controls rotate the ship left and right, the W key moved it forward, and the space button will shoot bullets.

Your assignment for this exercise is to provide the following: change the default scene to a main menu that offers options to Play and Quit. The play button should load the Game.tscn scene. Add an AutoLoad HUD scene that displays score and health as labels. Add an end-game screen that appears when the player's health reaches zero.

You can change to a new scene in Godot with a simple statement:
```
get_tree().change_scene("res://path/to/scene.tscn")
```

The instructions are as follows:

## HUD
 * Right-click on the HUD_Container node and Add Child Node. Select Control. Rename the new Control node "HUD".
 * Right-click on the HUD node and Add Child Node. Select ColorRect. In the Inspector panel, Select Control->Rect->Size. Set it to x=1024, y=40. Select ColorRect->Color. Set A=64
 * Right-click on the HUD node and Add Child Node. Select Label. Rename the new Label node "Health". In the Inspector panel, select Control->Margin and set Left=10. select select Control->Rect->Size. Set it to x=502, y=40. Select Label->Text. Set it to "Health: ". Set Valign=Center. Select Control->Custom Fonts->Font->New Dynamic Font. Select Font again, and select Edit. In the DynamicFont menu that appears, Select Font->FontData and choose Load. Open res://Assets/BebasNeueRegular.otf/. Select DynamicFont->Settings and set Size=20.
 * Right-click on the Health node and Duplicate. Rename the Health2 node "Score". In the Inspector panel, set Label->Text to "Score: ". Set Label->Align=Right. In  Control->Rect set Position.x=512
 
 * Add the following to the end of res://Global.gd
```
func update_score(s):
	Score = get_node_or_null("/root/Game/HUD_Container/HUD/Score")
	if Score != null:
		score += s
		Score.text = "Score: " + str(score)

func update_health(h):
	Health = get_node_or_null("/root/Game/HUD_Container/HUD/Health")
	health += h
	Health.text = "Health: " + str(health)
	if health <= 0:
		var _scene = get_tree().change_scene("res://Menu/Die.tscn")
 ```

## Updating health and score

The Player and Enemy scenes are responsible for updating the health and score. Those calls can be found in res://Player/Player.gd, lines 47–48, and res://Enemy/Enemy.gd, lines 28–29. 

## Main menu

 * In the Scene menu, select New Scene. In the Scene panel, Create Root Node: select User Interface. Change the name of the Control node to "Menu"
 * Right-click on the Menu node and Add Child Node. Select Label. In the Inspector Panel, set the Label->Text="Welcome!". Label->Align=Center, Label->Valign=Center. Control->Rect->Size x=1024, y=300.  Select Control->Custom Fonts->Font->New Dynamic Font. Select Font again, and select Edit. In the DynamicFont menu that appears, Select Font->FontData and choose Load. Open res://Assets/BebasNeueRegular.otf/. Select DynamicFont->Settings and set Size=60.
 * Right-click on the Menu node and Add Child Node. Select Button. Change the name of the node to "Play". In the Inspector Panel, set the Button->Text="Play". Control->Rect->Position x=412, y=300. Control->Rect->Size x=200, y=60.  Select Control->Custom Fonts->Font->New Dynamic Font. Select Font again, and select Edit. In the DynamicFont menu that appears, Select Font->FontData and choose Load. Open res://Assets/BebasNeueRegular.otf. Select DynamicFont->Settings and set Size=24.
 * Right-click on the Play node and Duplicate. Change the name of the Play2 node to "Quit". In the Inspector Panel, set the Label->Text="Quit". Control->Rect->Position y=380.
 * Right-click on the Menu node and Attach Script. Create a new Menu folder, and save the script as res://Menu/Menu.gd
 * Select the Play node and open the Node panel. Double-click on the pressed() signal and attach it to the Menu script
 * Select the Quit node and open the Node panel. Double-click on the pressed() signal and attach it to the Menu script
 * Replace the contents of Menu.gd with the following:

```
extends Control

func _on_Play_pressed():
   var _scene = get_tree().change_scene("res://Game.tscn")

func _on_Quit_pressed():
  get_tree().quit()
```

 * Save the scene as res://Menu/Menu.tscn
 * Open the Project Settings. In General->Appliction->Run, set the main scene as res://Menu/Menu.tscn

## End-game screen

 * In the Scene menu, select New Scene. In the Scene panel, Create Root Node: select User Interface. Change the name of the Control node to "Die"
 * Right-click on the Die node and Add Child Node. Select Label. In the Inspector Panel, set the Label->Text="You Died!". Label->Align=Center, Label->Valign=Center. Control->Rect->Size x=1024, y=300.  Select Control->Custom Fonts->Font->New Dynamic Font. Select Font again, and select Edit. In the DynamicFont menu that appears, Select Font->FontData and choose Load. Open res://Assets/BebasNeueRegular.otf/. Select DynamicFont->Settings and set Size=60.
 * Right-click on the Die node and Add Child Node. Select Button. Change the name of the node to "Play". In the Inspector Panel, set the Button->Text="Play Again?". Control->Rect->Position x=412, y=300. Control->Rect->Size x=200, y=60.  Select Control->Custom Fonts->Font->New Dynamic Font. Select Font again, and select Edit. In the DynamicFont menu that appears, Select Font->FontData and choose Load. Open res://Assets/BebasNeueRegular.otf/. Select DynamicFont->Settings and set Size=24.
 * Right-click on the Play node and Duplicate. Change the name of the Play2 node to "Quit". In the Inspector Panel, set the Label->Text="Quit". Control->Rect->Position y=380.
 * Right-click on the Die node and Attach Script. In the Menu folder save the script as res://Menu/Die.gd
 * Select the Play node and open the Node panel. Double-click on the pressed() signal and attach it to the Die script
 * Select the Quit node and open the Node panel. Double-click on the pressed() signal and attach it to the Die script
 * Replace the contents of Die.gd with the following:

```
extends Control

func _on_Play_pressed():
	Global.score = 0
	Global.health = 100
	var _scene = get_tree().change_scene("res://Game.tscn")

func _on_Quit_pressed():
	get_tree().quit()
```

 * Save the scene as res://Menu/Die.tscn
 
 
Test the game. You should be able to start the game, see the score and health updated, and then go to the end-game screen when the health is reduced to zero.

Quit Godot. In GitHub desktop, you should now see the updated files listed in the left panel. In the bottom of that panel, type a Summary message (something like "Completes the game development") and press the "Commit to master" button. On the right side of the top, black panel, you should see a button labeled "Push origin". Press that now.

If you return to and refresh your GitHub repository page, you should now see your updated files with the time when they were changed.

Now edit the README.md file. When you have finished editing, commit your changes, and then turn in the URL of the main repository page (https://github.com/[username]/Exercise-02d-Menu-HUD-Levels) on Canvas.

The final state of the file should be as follows (replacing my information with yours):
```
# Exercise-02d-Menu-HUD-Levels
Exercise for MSCH-C220, 16 September 2021

A simple game exploring HUD elements and changing scenes.

## Implementation
Built using Godot 3.3.3

The font, Bebas Neue Regular (Ryoichi Tsunekawa) was downloaded from [https://fontlibrary.org/en/font/bebasneueregular](https://fontlibrary.org/en/font/bebasneueregular)

Assets provided by [kenney.nl](https://kenney.nl/assets/simple-space)

Explosion sprite sheets provided by [StumpyStrust](https://opengameart.org/content/explosion-sheet) and [Cuzco](https://opengameart.org/content/explosion)

## References
None

## Future Development
None

## Created by 
Jason Francis

```
