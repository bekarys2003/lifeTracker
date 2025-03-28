document.addEventListener('DOMContentLoaded', async () => {
    const THREE = await import('https://cdn.jsdelivr.net/npm/three@0.129.0/build/three.module.js');
    const { OrbitControls } = await import('https://cdn.jsdelivr.net/npm/three@0.121.1/examples/jsm/controls/OrbitControls.js');
    const { GLTFLoader } = await import('https://cdn.skypack.dev/three@0.129.0/examples/jsm/loaders/GLTFLoader.js');

    // Initialize Three.js components in proper order
    const scene = new THREE.Scene();

    // Set up renderer first (needed for OrbitControls)
    const renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true });
    renderer.setPixelRatio(window.devicePixelRatio || 1);
    renderer.setSize(window.innerWidth / 2, window.innerHeight / 2);
    document.getElementById('scene-box').appendChild(renderer.domElement);

    // Then set up camera
    const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    let currentCameraZ = 2; // Default value
    camera.position.z = currentCameraZ;

    // Lighting
    const ambientLight = new THREE.AmbientLight('#ffffff', 1.5);
    scene.add(ambientLight);

    const directionalLight = new THREE.DirectionalLight('#ffffff', 1);
    directionalLight.position.set(500, 500, 500);
    scene.add(directionalLight);

    // Model loading
    const loader = new GLTFLoader();
    let currentModel = null;
    let controls = null;

    try {
        const response = await fetch('/tracking/api/models/');
        if (!response.ok) throw new Error(`HTTP error! Status: ${response.status}`);

        const models = await response.json();

        if (models.length > 0) {
            // Set camera position from model data
            currentCameraZ = models[0].camera_position_z || 1.2;
            camera.position.z = currentCameraZ;

            loader.load(models[0].file_path, (gltf) => {

                currentModel = gltf.scene;
                currentModel.scale.set(0.01, 0.01, 0.01);
                currentModel.position.y = -0.7;
                currentModel.rotation.y = 1.5;
                scene.add(currentModel);

                // Initialize OrbitControls after model loads
                controls = new OrbitControls(camera, renderer.domElement);
                controls.enableDamping = true; // Add smooth damping
                controls.dampingFactor = 0.05;

                // Update camera position in animation loop
                function animate() {
                    requestAnimationFrame(animate);

                    // Maintain camera Z position
                    camera.position.z = currentCameraZ;

                    // Required if controls.enableDamping is true
                    if (controls) controls.update();

                    if (currentModel) currentModel.rotation.y += 0.01;
                    renderer.render(scene, camera);
                }
                animate();

            }, undefined, (error) => {
                console.error('Error loading model:', error);
            });
        } else {
            console.log("No active model selected for this profile");
            // Simple animation loop if no model
            function animate() {
                requestAnimationFrame(animate);
                renderer.render(scene, camera);
            }
            animate();
        }

    } catch (error) {
        console.error('Error fetching models:', error);
        // Simple animation loop on error
        function animate() {
            requestAnimationFrame(animate);
            renderer.render(scene, camera);
        }
        animate();
    }
});