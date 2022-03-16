$(document).ready(function () {

    $('#EditDocument').on('click', function () {
        // Calling ShowField Function
        ShowField();
    });

    $('.icon_style').on('click', function () {
        const TextField = $('#TextField');
        const DocumentID = TextField.attr('data-id');
        const Name = TextField.val();
        // Calling UpdateDocumentName Function
        UpdateDocumentName(DocumentID, Name);
    });

    // ShowField Function
    function ShowField() {
        $('.dm_table_name').addClass('display-none');
        $('#DocumentNameField').removeClass('display-none');
    }

    // UpdateDocumentName Function
    function UpdateDocumentName(id, name) {
        $.ajax({
            type: 'PUT',
            url: '/documents/' + id,
            data: {document: {name: name}},
            success: function (response) {
                if (response.status === 200) {
                    location.reload();
                }
            }
        });
    }

});
