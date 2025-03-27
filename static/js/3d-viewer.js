document.addEventListener('DOMContentLoaded', async () => {
    const THREE = await import('https://cdn.jsdelivr.net/npm/three@0.129.0/build/three.module.js');
    const { OrbitControls } = await import('https://cdn.jsdelivr.net/npm/three@0.121.1/examples/jsm/controls/OrbitControls.js');
    const { GLTFLoader } = await import('https://cdn.skypack.dev/three@0.129.0/examples/jsm/loaders/GLTFLoader.js');

    const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    camera.position.z = 1.2;

    const scene = new THREE.Scene();
    const loader = new GLTFLoader();
    let currentModel = null;

    try {
        // Fetch only the active model for the current user
        const response = await fetch('/tracking/api/models/');
        if (!response.ok) throw new Error(`HTTP error! Status: ${response.status}`);

        const models = await response.json();

        // Load the active model if available
        if (models.length > 0) {
            loader.load(models[0].file_path, (gltf) => {
                currentModel = gltf.scene;
                currentModel.position.y = -0.7;
                currentModel.rotation.y = 1.5;
                scene.add(currentModel);
            }, undefined, (error) => {
                console.error('Error loading model:', error);
            });
        } else {
            console.log("No active model selected for this profile");
        }

    } catch (error) {
        console.error('Error fetching models:', error);
    }

    // ... rest of your existing scene setup code ...
    const ambientLight = new THREE.AmbientLight('#ffffff', 1.5);
    scene.add(ambientLight);

    const renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true });
    renderer.setPixelRatio(window.devicePixelRatio || 1);
    renderer.setSize(window.innerWidth / 2, window.innerHeight / 2);
    document.getElementById('scene-box').appendChild(renderer.domElement);

    const directionalLight = new THREE.DirectionalLight('#ffffff', 1);
    directionalLight.position.set(500, 500, 500);
    scene.add(directionalLight);

    const controls = new OrbitControls(camera, renderer.domElement);

    const reRender3D = () => {
        requestAnimationFrame(reRender3D);
        renderer.render(scene, camera);
        if (currentModel) currentModel.rotation.y += 0.01;
    };
    reRender3D();
});