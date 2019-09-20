Sub stockDataAnalyze()

        'Loop for every sheets'
        For Each ws In Worksheets
            
            'Get last column and row from origianl data'
            lastColumn = ws.Cells(1, Columns.Count).End(xlToLeft).Column + 1
            lastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row + 1
            
            'allocate new data header column'
            newTickerColumn = lastColumn + 2
            newYearlyColumn = lastColumn + 3
            newPercentColumn = lastColumn + 4
            newTotalVolColumn = lastColumn + 5
            
            ws.Cells(1, newTickerColumn) = "Ticker"
            ws.Cells(1, newYearlyColumn) = "Yearly Change"
            ws.Cells(1, newPercentColumn) = "Percent Change"
            ws.Cells(1, newTotalVolColumn) = "Total Stock Volume"
            
            'additional data header column'
            greatestTickerCol = newTotalVolColumn + 4
            greatestValueCol = newTotalVolColumn + 5
            ws.Cells(1, greatestTickerCol) = "Ticker"
            ws.Cells(1, greatestValueCol) = "Value"
            
            ws.Cells(2, greatestTickerCol - 1) = "Greatest % Increase"
            ws.Cells(3, greatestTickerCol - 1) = "Greatest % Decrease"
            ws.Cells(4, greatestTickerCol - 1) = "Greatest Total Volume"
            
            'new data table last row'
            newlastRow = ws.Cells(Rows.Count, newTickerColumn).End(xlUp).Row + 1
            
            'original data ticker first row info'
            firstTickerRow = 2

            '------------------------------------------------------------------------------------------'
            'Table for Ticker's Yearly Change, Percent Change, Total Stock Volume'
            '------------------------------------------------------------------------------------------'
            
            For i = 2 To lastRow
            
                If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1) Then
                    
                    tickerValue = ws.Cells(i, 1)
                    ws.Cells(newlastRow, newTickerColumn) = tickerValue
                    
                    'Calculate Yearly change'
                    yearlyValue = ws.Cells(i, 6) - ws.Cells(firstTickerRow, 3)
                    ws.Cells(newlastRow, newYearlyColumn) = yearlyValue
                    
                    'Calculate Percent Change'
                    If ws.Cells(firstTickerRow, 3) > 0 Then
                        percentValue = yearlyValue / ws.Cells(firstTickerRow, 3)
                        ws.Cells(newlastRow, newPercentColumn) = percentValue
                        ws.Columns(newPercentColumn).NumberFormat = "0.00%"
                    Else
                        ws.Cells(newlastRow, newPercentColumn) = 0
                        ws.Columns(newPercentColumn).NumberFormat = "0.00%"
                    End If

                    'Calculate Total Stock Volume'
                    totalVol = Application.WorksheetFunction.Sum(Range(ws.Cells(firstTickerRow, 7), ws.Cells(i, 7)))
                    ws.Cells(newlastRow, newTotalVolColumn) = totalVol

                    'Conditional for Yearly Change negative or positive'
                    If yearlyValue > 0 Then
                        ws.Cells(newlastRow, newYearlyColumn).Interior.ColorIndex = 4
                    ElseIf ws.Cells(newlastRow, newYearlyColumn) < 0 Then
                        ws.Cells(newlastRow, newYearlyColumn).Interior.ColorIndex = 3
                    End If
                        
                    
                    newlastRow = newlastRow + 1
                    firstTickerRow = i + 1
                End If

            Next i
            
            '------------------------------------------------------------------------------------------'
            'Table for greatest % increase, decrease and total Volume'
            '------------------------------------------------------------------------------------------'
            maxPercent = ws.Cells(2, newPercentColumn)
            Dim maxPercentRow
            minPercent = ws.Cells(2, newPercentColumn)
            Dim minPercentRow
            maxVol = ws.Cells(2, newTotalVolColumn)
            Dim MaxVolRow
            
            'greatest % increase'
            For j = 2 To newlastRow
                    If ws.Cells(j, newPercentColumn) > maxPercent Then
                        maxPercent = ws.Cells(j, newPercentColumn)
                        maxPercentRow = j
                    End If
            Next j
            
            'greatest % decrease'
            For k = 2 To newlastRow
                    If ws.Cells(k, newPercentColumn) < minPercent Then
                        minPercent = ws.Cells(k, newPercentColumn)
                        minPercentRow = k
                    End If
            Next k
            
            'greatest total volume'
            For n = 2 To newlastRow
                    If ws.Cells(n, newTotalVolColumn) > maxVol Then
                        maxVol = ws.Cells(n, newTotalVolColumn)
                        MaxVolRow = n
                    End If
            Next n

            ws.Cells(2, greatestTickerCol) = ws.Cells(maxPercentRow, newTickerColumn)
            ws.Cells(2, greatestValueCol) = maxPercent
            ws.Cells(2, greatestValueCol).NumberFormat = "0.00%"
            
            ws.Cells(3, greatestTickerCol) = ws.Cells(minPercentRow, newTickerColumn)
            ws.Cells(3, greatestValueCol) = minPercent
            ws.Cells(3, greatestValueCol).NumberFormat = "0.00%"
            
            ws.Cells(4, greatestTickerCol) = ws.Cells(MaxVolRow, newTickerColumn)
            ws.Cells(4, greatestValueCol) = maxVol

            '------------------------------------------------------------------------------------------'
            'Autofit columns'
            '------------------------------------------------------------------------------------------'
            
            ws.Columns(newTickerColumn).EntireColumn.AutoFit
            ws.Columns(newYearlyColumn).EntireColumn.AutoFit
            ws.Columns(newPercentColumn).EntireColumn.AutoFit
            ws.Columns(newTotalVolColumn).EntireColumn.AutoFit
            
            ws.Columns(greatestTickerCol).EntireColumn.AutoFit
            ws.Columns(greatestValueCol).EntireColumn.AutoFit
            ws.Columns(greatestTickerCol - 1).EntireColumn.AutoFit
  
        Next ws
        

End Sub

