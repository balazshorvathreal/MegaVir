Option Explicit

Sub Delete_First_Last_Columns_From_CSV_Files()

    Dim source_folder_name As String
    source_folder_name = "C:\CSV\" 'change the path to the source folder accordingly
   
    If Right(source_folder_name, 1) <> "\" Then
        source_folder_name = source_folder_name & "\"
    End If
   
    If Len(source_folder_name) = 0 Then
        MsgBox "The path to the source folder is invalid!", vbExclamation, "Invalid Path"
        Exit Sub
    End If
   
    Application.ScreenUpdating = False
   
    Dim columns_to_delete As Variant
    columns_to_delete = Array("%unambiguousReads", "unambiguousMB", "%ambiguousReads", "ambiguousMB", "unambiguousReads", "ambiguousReads", "assignedBases") 'change and/or add column headers as desired
   
    Dim current_filename As String
    current_filename = Dir(source_folder_name & "*.csv", vbNormal)
   
    Dim file_count As Long
    While Len(current_filename) > 0
        file_count = file_count + 1
        Delete_Columns_from_CSV_File source_folder_name & current_filename, columns_to_delete
        current_filename = Dir
    Wend
   
    Application.ScreenUpdating = True
   
    MsgBox "Number of files processed: " & file_count, vbInformation, "Files Processed"
   
End Sub

Private Sub Delete_Columns_from_CSV_File(ByVal source_filename As String, ByVal columns_to_delete As Variant)

    Dim source_workbook As Workbook
    Set source_workbook = Workbooks.Open(Filename:=source_filename)
   
    Dim source_worksheet As Worksheet
    Set source_worksheet = source_workbook.Worksheets(1)
   
    Dim column_found As Range
    Dim i As Long
    For i = LBound(columns_to_delete) To UBound(columns_to_delete)
        Set column_found = source_worksheet.Rows(1).Find(what:=columns_to_delete(i), LookIn:=xlValues, lookat:=xlWhole, MatchCase:=False)
        If Not column_found Is Nothing Then
            column_found.EntireColumn.Delete
        End If
    Next i
   
    source_workbook.Close SaveChanges:=True
   
End Sub



