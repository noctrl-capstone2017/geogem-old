$( document ).ready(function() {
	$('.noteBtn').on('click', function () {
		$.confirm({
			title: 'Notes:',
			content: '' +
			'<form action="" class="formName">' +
			'<div class="form-group">' +
			'<label>Enter your session notes here</label>' +
			'<input type="textarea" placeholder="simple note" class="quickNote form-control" required />' +
			'</div>' +
			'</form>',
			buttons: {
				formSubmit: {
					text: 'Submit',
					btnClass: 'btn-blue',
					action: function () {
						var note = this.$content.find('.quickNote').val();
						if (!note) {
							$.alert('provide a valid note');
							return false;
						}
						/*
						$.ajax({
						    //TO BE IMPLEMENTED
                //url:'/session_events',
                type:'POST',
                beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                dataType:'json',
                data:{
                     note_content: note,
                     session_id: getSessionId()
                },
                success:function(data){
                    alert("success");
                },
                error:function(data){
                    alert("fail");
                }
            });*/
					}
				},
				cancel: function () {
					//close
				},
			},
			onContentReady: function () {
				// you can bind to the form
				var jc = this;
				this.$content.find('form').on('submit', function (e) { // if the user submits the form by pressing enter in the field.
					e.preventDefault();
					jc.$$formSubmit.trigger('click'); // reference the button and click it
				});
			}
		});
	});
});