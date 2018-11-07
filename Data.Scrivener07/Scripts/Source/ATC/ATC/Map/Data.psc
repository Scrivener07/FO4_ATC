Scriptname ATC:Map:Data extends ATC:Type
import ATC:Log

Point[] Points

Struct Point
	float X = 0.0
	float Y = 0.0
EndStruct


; Events
;---------------------------------------------

Event OnQuestInit()
	RegisterForGameReload(self)
	OnGameReload()
EndEvent


Event OnGameReload()
	RegisterForMenuOpenCloseEvent(MapMenu.Name)
	Points = new Point[0]

	Point valueA = new Point
	valueA.X = 100.0
	valueA.Y = 100.0
	Points.Add(valueA)

	Point valueB = new Point
	valueB.X = 200.0
	valueB.Y = 100.0
	Points.Add(valueB)

	Point valueC = new Point
	valueC.X = 200.0
	valueC.Y = 200.0
	Points.Add(valueC)

	Point valueD = new Point
	valueD.X = 100.0
	valueD.Y = 200.0
	Points.Add(valueD)

	Point valueE = new Point
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
