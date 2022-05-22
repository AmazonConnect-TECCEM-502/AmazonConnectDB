Attribute VB_Name = "Module1"
Sub addDummyData()
    Dim conn As ADODB.Connection
    Dim sqlstr As String
    Dim rs As ADODB.Recordset
    Dim Crow As Long, Lrow As Long
    Dim Item As String, Price As Long, weight As Long, category As String
    
    Set conn = New ADODB.Connection
    
    server = "" 'fill
    
    Password = "" 'fill
    
    conn.Open "DRIVER={MySQL ODBC 8.0 Unicode Driver};" & _
                                    "SERVER=" & server & ";" & _
                                    "PORT=3306" & _
                                    "DATABASE=capstone;" & _
                                    "USER=admin;" & _
                                    "PASSWORD=" & Password & ";"
    conn.Execute ("USE capstone;")
    
    
    Set rs = New ADODB.Recordset
     For Each Sheet In ActiveWorkbook.Sheets
        sqlstr = "INSERT INTO `" & Sheet.Name & "` ("
        For i = 1 To Application.CountA(Sheet.Range("1:1"))
            sqlstr = sqlstr & Sheet.Cells(1, i)
            If i <> Application.CountA(Sheet.Range("1:1")) Then
                sqlstr = sqlstr & ","
            Else
                sqlstr = sqlstr & ") VALUES( "
            End If
        Next i
        
        
        For j = 2 To Application.CountA(Sheet.Range("A:A"))
            Values = ""
            For i = 1 To Application.CountA(Sheet.Range("1:1"))
                If Sheet.Cells(j, i).Text = "" Then
                    Values = Values & "NULL"
                Else
                    Values = Values & """" & Sheet.Cells(j, i).Text & """"
                End If
                
                
                If i <> Application.CountA(Sheet.Range("1:1")) Then
                    Values = Values & ","
                Else
                    Values = Values & ")"
                End If
            Next i
            rs.Open sqlstr & Values, conn
        Next j
    
     Next
End Sub
