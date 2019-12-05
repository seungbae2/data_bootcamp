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
    var inputCity = d3.select("#city");
    var inputState = d3.select("#state");
    var inputCountry = d3.select("#country");
    var inputShape = d3.select("#shape");

    var inputDateValue = inputDate.property("value");
    // change to lower case
    var inputCityValue = inputCity.property("value").toLowerCase();
    var inputStateValue = inputState.property("value").toLowerCase();
    var inputCountryValue = inputCountry.property("value").toLowerCase();
    var inputShapeValue = inputShape.property("value").toLowerCase();

    console.log(inputDateValue)
    
    // validation input data is emty (@todo: validate using regex)
    if(cond.node().value === "and" && (inputDateValue === "" || inputCityValue === "" || inputStateValue === "" || inputCountryValue === "" || inputShapeValue=== "")){
        alert("You have to put all filter data");
    }else if(cond.node().value === "or"&& (inputDateValue === "" && inputCityValue === "" && inputStateValue === "" && inputCountryValue === "" && inputShapeValue=== "")){
        alert("You have to put at least one filter data")
    }else{
        //clear table
        tbody.selectAll("tr").remove();
    
        //filter data with 'or' condition
        if(cond.node().value === "or"){
            var filteredData = tableData.filter(ufo => (ufo.datetime === inputDateValue || ufo.city === inputCityValue || ufo.state === inputStateValue || ufo.country === inputCountryValue || ufo.shape === inputShapeValue));
        }
        //filter data with 'and' condition
        if(cond.node().value === "and"){
            var filteredData = tableData.filter(ufo => (ufo.datetime === inputDateValue && ufo.city === inputCityValue && ufo.state === inputStateValue && ufo.country === inputCountryValue && ufo.shape === inputShapeValue));
        }
        
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
    }
});