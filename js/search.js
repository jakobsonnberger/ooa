/*Project: Oath of Allegiance
Author: Jakob Sonnberger
Company: ZIM-ACDH (Zentrum für Informationsmodellierung - Austrian Centre for Digital Humanities)
Stylesheet Information: Search functionalities (full-text search, advanced search, byDocument, autocomplete)
 */

/*full-text search request*/
$('#searchFullForm').on('submit', function () {
    //avoid emty search
    if ($('#searchFullInput').val() != '') {
        searchFull();
        return false;
    } else {
        console.log('no input!!!')
        return false;
    }
});

/*advanced search request*/
$('#searchByForm').on('submit', function () {
    searchBy();
    return false;
});
////////////////////////////////functions///////////////////////////////////////////////////////////////////////////

/*full-text search function*/
function searchFull() {
    var actionUrl = encodeURI($('#searchFullForm').attr('action') + '?params=$1|' + $('#searchFullInput').val());
    window.location.href = actionUrl.trim();
};

/*advanced search function*/
function searchBy() {
    var params = '';
    //name
    var name = $('input#inputName').val() || '';
    if (name != '') {
        name = '?s t:persName ?name . ?name bds:search "' + name + '" ; bds:matchAllTerms true .'
    }
    //gender
    var gender = $('select#selectGender').val() || '';
    if (gender != '') {
        gender = '?s t:sex "' + gender + '" .'
    }
    //religion
    var religion = $('select#selectReligion').val() || '';
    if (religion != '') {
        religion = '?s t:faith "' + religion + '" .'
    }
    //occupation
    var occupation = $('input#inputOccupation').val() || '';
    if (occupation != '') {
        occupation = '?s ooa:occupation/skos:prefLabel ?occupation . ?occupation bds:search "' + occupation + '" ; bds:matchAllTerms true .'
    }
    //parish
    var parish = $('input#inputParish').val() || '';
    if (parish != '') {
        parish = '?s ooa:isLocatedInParish ?parish . ?parish bds:search "' + parish + '" ; bds:matchAllTerms true .'
    }
    //date
    var date = $('select#selectDate').val() || '';
    if (date != '') {
        date = '?oath bk:when "' + date + '" .'
    }
    params = name + gender + religion + occupation + parish + date;
    //avoid emty search
    if (params != '') {
        var actionUrl = encodeURI($('#searchByForm').attr('action') + '?params=$1|' + params);
        window.location.href = actionUrl;
    } else {
        console.log('no input!!!');
    }
};