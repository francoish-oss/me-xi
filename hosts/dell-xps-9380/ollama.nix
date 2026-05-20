{
  ...
}:

{
  services.ollama = {
    enable = true;
    loadModels = [
      "granite4.1:3b"
    ];
    syncModels = true;
  };
}
