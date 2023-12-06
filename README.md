# abcg3

# Pokémon
## Integrantes:
Isabela Lima Sigaki RA: 11201810447
Júlia Oliveira Costa RA: 11201810014


![build workflow](https://github.com/hbatagelo/abcg/actions/workflows/build.yml/badge.svg)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/hbatagelo/abcg)](https://github.com/hbatagelo/abcg/releases/latest)

Desenvolvimento do Projeto Pokémon como atividade para a disciplina [MCTA008-17 Computer Graphics](http://professor.ufabc.edu.br/~harlen.batagelo/cg/) na [UFABC](https://www.ufabc.edu.br/).

[Documentation](https://hbatagelo.github.io/abcg/abcg/doc/html/) | [Release notes](CHANGELOG.md)

O projeto foi criado utilizando o framework ABCg que facilita o desenvolvimento de aplicações baseadas em 
[OpenGL](https://www.opengl.org), [OpenGL ES](https://www.khronos.org), [WebGL](https://www.khronos.org/webgl/), e [Vulkan](https://www.vulkan.org). 

***

## Sobre o projeto

O objetivo consiste em desenvolver uma aplicação que mostre gráficos 3D com primitivas do OpenGL, como na atividade 2, mas que utilize shaders de iluminação e texturização.

O projeto é uma aplicação usando moldes 3D da animação Pokémon. Foram utilizados como base os projetos "viewer1" que apresenta uma implementação de um visualizador de modelos geométricos 3D que permite a interação através do trackball virtual, o "starfields" que é um campo estelar em perspectiva e o "viewer4" que incorpora um shader para modificar as propriedades de reflexão difusa e ambiente do material no modelo de Blinn-Phong, usando texturas. Ele suporta coordenadas de textura definidas nos vértices dos objetos OBJ. Sendo assim, o projeto adota um modelo de iluminação Blinn-Phong que inclui componentes de iluminação ambiental, difusa e especular, proporcionando um realismo aprimorado aos objetos 3D. A texturização é implementada com a aplicação de mapas de texturas e coordenadas UV para mapear imagens em superfícies 3D, criando detalhes e realismo.

O projeto apresenta um Pikachu como objeto principal e no fundo temos um "starfield" de pequenos pikachus. Além disso, o projeto apresenta textura e iluminação. O background foi feito a partir de um mapa 3d e os pokémons apresentam iluminação em sua cabeça que muda de acordo com a intensidade da luz.

## Controles

É possível rotacionar o Pokémon com o botão esquerdo do mouse e o botão scroll do mouse funciona como zoom, onde é possível visualizar o efeito de sombreamento por causa dos shaders e sua iluminação de acordo com o movimento realizado. Além disso, no canto inferior direito há um seletor onde o usuário pode selecionar os Pokémons para visualização. Todos os pokémons possuem iluminação e textura. 

Com o botão direito do mouse é possível movimentar o fundo 3D. Conforme o fundo é movimentado, a iluminação do Pokémon também é alterada considerando a posição da fonte de luz.

## Alterações realizadas

  - Inclusão de um background 3Dpara dar a impressão de um fundo contínuo utilizando um mapa 3D:

**Alteração no window.cpp:**

 ```python
void Window::initializeSkybox() {
  auto const assetsPath{abcg::Application::getAssetsPath()};
  auto const path{assetsPath + "shaders/" + m_skyShaderName};
  auto const path1{path + ".vert"};
  auto const path2{path + ".frag"};
  m_skyProgram = abcg::createOpenGLProgram(
        {{.source = path + ".vert", .stage = abcg::ShaderStage::Vertex},
         {.source = path + ".frag", .stage = abcg::ShaderStage::Fragment}});
  // source = path + ".frag"

  glGenBuffers(1, &m_skyVBO);
  glBindBuffer(GL_ARRAY_BUFFER, m_skyVBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(m_skyPositions), m_skyPositions.data(),
               GL_STATIC_DRAW);
  glBindBuffer(GL_ARRAY_BUFFER, 0);

  GLint positionAttribute{glGetAttribLocation(m_skyProgram, "inPosition")};

  glGenVertexArrays(1, &m_skyVAO);

  glBindVertexArray(m_skyVAO);

  glBindBuffer(GL_ARRAY_BUFFER, m_skyVBO);
  glEnableVertexAttribArray(positionAttribute);
  glVertexAttribPointer(positionAttribute, 3, GL_FLOAT, GL_FALSE, 0, nullptr);
  glBindBuffer(GL_ARRAY_BUFFER, 0);

  glBindVertexArray(0);
}

 ```
**Alterações no model.cpp:**

    
 ```python

  m_model.loadCubeTexture(assetsPath + "maps/cube/");
  ...
  auto basePath1{std::filesystem::path{path}.parent_path().string() + "/posx.jpg"};
  auto basePath2{std::filesystem::path{path}.parent_path().string() + "/negx.jpg"};
  auto basePath3{std::filesystem::path{path}.parent_path().string() + "/posy.jpg"};
  auto basePath4{std::filesystem::path{path}.parent_path().string() + "/negy.jpg"};
  auto basePath5{std::filesystem::path{path}.parent_path().string() + "/posz.jpg"};
  auto basePath6{std::filesystem::path{path}.parent_path().string() + "/negz.jpg"};

  abcg::glDeleteTextures(1, &m_cubeTexture);
  m_cubeTexture = abcg::loadOpenGLCubemap({basePath1,basePath2,basePath3,basePath4,basePath5,basePath6});
 ```

  - Criação dos shaders para o background
 ```python
void main() {
  fragTexCoord = inPosition;

  vec4 P = projMatrix * viewMatrix * vec4(inPosition, 1.0);
  gl_Position = P.xyww;
}
 ```

- Adição de textura e iluminação para os objetos principais por meio das variáveis uniformes conjuntamente aos vetores normais, tangentes e bitangentes, alinhando os vetores u, v, conforme explicado em aula. Foi aplicado a textura e iluminação em todos os objetos.

```python      
      // Vertex normal
      float nx{};
      float ny{};
      float nz{};
      if (index.normal_index >= 0) {
        m_hasNormals = true;
        startIndex = 3 * index.normal_index;
        nx = attrib.normals.at(startIndex + 0);
        ny = attrib.normals.at(startIndex + 1);
        nz = attrib.normals.at(startIndex + 2);
      }

      // Vertex texture coordinates
      float tu{};
      float tv{};
      if (index.texcoord_index >= 0) {
        m_hasTexCoords = true;
        startIndex = 2 * index.texcoord_index;
        tu = attrib.texcoords.at(startIndex + 0);
        tv = attrib.texcoords.at(startIndex + 1);
      }

      Vertex vertex{};
      vertex.position = {vx, vy, vz};
      vertex.normal = {nx, ny, nz};
      vertex.texCoord = {tu, tv};

      ...

      if (!materials.empty()) {
        const auto& mat{materials.at(0)};  // First material
        m_Ka = glm::vec4(mat.ambient[0], mat.ambient[1], mat.ambient[2], 1);
        m_Kd = glm::vec4(mat.diffuse[0], mat.diffuse[1], mat.diffuse[2], 1);
        m_Ks = glm::vec4(mat.specular[0], mat.specular[1], mat.specular[2], 1);
        m_shininess = mat.shininess;
 ```

