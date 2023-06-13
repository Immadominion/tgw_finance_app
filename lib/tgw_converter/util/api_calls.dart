// import 'package:get/get_connect.dart';

// class ApiCalls extends GetConnect {
//   Future<Response> getRates(String curr) async {
//     String apiKey =
//         'MvEkyZzNoQAdIIztHVuXGZyUqqEHwigCchBv70qE'; // paste your API key from https://app.currencyapi.com
//     Response response = await get(
//       'https://api.currencyapi.com/v3/latest?apikey=$apiKey&base_currency=$curr',
//     );
//     return response;
//   }
// }

import 'package:get/get_connect.dart';

class ApiCalls extends GetConnect {
  final String apiKey;

  ApiCalls(this.apiKey);
//http://api.currencyapi.com/v3/latest?apikey=MvEkyZzNoQAdIIztHVuXGZyUqqEHwigCchBv70qE
  Future<Response> getRates(String curr) async {
    final response = await get(
      'http://api.currencyapi.com/v3/latest?apikey=$apiKey&base_currency=$curr',
    );

    if (response.status.hasError) {
      throw Exception('Unable to fetch data from API');
    }
    print(response);
    return response;
  }
}
