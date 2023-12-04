import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool choolCheckDone = false;
  GoogleMapController? mapController;
  //latitude- 위도 longitude- 경도
  static final LatLng houseLatLng = LatLng(
    37.275466,
    126.933186,
  );

  static final CameraPosition initialPosition = CameraPosition(
    target: houseLatLng,
    zoom: 16,
  );
  static final double okDistance = 100;
  static final Circle withinDisanceCircle = Circle(
    circleId: CircleId('withinDisanceCircle'),
    center: houseLatLng,
    fillColor: Colors.blue.withOpacity(0.1),
    radius: okDistance,
    strokeColor: Colors.blue,
    strokeWidth: 1,
  );
  static final Circle notwithinDisanceCircle = Circle(
    circleId: CircleId('notwithinDisanceCircle'),
    center: houseLatLng,
    fillColor: Colors.red.withOpacity(0.1),
    radius: okDistance,
    strokeColor: Colors.red,
    strokeWidth: 1,
  );
  static final Circle checkDoneCircle = Circle(
    circleId: CircleId('checkDoneCircle'),
    center: houseLatLng,
    fillColor: Colors.green.withOpacity(0.1),
    radius: okDistance,
    strokeColor: Colors.green,
    strokeWidth: 1,
  );
  static final Marker marker = Marker(
    markerId: MarkerId('marker'),
    position: houseLatLng,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder<String>(
        future: checkPermission(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == '위치 권한이 허가되었습니다.') {
            //print(snapshot.connectionState);
            //future함수의 상태가 바뀔때마다 계속 빌더 재실행된다는 것을 보기 위한 것.
            //print(snapshot.data);
            return StreamBuilder<Position>(
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  bool isWithinRange = false;

                  if (snapshot.hasData) {
                    final start = snapshot.data!;
                    final end = houseLatLng;

                    final distance = Geolocator.distanceBetween(start.latitude,
                        start.longitude, end.latitude, end.longitude);

                    if (distance < okDistance) {
                      isWithinRange = true;
                    }
                  }
                  print(snapshot.data);
                  return Column(
                    children: [
                      _CustomGoogleMap(
                        initialPosition: initialPosition,
                        circle: choolCheckDone
                            ? checkDoneCircle
                            : isWithinRange
                                ? withinDisanceCircle
                                : notwithinDisanceCircle,
                        marker: marker,
                        onMapCreated: onMapCreated,
                      ),
                      _ChoolCheckButton(
                        onPressed: onChoolCheckPressed,
                        choolCheckDone: choolCheckDone,
                        iswithinRange: isWithinRange,
                      ),
                    ],
                  );
                });
          }
          return Center(
            child: Text(snapshot.data),
          );
        },
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  onChoolCheckPressed() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('출근하기'),
          content: Text('출근을 하시겠습니까?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('출근하기')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('취소')),
          ],
        );
      },
    );
    if (result) {
      setState(() {
        choolCheckDone = true;
      });
    }
  }

  //권한과 관련된 모든 작업은 async로 하게되어있다.
  //유저 input을 기다리기 때문에.
  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치 서비스를 활성화 해주세요';
    }
    LocationPermission checkedPermission = await Geolocator.checkPermission();
    // 앱이 갖고 있는 권한이 뭐가 있는지.

    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();

      if (checkedPermission == LocationPermission.denied) {
        return '위치 권환을 허가해주세요';
      }
    }
    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 setting에서 허가해주세요';
    }
    return '위치 권한이 허가되었습니다.';
  }

  AppBar renderAppBar() {
    return AppBar(
      title: Text('오늘도 출근',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w700,
          )),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            if (mapController == null) {
              return;
            }

            final location = await Geolocator.getCurrentPosition();

            mapController!.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(location.latitude, location.longitude),
              ),
            );
          },
          color: Colors.blue,
          icon: Icon(Icons.my_location),
        )
      ],
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;
  final MapCreatedCallback? onMapCreated;

  const _CustomGoogleMap(
      {super.key,
      required this.initialPosition,
      required this.circle,
      required this.marker,
      required this.onMapCreated});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: initialPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          circles: Set.from([
            circle,
          ]),
          markers: Set.from([marker]),
          onMapCreated: onMapCreated),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  final bool iswithinRange;
  final VoidCallback onPressed;
  final bool choolCheckDone;

  const _ChoolCheckButton(
      {super.key,
      required this.iswithinRange,
      required this.onPressed,
      required this.choolCheckDone});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.timelapse_outlined,
              size: 50.0,
              color: choolCheckDone
                  ? Colors.green
                  : iswithinRange
                      ? Colors.blue
                      : Colors.red),
          const SizedBox(height: 20.0),
          if (!choolCheckDone && iswithinRange)
            TextButton(
              onPressed: onPressed,
              child: Text('출근하기'),
            ),
        ],
      ),
    );
  }
}
