import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/const/constant.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationController extends GetxController {
  RxBool isError = RxBool(false);
  RxString errorMessage = RxString("");
  Rxn<DataModel> newLocation = Rxn<DataModel>();
  RxDouble radius = RxDouble(100); //m단위임, 5200이면 5200m반경
  final String baseUrl = 'http://$myPort:3000';
  @override
  void onInit() {
    super.onInit();
    // _initializeLocation(); // 초기화 시 위치 설정
  }

  // Future<void> getGeocode(String address) async {
  //   final String apiKeyId = 'YOUR_API_KEY_ID'; // Naver API Key ID
  //   final String apiKey = 'YOUR_API_KEY'; // Naver API Key
  //   final String query = Uri.encodeQueryComponent(address); // 주소를 인코딩

  //   final String url =
  //       'https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=$query';

  //   try {
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'x-ncp-apigw-api-key-id': apiKeyId,
  //         'x-ncp-apigw-api-key': apiKey,
  //         'Accept': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);

  //       if (data['addresses'] != null && data['addresses'].isNotEmpty) {
  //         final latitude = data['addresses'][0]['y'];
  //         final longitude = data['addresses'][0]['x'];

  //         print('주소: $address');
  //         print('위도: $latitude, 경도: $longitude');
  //       } else {
  //         print('해당 주소에 대한 결과를 찾을 수 없습니다.');
  //       }
  //     } else {
  //       print('에러 발생: ${response.statusCode}');
  //       print('응답 내용: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('요청 중 오류 발생: $e');
  //   }
  // }
  Future<List<NCircleOverlay>> getNearbyPartners() async {
    try {
      final partners = await fetchNearbyPartners(
        latitude: 37.504198,
        longitude: 127.047967,
        radius: radius.value,
      );
      print("내가 설정한 반경 내 파트너>>>${partners}//${partners.length}");

      // 마커 데이터 추가
      final newMarkers = partners.map((p) {
        return NCircleOverlay(
          id: p['id'].toString(),
          center: NLatLng(p['latitude'], p['longitude']),
          radius: 16,
          color: CatchmongColors.green_line,
        );
      }).toList();

      // 기존 마커 초기화 후 새 마커 추가
      markers.clear();
      markers.addAll(newMarkers);
      update();
      print("추가된 마커>>>${markers.length}");
      return newMarkers;
    } catch (e) {
      print("파트너 데이터를 가져오는 중 오류 발생: $e");
      return [];
    }
  }

  Future<List<dynamic>> fetchNearbyPartners({
    required double latitude,
    required double longitude,
    required double radius,
  }) async {
    final url = Uri.parse(
      '$baseUrl/partners/nearby?latitude=$latitude&longitude=$longitude&radius=$radius',
    );

    try {
      // HTTP GET 요청
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // 응답 데이터를 JSON 디코딩 후 반환
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        throw Exception('Failed to fetch nearby partners: ${response.body}');
      }
    } catch (e) {
      // 오류 처리
      print('Error fetching partners: $e');
      rethrow;
    }
  }

  Future<void> fetchRegions() async {
    final url = Uri.parse('${baseUrl}/api/regions');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'longitude': 37.504198,
      'latitude': 127.047967,
      'radius': radius,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final List regions = jsonDecode(response.body);
        print('불러온 지역 데이터:');
        regions.forEach((region) {
          print(region);
        });
      } else {
        print('오류 발생: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('HTTP 요청 오류: $e');
    }
  }

  RxList<NCircleOverlay> markers = RxList<NCircleOverlay>([
    NCircleOverlay(
      id: "marker1",
      center: NLatLng(37.5665, 126.9780),
      radius: 16,
      color: CatchmongColors.green_line,
    ),
    NCircleOverlay(
      id: "marker2",
      center: NLatLng(37.5675, 126.9790),
      radius: 16,
      color: CatchmongColors.green_line,
    )
  ]);

  Future<void> fetchPartnersMarkers() async {
    // API 호출 또는 데이터베이스 조회
    final partners = [
      // 예제 데이터
      {"latitude": 37.5665, "longitude": 126.9780, "name": "Partner 1"},
      {"latitude": 37.5675, "longitude": 126.9790, "name": "Partner 2"},
    ];
    // NMarker(
    //   id: partner['name'].toString(), // 고유 ID
    // position: NLatLng(
    //     (partner['latitude'] as double), (partner['longitude'] as double)),
    //   // infoWindow: NInfoWindow.onTapText(partner['name']),
    //   // captionText: partner['name'], // 마커에 텍스트 추가
    // );
    markers.value = partners.map((partner) {
      return NCircleOverlay(
        id: partner['name'].toString(),
        center: NLatLng(
            (partner['latitude'] as double), (partner['longitude'] as double)),
        radius: 16,
        color: CatchmongColors.green_line,
      );
    }).toList();
  }

  Future<String> getAddressFromCoordinatesNaver(
      double latitude, double longitude) async {
    final String clientId = '9ue8t44jzd';
    final String clientSecret = 'BAEI5otauerHywPOBh3NCBKOPF1oXlzr0LawgdN1';
    final String url =
        'https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=$longitude,$latitude&output=json&orders=roadaddr';
    // 'https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=127.585%2C34.9765&output=json&orders=legalcode%2Cadmcode%2Caddr%2Croadaddr';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-NCP-APIGW-API-KEY-ID': clientId,
        'X-NCP-APIGW-API-KEY': clientSecret,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['results'].isNotEmpty) {
        return data['results'][0]['region']['area1']['name'] +
            ' ' +
            data['results'][0]['region']['area2']['name'];
      } else {
        throw Exception('주소를 찾을 수 없습니다.');
      }
    } else {
      throw Exception('Naver API 요청 실패');
    }
  }

  Future<void> _initializeLocation() async {
    try {
      // 위치 권한 확인 및 요청
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("위치 서비스가 비활성화되어 있습니다.");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("위치 권한이 거부되었습니다.");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("위치 권한이 영구적으로 거부되었습니다.");
      }

      // 현재 위치 가져오기
      Position position = await Geolocator.getCurrentPosition();

      String address = await getAddressFromCoordinatesNaver(
          position.latitude, position.longitude);
      // DataModel 생성 및 newLocation.value에 저장
      // newLocation.value = DataModel.fromMap(position as Map<String, dynamic>);
      print('앱 시작 시 위치 ${address}');
    } catch (e) {
      // 에러 처리
      isError.value = true;
      errorMessage.value = e.toString();
    }
  }

  // Rxn<NLatLng> currentLatLng = Rxn<NLatLng>(); // 위도, 경도 저장

  // Future<void> fetchCoordinates(String address) async {
  //   final String apiKey = "9ue8t44jzd"; // 네이버 API 키
  //   final String apiKeyId =
  //       "BAEI5otauerHywPOBh3NCBKOPF1oXlzr0LawgdN1"; // 네이버 API ID

  //   final String url =
  //       "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=${Uri.encodeComponent(address)}";

  //   try {
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         "X-NCP-APIGW-API-KEY-ID": apiKeyId,
  //         "X-NCP-APIGW-API-KEY": apiKey,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final jsonResponse = json.decode(response.body);
  //       if (jsonResponse['addresses'] != null &&
  //           jsonResponse['addresses'].isNotEmpty) {
  //         final result = jsonResponse['addresses'][0];
  //         final double latitude = double.parse(result['y']);
  //         final double longitude = double.parse(result['x']);

  //         // 위도, 경도 저장
  //         currentLatLng.value = NLatLng(latitude, longitude);
  //         // print("위도경도>>>")
  //       } else {
  //         throw Exception("No results found for the given address");
  //       }
  //     } else {
  //       throw Exception("Failed to fetch coordinates");
  //     }
  //   } catch (e) {
  //     print("Error fetching coordinates: $e");
  //   }
  // }

  void setLocation(DataModel newRegion) {
    newLocation.value = newRegion;
  }
}
