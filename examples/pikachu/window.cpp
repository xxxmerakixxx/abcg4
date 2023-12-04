#include "window.hpp"

#include <glm/gtc/random.hpp>
#include <glm/gtx/fast_trigonometry.hpp>
#include <fmt/core.h>
#include <imgui.h>
#include <cppitertools/itertools.hpp>
#include <glm/gtc/matrix_inverse.hpp>

void Window::onEvent(SDL_Event const &event) {
  glm::ivec2 mousePosition;
  SDL_GetMouseState(&mousePosition.x, &mousePosition.y);

  if (event.type == SDL_MOUSEMOTION) {
    m_trackBallModel.mouseMove(mousePosition);
    m_trackBallLight.mouseMove(mousePosition);
  }
  if (event.type == SDL_MOUSEBUTTONDOWN) {
    if (event.button.button == SDL_BUTTON_LEFT) {
      m_trackBallModel.mousePress(mousePosition);
    }
    if (event.button.button == SDL_BUTTON_RIGHT) {
      m_trackBallLight.mousePress(mousePosition);
    }
  }
  if (event.type == SDL_MOUSEBUTTONUP) {
    if (event.button.button == SDL_BUTTON_LEFT) {
      m_trackBallModel.mouseRelease(mousePosition);
    }
    if (event.button.button == SDL_BUTTON_RIGHT) {
      m_trackBallLight.mouseRelease(mousePosition);
    }
  }
  if (event.type == SDL_MOUSEWHEEL) {
    m_zoom += (event.wheel.y > 0 ? -1.0f : 1.0f) / 5.0f;
    m_zoom = glm::clamp(m_zoom, -1.5f, 1.0f);
  }
}

void Window::onCreate() {
  auto const assetsPath{abcg::Application::getAssetsPath()};

  abcg::glClearColor(0, 0, 0, 1);
  abcg::glEnable(GL_DEPTH_TEST);

  // Create programs
  for (auto const &name : m_shaderNames) {
    auto const path{assetsPath + "shaders/" + name};
    auto const program{abcg::createOpenGLProgram(
        {{.source = path + ".vert", .stage = abcg::ShaderStage::Vertex},
         {.source = path + ".frag", .stage = abcg::ShaderStage::Fragment}})};
    m_programs.push_back(program);
  }

  loadModel(assetsPath + "pokemon_PIKACHU.obj");

  // Load cubemap
  m_model.loadCubeTexture(assetsPath + "maps/cube/");

  m_trackBallModel.setAxis(glm::normalize(glm::vec3(-1, 0.1, 0.1)));
  m_trackBallModel.setVelocity(0.001f);

  for (const auto index : iter::range(m_numPokemon)) {
    auto &position{m_pokemonPositions.at(index)};
    auto &rotation{m_pokemonRotations.at(index)};

    randomizePokemon(position, rotation);
  }

  initializeSkybox();
}

void Window::randomizePokemon(glm::vec3 &position, glm::vec3 &rotation) {
  std::uniform_real_distribution<float> distPosXY(-20.0f, 20.0f);
  std::uniform_real_distribution<float> distPosZ(-100.0f, 0.0f);

  position = glm::vec3(distPosXY(m_randomEngine), distPosXY(m_randomEngine),
                       distPosZ(m_randomEngine));

  std::uniform_real_distribution<float> distRotAxis(-1.0f, 1.0f);

  rotation = glm::normalize(glm::vec3(distRotAxis(m_randomEngine),
                                      distRotAxis(m_randomEngine),
                                      distRotAxis(m_randomEngine)));
}

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

void Window::loadModel(std::string_view path) {
  m_model.loadFromFile(path);
  m_model.setupVAO(m_programs.at(m_currentProgramIndex));
  m_trianglesToDraw = m_model.getNumTriangles();

  m_Ka = m_model.getKa();
  m_Kd = m_model.getKd();
  m_Ks = m_model.getKs();
  m_shininess = m_model.getShininess();
}

void Window::onPaint() {
  auto aspect{static_cast<float>(m_viewportWidth) /
              static_cast<float>(m_viewportHeight)};
  
  m_projMatrix = glm::perspective(glm::radians(m_FOV), aspect, 0.01f, 100.0f);
  glDisable(GL_CULL_FACE);
  glFrontFace(GL_CCW);
  m_model.setupVAO(m_programs.at(m_currentProgramIndex));

  onUpdate();

  abcg::glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  glViewport(0, 0, m_viewportWidth, m_viewportHeight);

  // Use currently selected program
  auto const program{m_programs.at(m_currentProgramIndex)};
  abcg::glUseProgram(program);

  // Get location of uniform variables
  GLint viewMatrixLoc{abcg::glGetUniformLocation(program, "viewMatrix")};
  GLint projMatrixLoc{abcg::glGetUniformLocation(program, "projMatrix")};
  GLint modelMatrixLoc{abcg::glGetUniformLocation(program, "modelMatrix")};
  GLint normalMatrixLoc{abcg::glGetUniformLocation(program, "normalMatrix")};
  GLint lightDirLoc{abcg::glGetUniformLocation(program, "lightDirWorldSpace")};
  GLint shininessLoc{abcg::glGetUniformLocation(program, "shininess")};
  GLint IaLoc{abcg::glGetUniformLocation(program, "Ia")};
  GLint IdLoc{abcg::glGetUniformLocation(program, "Id")};
  GLint IsLoc{abcg::glGetUniformLocation(program, "Is")};
  GLint KaLoc{abcg::glGetUniformLocation(program, "Ka")};
  GLint KdLoc{abcg::glGetUniformLocation(program, "Kd")};
  GLint KsLoc{abcg::glGetUniformLocation(program, "Ks")};
  GLint diffuseTexLoc{abcg::glGetUniformLocation(program, "diffuseTex")};
  GLint normalTexLoc{abcg::glGetUniformLocation(program, "normalTex")};
  GLint cubeTexLoc{abcg::glGetUniformLocation(program, "cubeTex")};
  GLint mappingModeLoc{abcg::glGetUniformLocation(program, "mappingMode")};
  GLint texMatrixLoc{abcg::glGetUniformLocation(program, "texMatrix")};
  // GLint colorLoc{abcg::glGetUniformLocation(program, "color")};

  // Set uniform variables that have the same value for every model
  abcg::glUniformMatrix4fv(viewMatrixLoc, 1, GL_FALSE, &m_viewMatrix[0][0]);
  abcg::glUniformMatrix4fv(projMatrixLoc, 1, GL_FALSE, &m_projMatrix[0][0]);
  abcg::glUniform1i(diffuseTexLoc, 0);
  abcg::glUniform1i(normalTexLoc, 1);
  abcg::glUniform1i(cubeTexLoc, 2);
  abcg::glUniform1i(mappingModeLoc, m_mappingMode);

  glm::mat3 texMatrix{m_trackBallLight.getRotation()};
  abcg::glUniformMatrix3fv(texMatrixLoc, 1, GL_TRUE, &texMatrix[0][0]);

  auto const lightDirRotated{m_trackBallLight.getRotation() * m_lightDir};
  abcg::glUniform4fv(lightDirLoc, 1, &lightDirRotated.x);
  abcg::glUniform4fv(IaLoc, 1, &m_Ia.x);
  abcg::glUniform4fv(IdLoc, 1, &m_Id.x);
  abcg::glUniform4fv(IsLoc, 1, &m_Is.x);

  // Set uniform variables for the current model
  abcg::glUniformMatrix4fv(modelMatrixLoc, 1, GL_FALSE, &m_modelMatrix[0][0]);
  abcg::glUniform4fv(KaLoc, 1, &m_Ka.x);
  abcg::glUniform4fv(KdLoc, 1, &m_Kd.x);
  abcg::glUniform4fv(KsLoc, 1, &m_Ks.x);

  auto const modelViewMatrix{glm::mat3(m_viewMatrix * m_modelMatrix)};
  glm::mat3 normalMatrix{glm::inverseTranspose(modelViewMatrix)};
  abcg::glUniformMatrix3fv(normalMatrixLoc, 1, GL_FALSE, &normalMatrix[0][0]);
  
  abcg::glUniform1f(shininessLoc, m_shininess);
  glUniform4fv(KaLoc, 1, &m_Ka.x);
  glUniform4fv(KdLoc, 1, &m_Kd.x);
  glUniform4fv(KsLoc, 1, &m_Ks.x);

  // abcg::glUniform4f(colorLoc, 1.0f, 1.0f, 1.0f, 1.0f); // White
  // abcg::glUniform4f(colorLoc, 1.0f, 0.843137255f, 0.0f, 1.0f); // Yellow

  // if (m_currentPokemonIndex == 0) {
  //   abcg::glUniform4f(colorLoc, 1.0f, 0.843137255f, 0.0f, 1.0f); // Yellow
  // } 
  // if (m_currentPokemonIndex == 1) {
  //   abcg::glUniform4f(colorLoc, 0.62745098f, 0.321568627f, 0.176470588f, 1.0f); // Brown
  // } 
  // if (m_currentPokemonIndex == 2) {
  //   abcg::glUniform4f(colorLoc, 0.541176471f, 0.168627451f, 0.88627451f, 1.0f); // Purple
  // } 
  // if (m_currentPokemonIndex == 3) {
  //   abcg::glUniform4f(colorLoc, 1.0f, 0.752941176f, 0.796078431f, 1.0f); // PINK
  // } 

  m_model.render(m_trianglesToDraw);

  for (const auto index : iter::range(m_numPokemon)) {
    auto &position{m_pokemonPositions.at(index)};
    auto &rotation{m_pokemonPositions.at(index)};

    glm::mat4 modelMatrix{1.0f};
    modelMatrix = glm::translate(modelMatrix, position);
    modelMatrix = glm::scale(modelMatrix, glm::vec3(0.2f));
    modelMatrix = glm::rotate(modelMatrix, m_angle, rotation);

    glUniformMatrix4fv(modelMatrixLoc, 1, GL_FALSE, &modelMatrix[0][0]);

    m_model.render();
  }

  renderSkybox();
}

void Window::renderSkybox() {
  glUseProgram(m_skyProgram);

  GLint viewMatrixLoc{glGetUniformLocation(m_skyProgram, "viewMatrix")};
  GLint projMatrixLoc{glGetUniformLocation(m_skyProgram, "projMatrix")};
  GLint skyTexLoc{glGetUniformLocation(m_skyProgram, "skyTex")};

  auto viewMatrix{m_trackBallLight.getRotation()};
  glUniformMatrix4fv(viewMatrixLoc, 1, GL_FALSE, &viewMatrix[0][0]);
  glUniformMatrix4fv(projMatrixLoc, 1, GL_FALSE, &m_projMatrix[0][0]);
  glUniform1i(skyTexLoc, 0);

  glBindVertexArray(m_skyVAO);

  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_CUBE_MAP, m_model.getCubeTexture());

  glEnable(GL_CULL_FACE);
  glFrontFace(GL_CW);
  glDepthFunc(GL_LEQUAL);
  glDrawArrays(GL_TRIANGLES, 0, m_skyPositions.size());
  glDepthFunc(GL_LESS);

  glBindVertexArray(0);
  glUseProgram(0);
}

void Window::onPaintUI() {
  abcg::OpenGLWindow::onPaintUI();

  {
    auto size{ImVec2(400, 85)};
    auto position{ImVec2((m_viewportWidth - size.x) / 2.0f,
                         (m_viewportHeight - size.y) / 2.0f - 150.0f)};
    ImGui::SetNextWindowPos(position);
    ImGui::SetNextWindowSize(size);
    ImGuiWindowFlags flags{ImGuiWindowFlags_NoBackground |
                           ImGuiWindowFlags_NoTitleBar |
                           ImGuiWindowFlags_NoInputs};
    ImGui::Begin("Inicio", nullptr, flags);
    ImGui::End();

  }

  {

    auto const assetsPath{abcg::Application::getAssetsPath()};
    auto widgetSize{ImVec2(180, 40)};
    ImGui::SetNextWindowPos(ImVec2(m_viewportWidth - widgetSize.x - 5, m_viewportHeight - widgetSize.y - 5));
    ImGui::SetNextWindowSize(widgetSize);
    auto flags{ImGuiWindowFlags_NoDecoration};
    ImGui::Begin("Widget window", nullptr, flags);

    static std::size_t currentIndex{};

    ImGui::PushItemWidth(120);
    if (ImGui::BeginCombo("Pokemon", m_pokemonNames.at(currentIndex))) {
      for (auto index : iter::range(m_pokemonNames.size())) {
        const bool isSelected{currentIndex == index};
        if (ImGui::Selectable(m_pokemonNames.at(index), isSelected))
          currentIndex = index;
        if (isSelected) ImGui::SetItemDefaultFocus();
      }
      ImGui::EndCombo();
    }
    ImGui::PopItemWidth();

    if (static_cast<int>(currentIndex) != m_currentPokemonIndex) {
      m_currentPokemonIndex = currentIndex;

      m_model.loadFromFile(fmt::format("{}pokemon_{}.obj", assetsPath, m_pokemonNames.at(m_currentPokemonIndex)));
      m_model.setupVAO(m_programs.at(m_currentProgramIndex));
      m_trianglesToDraw = m_model.getNumTriangles();
    }

    ImGui::End();
  }
}

void Window::onResize(glm::ivec2 const &size) {
  m_viewportWidth = size.x;
  m_viewportHeight = size.y;
  m_trackBallModel.resizeViewport(size.x,size.y);
  m_trackBallLight.resizeViewport(size.x,size.y);
}

void Window::onDestroy() {
  for (const auto &program : m_programs) {
    glDeleteProgram(program);
  }
  terminateSkybox();
}

void Window::terminateSkybox() {
  glDeleteProgram(m_skyProgram);
  glDeleteBuffers(1, &m_skyVBO);
  glDeleteVertexArrays(1, &m_skyVAO);
}

void Window::onUpdate() {
  m_modelMatrix = m_trackBallModel.getRotation();

  m_eyePosition = glm::vec3(0.0f, 0.0f, 2.0f + m_zoom);
  m_viewMatrix = glm::lookAt(m_eyePosition, glm::vec3(0.0f, 0.0f, 0.0f),
                             glm::vec3(0.0f, 1.0f, 0.0f));

  // Increase angle by 90 degrees per second
  float deltaTime{static_cast<float>(getDeltaTime())};
  m_angle = m_angle + glm::radians(90.0f) * deltaTime;

  // Update pokemons
  for (const auto index : iter::range(m_numPokemon)) {
    auto &position{m_pokemonPositions.at(index)};
    auto &rotation{m_pokemonRotations.at(index)};

    // Increase z by 10 units per second
    position.z += deltaTime * 10.0f;

    // If this star is behind the camera, select a new random position &
    // orientation and move it back to -100
    if (position.z > 0.1f) {
      randomizePokemon(position, rotation);
      position.z = -100.0f; // Back to -100
    }
  }
}