// 3D battlefield for Legends of Runeterra clone
class Battlefield {
  constructor(containerId) {
    this.container = document.getElementById(containerId);
    this.scene = new THREE.Scene();
    this.camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    this.renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
    
    this.init();
    this.createTable();
    this.addLights();
    this.animate();
    
    // Handle window resize
    window.addEventListener('resize', this.onWindowResize.bind(this));
  }
  
  init() {
    // Set renderer properties
    this.renderer.setSize(this.container.clientWidth, this.container.clientHeight);
    this.renderer.setPixelRatio(window.devicePixelRatio);
    this.renderer.shadowMap.enabled = true;
    this.container.appendChild(this.renderer.domElement);
    
    // Set camera position
    this.camera.position.set(0, 10, 10);
    this.camera.lookAt(0, 0, 0);
    
    // Create camera controls
    this.controls = new THREE.OrbitControls(this.camera, this.renderer.domElement);
    this.controls.enableDamping = true;
    this.controls.dampingFactor = 0.25;
    this.controls.screenSpacePanning = false;
    this.controls.maxPolarAngle = Math.PI / 2.2;
    this.controls.minDistance = 5;
    this.controls.maxDistance = 20;
  }
  
  createTable() {
    // Create the game table
    const tableGeometry = new THREE.BoxGeometry(20, 0.5, 10);
    const tableMaterial = new THREE.MeshStandardMaterial({ 
      color: 0x3a7d44,
      roughness: 0.8,
      metalness: 0.2
    });
    
    this.table = new THREE.Mesh(tableGeometry, tableMaterial);
    this.table.position.y = -0.25;
    this.table.receiveShadow = true;
    this.scene.add(this.table);
    
    // Add a subtle outline to the table
    const edges = new THREE.EdgesGeometry(tableGeometry);
    const lineMaterial = new THREE.LineBasicMaterial({ color: 0x2d623a });
    const outline = new THREE.LineSegments(edges, lineMaterial);
    outline.position.copy(this.table.position);
    this.scene.add(outline);
    
    // Create player and bot territories
    const playerAreaGeometry = new THREE.PlaneGeometry(18, 4);
    const playerAreaMaterial = new THREE.MeshStandardMaterial({ 
      color: 0x4682b4,
      roughness: 0.7,
      transparent: true,
      opacity: 0.3
    });
    
    const botAreaMaterial = new THREE.MeshStandardMaterial({ 
      color: 0xb22222,
      roughness: 0.7,
      transparent: true,
      opacity: 0.3
    });
    
    this.playerArea = new THREE.Mesh(playerAreaGeometry, playerAreaMaterial);
    this.playerArea.rotation.x = -Math.PI / 2;
    this.playerArea.position.set(0, 0.01, 2.5);
    this.playerArea.receiveShadow = true;
    this.scene.add(this.playerArea);
    
    this.botArea = new THREE.Mesh(playerAreaGeometry, botAreaMaterial);
    this.botArea.rotation.x = -Math.PI / 2;
    this.botArea.position.set(0, 0.01, -2.5);
    this.botArea.receiveShadow = true;
    this.scene.add(this.botArea);
    
    // Add dividing line
    const dividerGeometry = new THREE.BoxGeometry(18, 0.1, 0.1);
    const dividerMaterial = new THREE.MeshStandardMaterial({ color: 0xffffff });
    const divider = new THREE.Mesh(dividerGeometry, dividerMaterial);
    divider.position.y = 0.05;
    this.scene.add(divider);
  }
  
  addLights() {
    // Ambient light
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.4);
    this.scene.add(ambientLight);
    
    // Directional light (sun)
    const directionalLight = new THREE.DirectionalLight(0xffffff, 0.6);
    directionalLight.position.set(10, 20, 10);
    directionalLight.castShadow = true;
    
    // Configure shadow properties
    directionalLight.shadow.mapSize.width = 2048;
    directionalLight.shadow.mapSize.height = 2048;
    directionalLight.shadow.camera.left = -15;
    directionalLight.shadow.camera.right = 15;
    directionalLight.shadow.camera.top = 15;
    directionalLight.shadow.camera.bottom = -15;
    
    this.scene.add(directionalLight);
    
    // Add point lights for dramatic effect
    const pointLight1 = new THREE.PointLight(0x3677ac, 0.5, 20);
    pointLight1.position.set(0, 5, 5);
    this.scene.add(pointLight1);
    
    const pointLight2 = new THREE.PointLight(0xac3636, 0.5, 20);
    pointLight2.position.set(0, 5, -5);
    this.scene.add(pointLight2);
  }
  
  onWindowResize() {
    this.camera.aspect = this.container.clientWidth / this.container.clientHeight;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(this.container.clientWidth, this.container.clientHeight);
  }
  
  animate() {
    requestAnimationFrame(this.animate.bind(this));
    this.controls.update();
    this.renderer.render(this.scene, this.camera);
  }
  
  // Method to create 3D card representation
  createCardMesh(card, position) {
    // Card geometry
    const cardGeometry = new THREE.BoxGeometry(1.5, 0.1, 2);
    
    // Create texture from card data
    const canvas = document.createElement('canvas');
    canvas.width = 512;
    canvas.height = 512;
    const context = canvas.getContext('2d');
    
    // Fill background
    context.fillStyle = '#4a4a4a';
    context.fillRect(0, 0, 512, 512);
    
    // Add card name
    context.fillStyle = 'white';
    context.font = 'bold 32px Arial';
    context.textAlign = 'center';
    context.fillText(card.name.substring(0, 20), 256, 50);
    
    // Add stats
    context.fillStyle = '#ff4136';
    context.fillRect(50, 420, 100, 50);
    context.fillStyle = '#0074d9';
    context.fillRect(362, 420, 100, 50);
    
    context.fillStyle = 'white';
    context.font = 'bold 40px Arial';
    context.fillText(card.attack, 100, 455);
    context.fillText(card.defense, 412, 455);
    
    // Create card texture
    const texture = new THREE.CanvasTexture(canvas);
    
    // Card material
    const materials = [
      new THREE.MeshStandardMaterial({ color: 0x333333 }), // Right side
      new THREE.MeshStandardMaterial({ color: 0x333333 }), // Left side
      new THREE.MeshStandardMaterial({ color: 0x333333 }), // Top side
      new THREE.MeshStandardMaterial({ color: 0x333333 }), // Bottom side
      new THREE.MeshStandardMaterial({ map: texture }), // Front side
      new THREE.MeshStandardMaterial({ color: 0x999999 }) // Back side
    ];
    
    // Create mesh
    const cardMesh = new THREE.Mesh(cardGeometry, materials);
    cardMesh.position.copy(position);
    cardMesh.rotation.x = -Math.PI / 2;
    cardMesh.castShadow = true;
    cardMesh.receiveShadow = true;
    
    // Add to scene
    this.scene.add(cardMesh);
    
    return cardMesh;
  }
  
  // Update the battlefield with game state
  updateBattlefield(gameState) {
    // Remove existing cards
    this.scene.children.forEach(child => {
      if (child.userData.isCard) {
        this.scene.remove(child);
      }
    });
    
    // Player cards
    gameState.player.board.forEach((card, index) => {
      const offset = (index - (gameState.player.board.length - 1) / 2) * 2;
      const position = new THREE.Vector3(offset, 0.05, 2.5);
      const cardMesh = this.createCardMesh(card, position);
      cardMesh.userData.isCard = true;
    });
    
    // Bot cards
    gameState.bot.board.forEach((card, index) => {
      const offset = (index - (gameState.bot.board.length - 1) / 2) * 2;
      const position = new THREE.Vector3(offset, 0.05, -2.5);
      const cardMesh = this.createCardMesh(card, position);
      cardMesh.userData.isCard = true;
      cardMesh.rotation.z = Math.PI; // Flip to face the player
    });
  }
}

// Export the Battlefield class
export default Battlefield; 