document.addEventListener('DOMContentLoaded', async () => {
    const THREE = await import('https://cdn.jsdelivr.net/npm/three@0.129.0/build/three.module.js');
    const { OrbitControls } = await import('https://cdn.jsdelivr.net/npm/three@0.121.1/examples/jsm/controls/OrbitControls.js');
    const { GLTFLoader } = await import('https://cdn.skypack.dev/three@0.129.0/examples/jsm/loaders/GLTFLoader.js');

    // Scene setup
    const scene = new THREE.Scene();
    const renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true });
    renderer.setPixelRatio(window.devicePixelRatio || 1);
    renderer.setSize(window.innerWidth / 2, window.innerHeight / 2);
    document.getElementById('scene-box').appendChild(renderer.domElement);

    // Camera setup
    const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    camera.position.z = 3;

    // Lighting
    const ambientLight = new THREE.AmbientLight('#ffffff', 1.5);
    scene.add(ambientLight);
    const directionalLight = new THREE.DirectionalLight('#ffffff', 1);
    directionalLight.position.set(500, 500, 500);
    scene.add(directionalLight);

    // Model management
    const loader = new GLTFLoader();
    let controls = null;
    let activeModels = [];

    // Load all active models for current user
    async function loadActiveModels() {
        try {
            const response = await fetch('/tracking/api/active-models/');
            if (!response.ok) throw new Error(`HTTP error! Status: ${response.status}`);

            const modelsData = await response.json();

            // Clear existing models
            activeModels.forEach(model => scene.remove(model));
            activeModels = [];

            // Load new models with positions
            modelsData.forEach((modelData, index) => {
                loader.load(modelData.file_path, (gltf) => {
                    const model = gltf.scene;

                    // Apply model-specific settings
                    model.scale.set(modelData.scale, modelData.scale, modelData.scale);
                    model.position.x = index * 2 - (modelsData.length - 1); // Spread models horizontally
                    model.position.y = -0.7;
                    model.rotation.y = 1.5;

                    scene.add(model);
                    activeModels.push(model);

                    // Initialize controls if not already done
                    if (!controls) {
                        controls = new OrbitControls(camera, renderer.domElement);
                        controls.enableDamping = true;
                        controls.dampingFactor = 0.05;
                    }

                }, undefined, (error) => {
                    console.error('Error loading model:', modelData.name, error);
                });
            });

        } catch (error) {
            console.error('Error loading active models:', error);
        }
    }
    const initialRotationZ = camera.rotation.z;
    // Animation loop
    function animate() {
        requestAnimationFrame(animate);
        if (controls) controls.update();

        camera.rotation.z += 0.02;  // Roll
        if (controls) {
            controls.autoRotate = true;  // Orbit around model
            controls.autoRotateSpeed = 0.5;
            controls.update();
        }
        renderer.render(scene, camera);
    }
    animate();

    // Initial load
    loadActiveModels();
});