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

    // Function to update the like button's appearance
    function updateLikeButton(likeButton, isLiked) {
        if (isLiked) {
            likeButton.css('color', '#007bff'); // Blue for liked
            likeButton.addClass('liked');
        } else {
            likeButton.css('color', '#ccc'); // Gray for unliked
            likeButton.removeClass('liked');
        }
    }

    // Set the initial state of all like buttons
    $('.like-button').each(function() {
        const likeButton = $(this);
        const isLiked = likeButton.hasClass('liked');
        updateLikeButton(likeButton, isLiked);
    });

    // Attach a click event to all like buttons
    $('.like-button').on('click', function() {
        const likeButton = $(this);
        const postId = likeButton.data('post-id');
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

                // Update the button's appearance based on the response
                const isLiked = likeButton.hasClass('liked');
                updateLikeButton(likeButton, !isLiked); // Toggle the like state
            },
            error: function(response) {
                console.error(response);
                alert('Error: Could not like post.');
            }
        });
    });
});