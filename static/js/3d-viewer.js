document.addEventListener('DOMContentLoaded', async () => {
    const THREE = await import('three');
    // const THREE = await import('https://cdn.jsdelivr.net/npm/three@0.129.0/build/three.module.js');
    const { OrbitControls } = await import('https://cdn.jsdelivr.net/npm/three@0.121.1/examples/jsm/controls/OrbitControls.js');
    const { GLTFLoader } = await import ('https://cdn.skypack.dev/three@0.129.0/examples/jsm/loaders/GLTFLoader.js');
    const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    camera.position.z = 1.5;

    const scene = new THREE.Scene();
    let model;
    const loader = new GLTFLoader();
    loader.load('/static/models/2_person_statue_scan_medpoly.glb',
        function (gltf) {
            model = gltf.scene;
            model.position.y = -0.7;
            model.rotation.y =1.5
            scene.add(model);
        },
        function (xhr) {},
        function(error) {
        console.error('Error loading model:', error);
        }
    );
    const ambientLight = new THREE.AmbientLight('#ffffff', 1.5);
    scene.add(ambientLight);

    const renderer = new THREE.WebGLRenderer({alpha: true, antialias: true});
    renderer.setPixelRatio(window.devicePixelRatio || 1);
    renderer.setSize(window.innerWidth/2, window.innerHeight/2);
    const sceneBox = document.getElementById('scene-box');
    sceneBox.appendChild(renderer.domElement);
    const directionalLight = new THREE.DirectionalLight('#ffffff', 1);
    directionalLight.position.set(500, 500, 500);
    scene.add(directionalLight);
    const controls = new OrbitControls(camera, renderer.domElement);
    const reRender3D = () => {
        requestAnimationFrame(reRender3D);
        renderer.render(scene, camera);
        model.rotation.y += 0.01;
    };
    reRender3D();
});