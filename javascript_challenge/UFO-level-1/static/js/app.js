// from data.js
var tableData = data;

// YOUR CODE HERE!
var tbody = d3.select("tbody");
var btnFilter = d3.select("#filter-btn");
var btnClear = d3.select("#filter-clear-btn");
var cond = d3.select("#selCond");

// Initialize table
tableData.forEach((ufo) => {
    var row = tbody.append("tr");
    Object.entries(ufo).forEach(([key,value]) => {
        var cell = row.append("td");
        cell.text(value);
    });
});

// Clear filter
btnClear.on("click", function(){
    tbody.selectAll("tr").remove();
    tableData.forEach((ufo) => {
        var row = tbody.append("tr");
        Object.entries(ufo).forEach(([key,value]) => {
            var cell = row.append("td");
            cell.text(value);
        });
    });

    alert("Cleared Filter")
});

btnFilter.on("click", function(){
    
    var inputDate = d3.select("#datetime");

    var inputDateValue = inputDate.property("value");

    console.log(inputDateValue)
    
    // validation input data is emty (@todo: validate using regex)

    //clear table
    tbody.selectAll("tr").remove();

    var filteredData = tableData.filter(ufo => ufo.datetime === inputDateValue );

    
    //console.log(filteredData);
    
    //insert data into the table
    filteredData.forEach((ufo) => {
        var row = tbody.append("tr");
        
        Object.entries(ufo).forEach(([key,value]) => {
        var cell = row.append("td");
        cell.text(value);
        });
    });
    alert("Total "+ filteredData.length +" datas found!")
    
});