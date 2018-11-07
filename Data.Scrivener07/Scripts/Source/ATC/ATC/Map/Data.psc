Scriptname ATC:Map:Data extends ATC:Type
import ATC:Log
import ESM:Maths

Vector2f[] Points


; Events
;---------------------------------------------

Event OnQuestInit()
	RegisterForGameReload(self)
	OnGameReload()
EndEvent


Event OnGameReload()
	RegisterForMenuOpenCloseEvent(MapMenu.Name)
	Points = new Vector2f[0]

	Vector2f valueA = new Vector2f
	valueA.X = 100.0
	valueA.Y = 100.0
	Points.Add(valueA)

	Vector2f valueB = new Vector2f
	valueB.X = 200.0
	valueB.Y = 100.0
	Points.Add(valueB)

	Vector2f valueC = new Vector2f
	valueC.X = 200.0
	valueC.Y = 200.0
	Points.Add(valueC)

	Vector2f valueD = new Vector2f
	valueD.X = 100.0
	valueD.Y = 200.0
	Points.Add(valueD)

	Vector2f valueE = new Vector2f
	valueE.X = 100.0
	valueE.Y = 100.0
	Points.Add(valueE)
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	WriteLine(ToString(), "OnMenuOpenCloseEvent(menuName:"+menuName+", opening:"+opening+")")
	If (opening)
		If (Points)
			var[] arguments = new var[0]
			int index = 0
			While (index < Points.Length)
				arguments.Add(Points[index])
				index += 1
			EndWhile
			UI.Invoke(MapMenu.Name, MapMenu.Root+".SetData", arguments)
		Else
			WriteUnexpectedValue(ToString(), "OnMenuOpenCloseEvent", "Points", "The array cannot be empty or none.")
		EndIf
	Else
		; closing..
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	ATC:Map:Menu Property MapMenu Auto Const Mandatory
EndGroup
