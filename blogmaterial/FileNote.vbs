Dim wsh,fso
Set wsh = CreateObject("Wscript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set target = Wscript.arguments

If target.Count Then
	path = target(0) & ":FileNote.txt"
	If Not (fso.FileExists(path)) Then Note()
	wsh.Run "cmd /c notepad " & path,0
	Wscript.Quit
Else
	folder = fso.getfolder(".")
	vbs = Replace(Wscript.ScriptFullName, "\", "\\")
	cmd = "wscript.exe \""" & vbs & "\"" \""%1\"""
	If Installed() Then
		a = MsgBox("已存在文件右键菜单，是否生成Unreg.reg以移除？",36,"确认")
		If a = vbYes Then UnReg()
	Else
		a = MsgBox("未添加到文件右键菜单？是否生成reg.reg以添加？",36,"确认")
		If a = vbYes Then Reg()
	End If
End If

Function Reg()
	Set f = fso.CreateTextFile(folder & "\Reg.reg")
	f.WriteLine "Windows Registry Editor Version 5.00"
	f.WriteLine
	f.WriteLine "[HKEY_CLASSES_ROOT\*\shell\File Note]"
	f.WriteLine "@=" & Chr(34) & "File Note" & Chr(34)
	f.WriteLine
	f.WriteLine "[HKEY_CLASSES_ROOT\*\shell\File Note\command]"
	f.WriteLine "@=" & Chr(34) & cmd & Chr(34)
	f.close
	Wscript.echo "reg.reg已生成，运行reg.reg添加右键菜单项"
	Wscript.Quit
End Function

Function UnReg()
	Set f = fso.CreateTextFile(folder & "\UnReg.reg")
	f.WriteLine "Windows Registry Editor Version 5.00"
	f.WriteLine
	f.WriteLine "[-HKEY_CLASSES_ROOT\*\shell\File Note]"
	f.WriteLine "@=" & Chr(34) & "File Note" & Chr(34)
	f.close
	Wscript.echo "Unreg.reg已生成，运行Unreg.reg移除右键菜单项"
	Wscript.Quit
End Function

Function Note()
	Set f = fso.CreateTextFile(path)
	Set s = fso.GetFile(target(0))
'【移除下行行首的注释符，每次查看/编辑备注时将自动添加编辑日期到备注文末】
'	f.WriteLine ".LOG"
	f.WriteLine "[File Note]"
	f.WriteLine "原文件名称:" & s.Name
	f.WriteLine "原文件大小:" & s.Size
	f.Close
End Function

Function Installed()
	On Error Resume Next
	k=wsh.RegRead("HKCR\*\shell\File Note\")
	If err.Number = -2147024894 Then Installed = 0 Else Installed = 1
End Function