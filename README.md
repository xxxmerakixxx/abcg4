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

É possível rotacionar o Pokémon com o botão esquerdo do mouse e o botão scroll do mouse funciona como zoom, onde é possível visualizar o efeito de sombreamento por causa dos shaders e sua iluminação de acordo com o movimento realizado. Além disso, no canto inferior direito há um seletor onde o usuário pode selecionar os Pokémons para visualização. Todos os pokémons possuem iluminação.

## Alterações realizadas

  - Inclusão de um background 3d 
    
 ```python
   m_cubeTexture = abcg::loadOpenGLCubemap({path + "posx.jpg", path + "negx.jpg", path + "posy.jpg", path + "negy.jpg", path + "posz.jpg", path + "negz.jpg"})
 ```

  - No window.cpp
 ```python
void Window::onEvent(SDL_Event const &event) {
  glm::ivec2 mousePosition;
  SDL_GetMouseState(&mousePosition.x, &mousePosition.y);
 ```





