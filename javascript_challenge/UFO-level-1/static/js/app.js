// from data.js
var tableData = data;

// YOUR CODE HERE!
var tbody = d3.select("tbody");
var btnFilter = d3.select("#filter-btn");

tableData.forEach((ufo) => {
    var row = tbody.append("tr");
    Object.entries(ufo).forEach(([key,value]) => {
        var cell = row.append("td");
        cell.text(value);
    });
});

btnFilter.on("click", function(){
    var inputDate = d3.select("#datetime");
    var inputCity = d3.select("#city");
    var inputState = d3.select("#state");
    var inputCountry = d3.select("#country");
    var inputShape = d3.select("#shape");

    var inputDateValue = inputDate.property("value");
    var inputCityValue = inputCity.property("value");
    var inputStateValue = inputState.property("value");
    var inputCountryValue = inputCountry.property("value");
    var inputShapeValue = inputShape.property("value");
    
    
    var filteredData = tableData.filter(ufo => (ufo.datetime === inputDateValue && ufo.city === inputCityValue && ufo.state === inputStateValue && ufo.country === inputCountryValue && ufo.shape === inputShapeValue));
    console.log(filteredData);
    
    tbody.select("tr").remove();

    filteredData.forEach((ufo) => {
        var row = tbody.append("tr");
        
        Object.entries(ufo).forEach(([key,value]) => {
        var cell = row.append("td");
        cell.text(value);
        });
    });
});