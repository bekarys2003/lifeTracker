// static/js/index.js

$(document).ready(function() {
    // Function to get the CSRF token from the cookie
    function getCookie(name) {
        let cookieValue = null;
        if (document.cookie && document.cookie !== '') {
            const cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();
                if (cookie.substring(0, name.length + 1) === (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }

    // Attach a click event to all like buttons
    $('.like-button').on('click', function() {
        const postId = $(this).data('post-id');
        const likeButton = $(this);
        const likeCount = likeButton.find('.like-count');

        // Get the CSRF token
        const csrfToken = getCookie('csrftoken');

        // Send an AJAX request to the like_post view
        $.ajax({
            type: 'POST',
            url: `/like-post/${postId}/`,
            headers: {
                'X-CSRFToken': csrfToken
            },
            success: function(response) {
                // Update the like count
                likeCount.text(response.likes_count);

                // Toggle the liked class
                likeButton.toggleClass('liked');
            },
            error: function(response) {
                console.error(response);
                alert('Error: Could not like post.');
            }
        });
    });
});