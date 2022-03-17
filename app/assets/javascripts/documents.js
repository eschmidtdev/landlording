$(document).ready(function () {

    // Defining Events

    (function ($) {
        $.fn.ShowTextField = function (id) {
            // Calling ShowField Function
            ShowField(id);
        };
    })(jQuery);

    (function ($) {
        $.fn.UpdateFromIcon = function (id) {
            const TextField = $('#TextField' + id);
            const DocumentID = TextField.attr('data-id');
            const Name = TextField.val();

            UpdateDocumentName(DocumentID, Name);
        };
    })(jQuery);


    // Defining Functions

    function ShowField(id) {
        $('.document_name' + id).addClass('display-none');
        $('#DocumentNameField' + id).removeClass('display-none');
    }

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
