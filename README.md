# abcg3

# Pokémon
## Integrantes:
Isabela Lima Sigaki RA: 11201810447
Júlia Oliveira Costa RA: 11201810014


![build workflow](https://github.com/hbatagelo/abcg/actions/workflows/build.yml/badge.svg)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/hbatagelo/abcg)](https://github.com/hbatagelo/abcg/releases/latest)

Desenvolvimento do Projeto Aquário como atividade para a disciplina [MCTA008-17 Computer Graphics](http://professor.ufabc.edu.br/~harlen.batagelo/cg/) na [UFABC](https://www.ufabc.edu.br/).

[Documentation](https://hbatagelo.github.io/abcg/abcg/doc/html/) | [Release notes](CHANGELOG.md)

O projeto foi criado utilizando o framework ABCg que facilita o desenvolvimento de aplicações baseadas em 
[OpenGL](https://www.opengl.org), [OpenGL ES](https://www.khronos.org), [WebGL](https://www.khronos.org/webgl/), e [Vulkan](https://www.vulkan.org). 

***

## Sobre o projeto

O objetivo consiste em desenvolver uma aplicação que mostre gráficos 3D com primitivas do OpenGL, como na atividade 2, mas que utilize shaders de iluminação e texturização.

O projeto é uma aplicação usando moldes 3D da animação Pokémon. Foram utilizados como base os projetos "viewer1" que apresenta uma implementação de um visualizador de modelos geométricos 3D que permite a interação através do trackball virtual e o "starfields" que é um campo estelar em perspectiva. O projeto apresenta um Pikachu como objeto principal e no fundo temos um "starfield" de pequenos pikachus. Além disso, o projeto apresenta textura e iluminação. O background foi feito a partir de um mapa 3d e os pokémons apresentam iluminação em sua cabeça que muda de acordo com a intensidade da luz.

## Controles

É possível rotacionar o Pokémon com o botão esquerdo do mouse e o botão scroll do mouse funciona como zoom, onde é possível visualizar o efeito de sombreamento por causa dos shaders e sua iluminação de acordo com o movimento realizado. Além disso, no canto inferior direito há um seletor onde o usuário pode selecionar os Pokémons para visualização. Todos os pokémons possuem iluminação e alguns possuem textura.

## Alterações realizadas

  - Inclusão de um background 3d para dar a impressão de um fundo contínuo utilizando um mapa 3d
    
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

- Adição de textura e iluminação para os objetos principais por meio das variáveis uniformes conjuntamente aos vetores normais, tangentes e bitangentes, alinhando os vetores u, v, conforme explicado em aula. Foi aplicado a textura e iluminação no objeto principal (Pikachu e Eeve), nos demais foi aplicado apenas iluminação.
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

