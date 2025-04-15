class ApiConstants {
  // URL base del servidor
  static const String baseUrl = 'https://adamix.net/defensa_civil/def/';

  // Endpoints organizados por módulo
  static const String login = '$baseUrl/iniciar_sesion.php';
  static const String register = '$baseUrl/registro.php';
  static const String forgotPassword = '$baseUrl/recuperar_clave.php';
  //static const String changePassword = '$baseUrl/cambiar_clave.php';

  // Shelters
  static const String shelters = '$baseUrl/albergues.php';

  // News
  static const String news = '$baseUrl/noticias.php';

  // Videos
  static const String videos = '$baseUrl/videos';

  // Preventive Measures
  static const String preventiveMeasures = '$baseUrl/medidas_preventivas.php';

  // Members
  static const String members = '$baseUrl/miembros.php';

  // Volunteers
  static const String volunteerApplication = '$baseUrl/volunteers/apply';

  // Reports
  static const String reportSituation = '$baseUrl/nueva_situacion.php';
  static const String myReports = '$baseUrl/situaciones.php';
  //static const String mapReports = '$baseUrl/reports/map';
}
