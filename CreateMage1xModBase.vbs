' VBTab 	A Tab character [Chr(9)]
' VBCr 	A carriage return [Chr(13)]
' VBCrLf 	A carriage return and line feed [Chr(13) + Chr(10)]
' vbBack 	A backspace character [Chr(8)]
' vbLf 	A linefeed [Chr(10)]
' vbNewLine 	A platform-specific new line character, either [Chr(13) + Chr(10)] or [Chr(13)]
' vbNullChar 	A null character of value 0 [Chr(0)]
' vbNullString 	A string of value 0 [no Chr code]; note that this is not the same as “”

scriptDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
currFolder = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
Set xmlDoc = CreateObject("Msxml2.DOMDocument.3.0")
Set fS = CreateObject("Scripting.FileSystemObject")

packageName = InputBox("Package Name:")
moduleName = InputBox("Module Name:")
codePool = InputBox("CodePool:")
moduleVersion = InputBox("Module version:")

If packageName = "" Or moduleName = "" Or codePool = "" Then
	MsgBox "PackageName, ModuleName & CodePool are mandatory !!!"
	WScript.Quit
End If

If moduleVersion = "" Then
	moduleVersion = "1.0.0"
End If

Sub BuildFullPath(ByVal FullPath)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If Not fso.FolderExists(FullPath) Then
		BuildFullPath fso.GetParentFolderName(FullPath)
		fso.CreateFolder FullPath
		Call Dispose(fso)
	End If
End Sub

mainDirPath = currFolder & "\" & packageName & "_" & moduleName
appDirPath = mainDirPath & "\app"
codeDirPath = appDirPath & "\code"
modCodePath = codeDirPath & "\" & codePool & "\" & packageName & "\" & moduleName
initXmlPath = appDirPath & "\etc\modules\"
confXmlPath = modCodePath & "\etc\"

fS.CreateFolder mainDirPath
fS.CreateFolder appDirPath
fS.CreateFolder codeDirPath
' fS.CreateFolder modCodePath
' fS.CreateFolder xmlFilePath
BuildFullPath modCodePath
BuildFullPath initXmlPath
BuildFullPath confXmlPath

initXmlString = "<?xml version=" & chr(34) & "1.0" & chr(34) & "?>" & vbCr & _
"<config>" & vbCr & _
VBTab & "<modules>" & vbCr & _
VBTab & VBTab & "<" & packageName & "_" & moduleName & ">" & vbCr & _
VBTab & VBTab & VBTab & "<active>true</active>" & vbCr & _
VBTab & VBTab & VBTab & "<codePool>" & codePool & "</codePool>" & vbCr & _
VBTab & VBTab & VBTab & "<version>" & moduleVersion & "</version>" & vbCr & _
VBTab & VBTab & "</" & packageName & "_" & moduleName & ">" & vbCr & _
VBTab & "</modules>" & vbCr & _
"</config>"

confXmlString = "<?xml version=" & chr(34) & "1.0" & chr(34) & "?>" & vbCr & _
"<config>" & vbCr & _
VBTab & "<modules>" & vbCr & _
VBTab & VBTab & "<" & packageName & "_" & moduleName & ">" & vbCr & _
VBTab & VBTab & VBTab & "<version>" & moduleVersion & "</version>" & vbCr & _
VBTab & VBTab & "</" & packageName & "_" & moduleName & ">" & vbCr & _
VBTab & "</modules>" & vbCr & _
VBTab & "<global>" & vbCr & _
VBTab & "</global>" & vbCr & _
"</config>"

xmlFilePath = initXmlPath & packageName & "_" & moduleName & ".xml"
xmlDoc.Save xmlFilePath
Set fSO = fS.OpenTextFile(xmlFilePath, 2, false)
fSO.Write initXmlString
fSO.Close()
Call Dispose(fSO)

xmlFilePath = confXmlPath & "config.xml"
xmlDoc.Save xmlFilePath
Set fSO = fS.OpenTextFile(xmlFilePath, 2, false)
fSO.Write confXmlString
fSO.Close()

Call Dispose(fSO)
Call Dispose(fS)

' Disposes of dictionaries, arrays, and variables
Sub Dispose(ByRef obj)
	If IsObject(obj) Then
		If LCase(TypeName(obj)) = "dictionary" Then
			obj.RemoveAll ' Remove all key, item pairs
		End If
		Set Obj = Nothing ' Disassociate
	ElseIf IsArray(obj) Then
		Erase obj ' Clear the array
	End If
	obj = Empty ' Uninitialize
End Sub