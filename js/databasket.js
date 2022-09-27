/*Project: Oath of Allegiance
Author: Jakob Sonnberger
Company: ZIM-ACDH (Zentrum für Informationsmodellierung - Austrian Centre for Digital Humanities)
Stylesheet Information: DataBasket functionalities (managing checkboxes, localStorage etc.)
 */

//on Export-Button click
$('a#exportDatabasket').on("click", function () {
    databasket2csv();
});

//on checkbox change
$('input:checkbox.cb').change(function () {
    //if any entry-checkbox gets checked...
    if ($(this).is(':checked')) {
        //...entry goes to databasket
        toDatabasket(this);
    }
    //if any entry-checkbox gets UNchecked...
    else {
        //remove entry from localStorage
        removeFromLocalStorage(this);
        //uncheck Head Checkbox
        $("input:checkbox.cbHead").prop('checked', false);
    }
});

//on head-checkbox change (query-results)
$('input:checkbox.cbHead').change(function () {
    //if the head-checkbox gets checked...
    if ($(this).is(':checked')) {
        //...entry goes to databasket
        $("input:checkbox.cb:not(:checked)").click();
    }
    //if any entry-checkbox gets UNchecked...
    else {
        //remove entry from localStorage
        $("input:checkbox.cb:checked").click();
    }
});

/*sorting Databasket*/
$(document).on("click", 'th span.oi-elevator', function () {
    sortDatabasket(this.id);
    $('th span.sort').attr('class', 'sort oi oi-elevator');
    $(this).attr('class', 'sort oi oi-caret-top');
});

$(document).on("click", 'th span.oi-caret-top', function () {
    sortDatabasket(this.id, 'reverse');
    // commit 'reverse' for descending sortation
    $('th span.sort').attr('class', 'sort oi oi-elevator');
    $(this).attr('class', 'sort oi oi-caret-bottom');
});

$(document).on("click", 'th span.oi-caret-bottom', function () {
    sortDatabasket(this.id);
    $('th span.sort').attr('class', 'sort oi oi-elevator');
    $(this).attr('class', 'sort oi oi-caret-top');
});

$('a#clearDatabasket').click(function () {
    //clear table body
    $('article#dataBasket table tbody').empty();
    localStorage.clear();
    //update Databasket Counter
    count_databasket();
});

$(document).on('click', 'span#deleteEntry', function () {
    //remove entry from localStorage
    removeFromLocalStorage(this);
    //remove table row
    $(this).closest($('tr')).remove();
});

////////////////////////////////////////////////////////////////////////FUNCTIONS////////////////////////////////////////////////////////////////////////

/////////////////////////
/*adding to databasket*/

function toDatabasket(trigger) {
    var tr = $(trigger).closest('tr');
    
    var entry = tr.attr('xml:id');
    var date = tr.find('td#date').text().trim();
    var surname = tr.find('td#name').text().trim();
    var name = tr.find('td#surname').text().trim();
    var address = tr.find('td#address').text().trim();
    var parish = tr.find('td#parish').text().trim();
    var status = tr.find('td#status').text().trim();
    var gender = tr.find('td#gender').text().trim();
    var religion = tr.find('td#religion').text().trim();
    var marginalia = tr.find('td#marginalia').text().trim();
    var del = tr.find('td#del').text().trim();
    var note = tr.find('td#note').text().trim();
    
    var newItem = {
        'entry': entry,
        'date': date,
        'surname': surname,
        'name': name,
        'address': address,
        'parish': parish,
        'status': status,
        'gender': gender,
        'religion': religion,
        'marginalia': marginalia,
        'del': del,
        'note': note
    };
    //get entry from localStorage...
    var basketArray = JSON.parse(localStorage.getItem('ooaDatabasket')) ||[];
    //...add new entry...
    basketArray.push(newItem);
    //update Databasket Counter
    $('span#daba_length').html(basketArray.length);
    //and commit back to localStorage
    localStorage.setItem('ooaDatabasket', JSON.stringify(basketArray));
};

/////////////////////////////////////////////////
/*removes entry from localstorage*/

function removeFromLocalStorage(trigger) {
    var basketArray = JSON.parse(localStorage.getItem('ooaDatabasket')) ||[];
    var thisEntry = $(trigger).closest($('tr')).attr('xml:id');
    for (var outerCount = 0;
    outerCount < basketArray.length;
    outerCount++) {
        if (basketArray[outerCount].entry == thisEntry) {
            //remove entry from selection
            basketArray.splice(outerCount, 1);
        }
    }
    //update Databasket Counter
    $('span#daba_length').html(basketArray.length);
    //and commit back to localStorage
    localStorage.setItem('ooaDatabasket', JSON.stringify(basketArray));
};


/////////////////////////////
/*creating databasket table*/

function showDatabasket() {
    //clear table body
    $('article#dataBasket table tbody').empty();
    var basketArray = JSON.parse(localStorage.getItem('ooaDatabasket')) ||[];
    for (var outerCount = 0;
    outerCount < basketArray.length;
    outerCount++) {
        var n = basketArray[outerCount];
        $('article#dataBasket table tbody').append('<tr xml:id="' + n.entry + '"><td><a href="/o:ooa.' + n.entry + '">' + n.entry + '</a></td><td>' +
        n.date + '</td><td>' + n.surname + '</td><td>' + n.name + '</td><td>' +
        n.address + '</td><td>' + n.parish + '</td><td>' + n.status + '</td><td>' + n.gender + '</td><td>' + n.religion + '</td><td>' + n.marginalia + '</td><td>' + n.del + '</td><td>' + n.note +
        '</td><td id="cb"><span class="oi oi-trash" id="deleteEntry"></span></td></tr>');
    };
};

///////////////////////////////////////////////////
/*checks if entry allready exists in localstorage*/

function is_in_localStorage(trigger) {
    var basketArray = JSON.parse(localStorage.getItem('ooaDatabasket')) ||[];
    for (var outerCount = 0;
    outerCount < basketArray.length;
    outerCount++) {
        if (basketArray[outerCount].entry == $(trigger).closest($('tr')).attr('xml:id')) {
            //return true if entry exists
            return true;
        };
    };
};

//////////////////////////////
/*show number of dbt-entries*/

function count_databasket() {
    var basketArray = JSON.parse(localStorage.getItem('ooaDatabasket')) ||[];
    $('span#daba_length').html(basketArray.length);
};

/////////////////////////
/*sort databasket/////*/

function sortDatabasket(category, direction) {
    var basketArray = JSON.parse(localStorage.getItem('ooaDatabasket')) ||[];
    //re-sort array ascending
    basketArray.sort(function (a, b) {
        var x = ($.isNumeric(a[category]) ? parseInt(a[category]): a[category].toUpperCase().replace(/\s+/g, ""));
        var y = ($.isNumeric(b[category]) ? parseInt(b[category]): b[category].toUpperCase().replace(/\s+/g, ""));
        return ((x < y) ? -1: (x > y) ? 1: 0);
    });
    // commit 'reverse' for descending sortation
    if (direction == 'reverse') basketArray.reverse();
    //commit back to localStorage
    localStorage.setItem('ooaDatabasket', JSON.stringify(basketArray));
    showDatabasket();
};

///////////////////////
/*databasket (local storage) to CSV*/
function databasket2csv() {
    var csv = '"sep=,"\n"entry","date","surname","name","address","parish","status","gender","religion","marginalia","del","note"\n';
    var basketArray = JSON.parse(localStorage.getItem('ooaDatabasket')) ||[];
    for (var outerCount = 0;
    outerCount < basketArray.length;
    outerCount++) {
        for (var outerCount = 0;
        outerCount < basketArray.length;
        outerCount++) {
            var n = basketArray[outerCount];
            csv += '"' + n.entry + '","' + n.date + '","' + n.surname + '","' + n.name + '","' + n.address + '","' + n.parish + '","' + n.status + '","' + n.gender + '","' + n.religion + '","' + n.marginalia + '","' + n.del + '","' + n.note + '"\n';
        };
    };
    //create download link
    $('a#exportDatabasket').attr('href', 'data:text/csv;charset=utf-8,' + encodeURIComponent(csv));
};