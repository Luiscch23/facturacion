import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> postData(String rfc, String nombre, String correo, String postal,
    String clave_regimen, String clave_uso) async {
  var url = Uri.parse('http://localhost/datosfiscales.php');
  var body = {
    'RFC': rfc,
    'NOMBRE': nombre,
    'CORREO': correo,
    'POSTAL': postal,
    'clave_regimen': clave_regimen,
    'clave_uso': clave_uso,
  };

  var response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    print("todo funciono al chingaso");
    print(response.body);
    // Solicitud POST exitosa
    return 'Datos enviados exitosamente';
  } else {
    // Error durante la solicitud POST
    print('Error: ${response.statusCode}');
    return 'Error: ${response.statusCode}';
  }
}
