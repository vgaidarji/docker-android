workflow "Build and Publish to Dockerhub" {
  on = "push"
  resolves = "Build and Publish Android Emulator Image"
}

action "Build and Publish Android Build Image" {
  uses = "elgohr/Publish-Docker-Github-Action@2.7"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  name: vgaidarji/docker-android-build
  workdir: docker-android-build
  tag_names: true
}

action "Build and Publish Android Emulator Image" {
  needs = ["Build and Publish Android Build Image"]
  uses = "elgohr/Publish-Docker-Github-Action@2.7"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  name: vgaidarji/docker-android-emulator
  workdir: docker-android-emulator
  tag_names: true
}
