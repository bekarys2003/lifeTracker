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
            url: `/posts/${postId}/like/`,  // Ensure this matches your Django URL pattern
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


function toggleOptions(postId) {
    const modal = document.getElementById(`post-options-modal-${postId}`);
    if (modal.style.display === "block") {
        modal.style.display = "none";
    } else {
        modal.style.display = "block";
    }
}

window.onclick = function(event) {
    const modals = document.querySelectorAll('.post-options-modal');
    modals.forEach(modal => {
        if (event.target === document.getElementById(`post`)) {
            modal.style.display = "none";
        }
    });
};



// --------Shapes

// // import { OrbitControls } from 'https://cdn.jsdelivr.net/npm/three@0.146.0/examples/jsm/controls/OrbitControls.js';
// document.addEventListener('DOMContentLoaded', async () => {
//     const { OrbitControls } = await import('https://cdn.jsdelivr.net/npm/three@0.121.1/examples/jsm/controls/OrbitControls.js');
//     const scene = new THREE.Scene();
//     const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
//     camera.position.z = 5;

//     const renderer = new THREE.WebGLRenderer();
//     renderer.setSize(window.innerWidth, window.innerHeight);
//     const sceneBox = document.getElementById('scene-box');
//     sceneBox.appendChild(renderer.domElement);

//     const planeGeometry = new THREE.PlaneGeometry(10, 10);
//     planeGeometry.rotateX(30);
//     const planeMaterial = new THREE.MeshBasicMaterial({ color: 0x0000ff });
//     const plane = new THREE.Mesh(planeGeometry, planeMaterial);
//     scene.add(plane);

//     const fogColor = "#000";
//     const fogNear = 2;
//     const fogFar = 8;
//     scene.fog = new THREE.Fog(fogColor, fogNear, fogFar);
//     const threeJsShapes = []

//     for (const el of shapes) {
//         const {type, color} = el;
//         // console.log(type, color);
//         let geometry;
//         switch(type) {
//             case 1:
//                 geometry = new THREE.SphereGeometry(1, 50, 50);
//                 break;
//             case 2:
//                 geometry = new THREE.BoxGeometry(1, 1, 1);
//             default:
//                 const radiusTop = Math.random() * 0.5 + 0.1;
//                 const radiusBottom = Math.random() * 0.5 + 0.1;
//                 const height = Math.random() * 2 + 1;
//                 const radialSegments = 32;
//                 geometry = new THREE.CylinderGeometry(radiusTop, radiusBottom, height, radialSegments);
//                 break;
//         }
//         const material = new THREE.MeshPhongMaterial({color : color})
//         const shape = new THREE.Mesh(geometry, material)
//         shape.position.x = (Math.random() - 0.5) * 5;
//         shape.position.y = (Math.random() * 2 + 1);
//         shape.position.z = (Math.random() - 0.5) * 5;
//         scene.add(shape);
//         threeJsShapes.push(shape);
//     }

//     const ambientLight = new THREE.AmbientLight('#ffffff', 1.5);
//     scene.add(ambientLight);

//     const directionalLight = new THREE.DirectionalLight('#ffffff', 2);
//     directionalLight.position.set(1, 2, 3);
//     scene.add(directionalLight);
//     const controls = new OrbitControls(camera, renderer.domElement);
//     const animate = () => {
//         threeJsShapes.forEach(shape=>{
//             shape.rotation.x += 0.01;
//             shape.rotation.y += 0.01;
//         })
//         renderer.render(scene, camera);
//         requestAnimationFrame(animate);
//     };

//     animate();
// });