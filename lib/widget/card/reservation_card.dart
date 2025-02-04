import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/const/constant.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:catchmong/controller/reservation_controller.dart';
import 'package:catchmong/model/partner.dart';
import 'package:catchmong/model/reservation_setting.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/modules/partner/controllers/partner-controller.dart';
import 'package:catchmong/widget/bar/close_appbar.dart';
import 'package:catchmong/widget/bar/default_appbar.dart';
import 'package:catchmong/widget/button/YellowElevationBtn.dart';
import 'package:catchmong/widget/button/outline_btn_with_icon.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/button/yellow-toggle-btn.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:catchmong/widget/txtfield/border-txtfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ReservationCard extends StatelessWidget {
  final ReservationSetting setting;
  const ReservationCard({super.key, required this.setting});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final ReservationConteroller controller =
        Get.find<ReservationConteroller>();
    final Partner2Controller partnerController = Get.find<Partner2Controller>();
    bool isLocal = !setting.reservationImage!.contains("uploads");
    // String formatReservationPeriod(DateTime startDate, DateTime endDate) {
    //   // 요일 확인 (1: 월요일 ~ 5: 금요일 -> 평일, 6: 토요일, 7: 일요일 -> 주말)
    //   bool isWeekend(DateTime date) {
    //     return date.weekday == 6 || date.weekday == 7;
    //   }

    //   // 시간 포맷: HH시 mm분
    //   String formatTime(DateTime date) {
    //     return "${date.hour.toString().padLeft(2, '0')}시 ${date.minute.toString().padLeft(2, '0')}분";
    //   }

    //   // 시작 시간과 종료 시간 포맷
    //   String startTime = formatTime(startDate);
    //   String endTime = formatTime(endDate);

    //   // 평일 또는 주말 판단
    //   String dayType = isWeekend(startDate) ? "주말 예약" : "평일 예약";

    //   // 결과 반환
    //   return "$dayType($startTime~$endTime)";
    // }

    return InkWell(
      onTap: () async {
        List<DateTime> timeSlots = controller.getTimeSlots(
            setting.startTime, setting.endTime, setting.timeUnit);
        final startDt = DateTime(
          controller.selectedReservationDate.value.year, // 연도
          controller.selectedReservationDate.value.month, // 월
          controller.selectedReservationDate.value.day, // 일
          timeSlots[controller.selectedReservationTimeIdx.value].hour, // 시간
          timeSlots[controller.selectedReservationTimeIdx.value].minute, // 분
          timeSlots[controller.selectedReservationTimeIdx.value]
              .second, // 초 (선택적)
          timeSlots[controller.selectedReservationTimeIdx.value]
              .millisecond, // 밀리초 (선택적)
          timeSlots[controller.selectedReservationTimeIdx.value]
              .microsecond, // 마이크로초 (선택적)
        );
        await controller.fetchFullyBookedTimes(
            settingId: setting.id!, startDt: startDt);
        final partner =
            await partnerController.fetchPartnerPhone(setting.partnerId!);

        if (partner != null) {
          showReservationPerPartner(context, setting, partner, timeSlots);
        }
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        width: width, // 컨테이너 너비
        // height: 200, // 컨테이너 높이
        decoration: BoxDecoration(
          border: Border.all(color: CatchmongColors.gray50),
          color: Colors.white, // 컨테이너 배경색
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000), // #00000040 (불투명도 25%)
              offset: Offset(0, 4), // 그림자의 X, Y 방향 위치
              blurRadius: 4, // 흐림 정도
              spreadRadius: 0, // 그림자 확산 정도
            ),
          ],
          borderRadius: BorderRadius.circular(12), // 컨테이너의 모서리 둥글기
        ),
        child: Center(
          child: Column(
            children: [
              // Container(
              //     height: 200,
              //     child: Center(
              //         child: Text(
              //       "첨부한 \n가게사진",
              //       textAlign: TextAlign.center,
              //     ))),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CatchmongColors.gray100,
                    ),
                  ),
                ),
                height: 200,
                child: ImgCard(
                    width: double.infinity, // 부모의 너비에 맞게 확장
                    height: double.infinity, // 부모의 높이에 맞게 확장
                    isLocal: isLocal,
                    path: isLocal
                        ? setting.reservationImage!
                        : "http://$myPort:3000/${setting.reservationImage!}"),
              ),

              Container(
                width: width,
                height: 128,
                margin: EdgeInsets.only(
                  left: 20,
                  top: 10,
                  right: 20,
                  bottom: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.formatReservationPeriod(
                          setting.startTime, setting.endTime),
                      style: TextStyle(
                        color: CatchmongColors.gray_800,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      setting.description ?? "",
                      style: TextStyle(
                        color: CatchmongColors.gray_800,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 5, // 최대 줄 수
                      overflow: TextOverflow.ellipsis, // 초과된 텍스트를 ...로 표시
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void showReservationPerPartner(BuildContext context, ReservationSetting setting,
    Partner partner, List<DateTime> timeSlots) {
  double width = MediaQuery.of(context).size.width;
  final Partner2Controller controller = Get.find<Partner2Controller>();
  final ReservationConteroller reservationConteroller =
      Get.find<ReservationConteroller>();
  final LoginController loginController = Get.find<LoginController>();
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      List<DateTime> timeSlots = reservationConteroller.getTimeSlots(
          setting.startTime, setting.endTime, setting.timeUnit);

      final int crossAxisCount = 4; // 한 줄에 표시할 버튼 개수
      final double buttonHeight = 48; // 버튼 높이
      final double spacing = 8; // 간격 (세로)

      // 전체 줄 수 계산
      final int rowCount = (timeSlots.length / crossAxisCount).ceil();

      // 컨테이너 높이 계산
      final double containerHeight =
          rowCount * buttonHeight + (rowCount - 1) * spacing; // 버튼 높이와 간격 고려
      List<String> peopleNumString = setting.allowedPeople.split(',');

      // 2. 숫자 추출 및 변환
      List<int> numbers = peopleNumString.map((item) {
        return int.parse(item.replaceAll(RegExp(r'[^0-9]'), ''));
      }).toList();

      // 3. 오름차순 정렬
      numbers.sort();
      RxString formatConfirmDateTime(DateTime date) {
        // 요일 이름 리스트
        List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];

        // 월, 일, 시간 포맷
        String formattedDate = DateFormat('MM.dd').format(date); // MM.dd 형식
        String formattedTime = DateFormat('HH:mm').format(date); // HH:mm 형식
        String weekday = weekdays[date.weekday - 1]; // 요일 추출 (1부터 시작)

        return '$formattedDate ($weekday) $formattedTime'.obs;
      }

      final startDt = DateTime(
        reservationConteroller.selectedReservationDate.value.year, // 연도
        reservationConteroller.selectedReservationDate.value.month, // 월
        reservationConteroller.selectedReservationDate.value.day, // 일
        timeSlots[reservationConteroller.selectedReservationTimeIdx.value]
            .hour, // 시간
        timeSlots[reservationConteroller.selectedReservationTimeIdx.value]
            .minute, // 분
        timeSlots[reservationConteroller.selectedReservationTimeIdx.value]
            .second, // 초 (선택적)
        timeSlots[reservationConteroller.selectedReservationTimeIdx.value]
            .millisecond, // 밀리초 (선택적)
        timeSlots[reservationConteroller.selectedReservationTimeIdx.value]
            .microsecond, // 마이크로초 (선택적)
      );

      print("date>>>${startDt.toUtc().toIso8601String()}");
      return Scaffold(
        bottomNavigationBar: Container(
          height: 68,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: CatchmongColors.gray50,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _makePhoneCall(partner.phone);
                },
                child: Container(
                  child: SvgPicture.asset(
                    'assets/images/call.svg',
                    width: 16,
                  ),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CatchmongColors.yellow_main,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: YellowElevationBtn(
                  onPressed: () async {
                    if (setting.id == null) return;
                    if (reservationConteroller.agreePrivacy.isFalse) {
                      Get.snackbar(
                        "알림",
                        "개인정보 수집 및 이용에 동의해주세요.",
                        snackPosition: SnackPosition.TOP, // 상단에 표시
                        backgroundColor: CatchmongColors.yellow_main,
                        colorText: CatchmongColors.black,
                        icon: Icon(Icons.check_circle,
                            color: CatchmongColors.black),
                        duration: Duration(seconds: 1),
                        borderRadius: 10,
                        margin: EdgeInsets.all(10),
                      );
                      return;
                    }
                    final startDt = DateTime(
                      reservationConteroller
                          .selectedReservationDate.value.year, // 연도
                      reservationConteroller
                          .selectedReservationDate.value.month, // 월
                      reservationConteroller
                          .selectedReservationDate.value.day, // 일
                      timeSlots[reservationConteroller
                              .selectedReservationTimeIdx.value]
                          .hour, // 시간
                      timeSlots[reservationConteroller
                              .selectedReservationTimeIdx.value]
                          .minute, // 분
                      timeSlots[reservationConteroller
                              .selectedReservationTimeIdx.value]
                          .second, // 초 (선택적)
                      timeSlots[reservationConteroller
                              .selectedReservationTimeIdx.value]
                          .millisecond, // 밀리초 (선택적)
                      timeSlots[reservationConteroller
                              .selectedReservationTimeIdx.value]
                          .microsecond, // 마이크로초 (선택적)
                    );
                    final endDt = startDt.add(Duration(
                        minutes: setting.timeUnit == "THIRTY_MIN" ? 30 : 60));

                    final res =
                        await reservationConteroller.postCreateReservation(
                      userId: loginController.user.value!.id,
                      partnerId: partner.id!,
                      settingId: setting.id!,
                      reservationStartDate: startDt,
                      reservationEndDate: endDt,
                      numOfPeople: numbers[reservationConteroller
                          .selectedReservationNumOfPeopleIdx.value],
                      request:
                          reservationConteroller.reservationReqController.text,
                    );

                    if (res) {
                      Get.back(closeOverlays: true);

                      showReservationConfirm(context, setting);

                      // reservationConteroller.selectedReservationDate.value =
                      //     DateTime.now();
                      // reservationConteroller.selectedReservationTimeIdx.value =
                      //     0;
                      // reservationConteroller
                      //     .selectedReservationNumOfPeopleIdx.value = 0;
                      // reservationConteroller.reservationReqController.clear();
                      // reservationConteroller.agreePrivacy.value = false;
                    } else {
                      Get.snackbar(
                        "알림",
                        "예약을 실패했습니다.",
                        snackPosition: SnackPosition.TOP, // 상단에 표시
                        backgroundColor: CatchmongColors.yellow_main,
                        colorText: CatchmongColors.black,
                        icon: Icon(Icons.check_circle,
                            color: CatchmongColors.black),
                        duration: Duration(seconds: 1),
                        borderRadius: 10,
                        margin: EdgeInsets.all(10),
                      );
                    }
                  },
                  title: Text("예약하기"),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: CatchmongColors.gray50,
        appBar: DefaultAppbar(title: "예약"),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/file-edit-icon.svg'),
                          Text(
                            "신청 후 확정 매장",
                            style: TextStyle(
                              color: CatchmongColors.gray_800,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "업체에서 확인 후 예약을 확정합니다.",
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200, // 카드의 높이와 동일하게 설정

                    child: ImgCard(
                      path: !setting.reservationImage!.contains("uploads")
                          ? setting.reservationImage!
                          : "http://$myPort:3000/${setting.reservationImage!}",
                      width: double.infinity, // 부모의 너비에 맞게 확장
                      height: double.infinity, // 부모의 높이에 맞게 확장
                      isLocal: !setting.reservationImage!.contains("uploads"),
                    )),
                //예약 안내문
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: 128,
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 10,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reservationConteroller.formatReservationPeriod(
                            setting.startTime, setting.endTime),
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        setting.description ?? "",
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 3, // 최대 줄 수
                        overflow: TextOverflow.ellipsis, // 초과된 텍스트를 ...로 표시
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //예약 선택하는 것들
                Container(
                  color: Colors.white,
                  child: DefaultTabController(
                    length: 2, // 탭 개수: 메뉴와 리뷰
                    child: Column(
                      children: [
                        // 탭바
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: CatchmongColors.gray50,
                          ))),
                          child: TabBar(
                            indicatorColor: CatchmongColors.gray_800,
                            labelColor: CatchmongColors.gray_800,
                            tabs: [
                              Tab(text: "예약"),
                              Tab(text: "정보"),
                            ],
                          ),
                        ),
                        // 탭바 뷰
                        SizedBox(
                          height: 1000, // 탭 뷰 높이 설정
                          child: TabBarView(
                            children: [
                              // 예약 탭 내용
                              Container(
                                width: width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //컴포넌트 타이틀
                                    Container(
                                      width: width,
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        top: 24,
                                        right: 20,
                                        bottom: 16,
                                      ),
                                      child: Text(
                                        "예약일자 선택",
                                        style: TextStyle(
                                          color: CatchmongColors.gray_800,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    //날짜 선택 버튼
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: OutlinedBtnWithIcon(
                                          width: width - 40,
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/images/calendar.svg'),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Obx(() => Text(
                                                    DateFormat("yyyy-MM-dd").format(
                                                        reservationConteroller
                                                            .selectedReservationDate
                                                            .value),
                                                    style: TextStyle(
                                                      color:
                                                          CatchmongColors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                          onPress: () async {
                                            await reservationConteroller
                                                .pickPartnerRervationDate(
                                                    context);
                                            final changedDt = DateTime(
                                              reservationConteroller
                                                  .selectedReservationDate
                                                  .value
                                                  .year, // 연도
                                              reservationConteroller
                                                  .selectedReservationDate
                                                  .value
                                                  .month, // 월
                                              reservationConteroller
                                                  .selectedReservationDate
                                                  .value
                                                  .day, // 일
                                              timeSlots[reservationConteroller
                                                      .selectedReservationTimeIdx
                                                      .value]
                                                  .hour, // 시간
                                              timeSlots[reservationConteroller
                                                      .selectedReservationTimeIdx
                                                      .value]
                                                  .minute, // 분
                                              timeSlots[reservationConteroller
                                                      .selectedReservationTimeIdx
                                                      .value]
                                                  .second, // 초 (선택적)
                                              timeSlots[reservationConteroller
                                                      .selectedReservationTimeIdx
                                                      .value]
                                                  .millisecond, // 밀리초 (선택적)
                                              timeSlots[reservationConteroller
                                                      .selectedReservationTimeIdx
                                                      .value]
                                                  .microsecond, // 마이크로초 (선택적)
                                            );
                                            await reservationConteroller
                                                .fetchFullyBookedTimes(
                                                    settingId: setting.id!,
                                                    startDt: changedDt);
                                          }),
                                    )
                                    //예약 일자 시간 버튼들
                                    ,
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //시간 버튼들
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      // constraints:
                                      //     BoxConstraints(minHeight: 300),
                                      height:
                                          containerHeight, // 높이 설정 (화면 넘치지 않도록)//수정할 부분, 버튼 한줄 높이 계산해서 늘어나는만큼 늘리기
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4, // 한 줄에 4개씩
                                          crossAxisSpacing: 8, // 가로 간격
                                          mainAxisSpacing: 8, // 세로 간격
                                          childAspectRatio:
                                              1.6, // 버튼 비율 설정 (가로:세로 비율)
                                        ),
                                        physics:
                                            NeverScrollableScrollPhysics(), // 스크롤 비활성화
                                        itemCount: timeSlots.length, // 버튼 개수
                                        itemBuilder: (context, index) {
                                          final time = timeSlots[index];
                                          final formatted =
                                              DateFormat('HH:mm').format(time);
                                          return Obx(() => YellowToggleBtn(
                                                isDisabled: RxBool(
                                                        reservationConteroller
                                                            .fullyDt
                                                            .map((el) =>
                                                                DateFormat(
                                                                        'HH:mm')
                                                                    .format(el))
                                                            .contains(
                                                                formatted))
                                                    .value,
                                                height: 48,
                                                width: double
                                                    .infinity, // GridView가 알아서 크기를 설정
                                                title: formatted,
                                                isSelected: index ==
                                                    reservationConteroller
                                                        .selectedReservationTimeIdx
                                                        .value, // 첫 번째만 선택된 상태 (예시)
                                                onTap: () {
                                                  reservationConteroller
                                                      .selectedReservationTimeIdx
                                                      .value = index;
                                                },
                                              ));
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //인원수 선택 타이틀
                                    Container(
                                      width: width,
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        top: 24,
                                        right: 20,
                                        bottom: 16,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "인원수 선택",
                                            style: TextStyle(
                                              color: CatchmongColors.gray_800,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "인원이 많을 시 매장에 문의 후 예약부탁드립니다.",
                                            style: TextStyle(
                                              color: CatchmongColors.gray_800,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    //인원수 선택 토글
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      height: 50,
                                      child: ListView.builder(
                                          itemCount: numbers.length + 1,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder:
                                              (BuildContext context, int idx) {
                                            return Container(
                                              margin: EdgeInsets.only(right: 8),
                                              child: Obx(() => YellowToggleBtn(
                                                    width: idx == numbers.length
                                                        ? 120
                                                        : 70,
                                                    title: idx == numbers.length
                                                        ? "인원문의전화"
                                                        : '${numbers[idx]}명',
                                                    isSelected: idx ==
                                                        reservationConteroller
                                                            .selectedReservationNumOfPeopleIdx
                                                            .value,
                                                    onTap: () {
                                                      reservationConteroller
                                                          .selectedReservationNumOfPeopleIdx
                                                          .value = idx;
                                                    },
                                                  )),
                                            );
                                          }),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //가게 요청사항 타이틀
                                    Container(
                                      width: width,
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        top: 24,
                                        right: 20,
                                        bottom: 16,
                                      ),
                                      child: Text(
                                        "가게 요청사항",
                                        style: TextStyle(
                                          color: CatchmongColors.gray_800,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    //가게요청사항 텍스트필드
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: BorderTxtField(
                                        controller: reservationConteroller
                                            .reservationReqController,
                                        onChanged: (String value) {
                                          if (reservationConteroller
                                                  .reservationReqController
                                                  .text
                                                  .length >
                                              300) {
                                            Future.microtask(() {
                                              reservationConteroller
                                                  .reservationReqController
                                                  .value = TextEditingValue(
                                                text: value.substring(0, 300),
                                                selection:
                                                    TextSelection.collapsed(
                                                        offset: 300),
                                              );
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    //예약 확인 타이틀
                                    Container(
                                      width: width,
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        top: 24,
                                        right: 20,
                                        bottom: 16,
                                      ),
                                      child: Text(
                                        "예약 확인",
                                        style: TextStyle(
                                          color: CatchmongColors.gray_800,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    //예약 확인 카드
                                    Container(
                                      width: width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          border: Border.all(
                                            color: CatchmongColors.gray100,
                                          )),
                                      padding: EdgeInsets.all(16),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            reservationConteroller
                                                .formatReservationPeriod(
                                                    setting.startTime,
                                                    setting.endTime),
                                            style: TextStyle(
                                              color: CatchmongColors.gray_800,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "일정",
                                                    style: TextStyle(
                                                      color:
                                                          CatchmongColors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
                                                  )),
                                              Obx(() => Text(
                                                    formatConfirmDateTime(
                                                        DateTime(
                                                      reservationConteroller
                                                          .selectedReservationDate
                                                          .value
                                                          .year, // 연도
                                                      reservationConteroller
                                                          .selectedReservationDate
                                                          .value
                                                          .month, // 월
                                                      reservationConteroller
                                                          .selectedReservationDate
                                                          .value
                                                          .day, // 일
                                                      timeSlots[reservationConteroller
                                                              .selectedReservationTimeIdx
                                                              .value]
                                                          .hour, // 시간
                                                      timeSlots[reservationConteroller
                                                              .selectedReservationTimeIdx
                                                              .value]
                                                          .minute, // 분
                                                      timeSlots[reservationConteroller
                                                              .selectedReservationTimeIdx
                                                              .value]
                                                          .second, // 초 (선택적)
                                                      timeSlots[reservationConteroller
                                                              .selectedReservationTimeIdx
                                                              .value]
                                                          .millisecond, // 밀리초 (선택적)
                                                      timeSlots[reservationConteroller
                                                              .selectedReservationTimeIdx
                                                              .value]
                                                          .microsecond, // 마이크로초 (선택적)
                                                    )).value,
                                                    style: TextStyle(
                                                      color:
                                                          CatchmongColors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "인원",
                                                    style: TextStyle(
                                                      color:
                                                          CatchmongColors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
                                                  )),
                                              Obx(() => Text(
                                                    RxString(
                                                            "${numbers[reservationConteroller.selectedReservationNumOfPeopleIdx.value]}명")
                                                        .value,
                                                    style: TextStyle(
                                                      color:
                                                          CatchmongColors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "요청사항",
                                                    style: TextStyle(
                                                      color:
                                                          CatchmongColors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
                                                  )),
                                              Expanded(
                                                child: Obx(
                                                  () => Text(
                                                    RxString(reservationConteroller
                                                            .reservationReqController
                                                            .text)
                                                        .value,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      color:
                                                          CatchmongColors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // 정보 탭 내용

                              Container(
                                width: width,
                                color: CatchmongColors.gray50,
                                child: Column(
                                  children: [
                                    //안내문구
                                    Container(
                                      width: width,
                                      color: Colors.white,
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            reservationConteroller
                                                .formatReservationPeriod(
                                                    setting.startTime,
                                                    setting.endTime),
                                            style: TextStyle(
                                              color: CatchmongColors.gray_800,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "*예약은 최소 1시간전 시간부터 가능합니다.\n${setting.description ?? "-"}",
                                            maxLines: 6, // 최대 줄 수
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //예약시 확인해주세요
                                    Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "예약 시 확인해주세요",
                                            style: TextStyle(
                                              color: CatchmongColors.gray_800,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "※ 예약자 주의사항 : 예약일시 및 시간 변경할 경우 예약전날까지 연락주시는 분 한해서 매장상황 등 고려하여 변경해 드립니다. 당일예약건 시간 변경에 한해서는 10분 변경해 드리며 사전연락없이 예약시간이 경과될 경우. 자동 노쇼처리됨을 안내해 드리오니 매장 이용에 착오없으시길 바랍니다.",
                                            maxLines: 6, // 최대 줄 수
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //가게정보
                                    Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "가게 정보",
                                            style: TextStyle(
                                              color: CatchmongColors.gray_800,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: 120,
                                                      child: Text("상호",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                CatchmongColors
                                                                    .black,
                                                          ))),
                                                  Expanded(
                                                      child: Text(partner.name,
                                                          softWrap: true,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                CatchmongColors
                                                                    .black,
                                                          )))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              //   Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment.start,
                                              //     crossAxisAlignment:
                                              //         CrossAxisAlignment.start,
                                              //     children: [
                                              //       SizedBox(
                                              //           width: 120,
                                              //           child: Text("상호",
                                              //               style: TextStyle(
                                              //                 fontSize: 16,
                                              //                 fontWeight:
                                              //                     FontWeight.w400,
                                              //                 color:
                                              //                     CatchmongColors
                                              //                         .black,
                                              //               ))),
                                              //       Expanded(
                                              //           child: Text("호박꽃마차 대전점",
                                              //               softWrap: true,
                                              //               style: TextStyle(
                                              //                 fontSize: 16,
                                              //                 fontWeight:
                                              //                     FontWeight.w400,
                                              //                 color:
                                              //                     CatchmongColors
                                              //                         .black,
                                              //               )))
                                              //     ],
                                              //   ),

                                              //  SizedBox(
                                              //     height: 8,
                                              //   ),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.start,
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.start,
                                              //   children: [
                                              //     SizedBox(
                                              //         width: 120,
                                              //         child: Text("대표자명",
                                              //             style: TextStyle(
                                              //               fontSize: 16,
                                              //               fontWeight:
                                              //                   FontWeight.w400,
                                              //               color:
                                              //                   CatchmongColors
                                              //                       .black,
                                              //             ))),
                                              //     Expanded(
                                              //         child: Text("가게주",
                                              //             softWrap: true,
                                              //             style: TextStyle(
                                              //               fontSize: 16,
                                              //               fontWeight:
                                              //                   FontWeight.w400,
                                              //               color:
                                              //                   CatchmongColors
                                              //                       .black,
                                              //             )))
                                              //   ],
                                              // ),
                                              // SizedBox(
                                              //   height: 8,
                                              // ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: 120,
                                                      child: Text("소재지",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                CatchmongColors
                                                                    .black,
                                                          ))),
                                                  Expanded(
                                                      child: Text(
                                                          partner.address,
                                                          softWrap: true,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                CatchmongColors
                                                                    .black,
                                                          )))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: 120,
                                                      child: Text("사업자번호",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                CatchmongColors
                                                                    .black,
                                                          ))),
                                                  Expanded(
                                                      child: Text(
                                                          "219-43-00799",
                                                          softWrap: true,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                CatchmongColors
                                                                    .black,
                                                          )))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: 120,
                                                      child: Text("연락처",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                CatchmongColors
                                                                    .black,
                                                          ))),
                                                  Expanded(
                                                      child: InkWell(
                                                    onTap: () {
                                                      _makePhoneCall(
                                                          partner.phone);
                                                    },
                                                    child: Text(partner.phone,
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors
                                                              .blue, // 전화번호에 색상 추가하여 클릭 가능하게 보이도록 설정
                                                          decoration: TextDecoration
                                                              .underline, // 밑줄 추가
                                                        )),
                                                  ))
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //동의
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      //동의 체크하는 줄
                      InkWell(
                        onTap: () {
                          reservationConteroller.agreePrivacy.value =
                              !reservationConteroller.agreePrivacy.value;
                        },
                        child: Container(
                          width: width,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Obx(() => Icon(
                                    reservationConteroller.agreePrivacy.isTrue
                                        ? Icons.check_circle
                                        : Icons.check_circle_outline,
                                    color: reservationConteroller
                                            .agreePrivacy.isTrue
                                        ? CatchmongColors.yellow_main
                                        : CatchmongColors.gray400,
                                    size: 24,
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "[필수]",
                                style: TextStyle(
                                  color: CatchmongColors.red,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "개인정보 수집 및 이용에 동의합니다.",
                                style: TextStyle(
                                  color: CatchmongColors.gray_800,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      //이용동의 안내 카드
                      ,
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: width,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            )),
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Text(
                          "개인정보 수집 및 이용동의 안내 \n내용작성해주세요.  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          style: TextStyle(
                            color: CatchmongColors.sub_gray,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  ).then((_) {
    // controller.reservationNameController.clear();
    // controller.reservationDescriptionController.clear();
    // controller.selectedDayType.value = "평일";
    // controller.selectedStartTime.value = DateTime.now();
    // controller.selectedEndTime.value = DateTime.now();
    // controller.selectedMinuteType.value = "30분";
    // controller.tableNumTxtController.clear();
    // controller.selectedNumOfPeople.clear();
    // controller.selectedSettingImage.value = null;
  });
}

void showReservationConfirm(BuildContext context, ReservationSetting setting) {
  double width = MediaQuery.of(context).size.width;
  final PartnerController controller = Get.find<PartnerController>();
  final ReservationConteroller reservationConteroller =
      Get.find<ReservationConteroller>();
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      List<DateTime> timeSlots = reservationConteroller.getTimeSlots(
          setting.startTime, setting.endTime, setting.timeUnit);
      List<String> peopleNumString = setting.allowedPeople.split(',');

      // 2. 숫자 추출 및 변환
      List<int> numbers = peopleNumString.map((item) {
        return int.parse(item.replaceAll(RegExp(r'[^0-9]'), ''));
      }).toList();
      RxString formatConfirmDateTime(DateTime date) {
        // 요일 이름 리스트
        List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];

        // 월, 일, 시간 포맷
        String formattedDate = DateFormat('MM.dd').format(date); // MM.dd 형식
        String formattedTime = DateFormat('HH:mm').format(date); // HH:mm 형식
        String weekday = weekdays[date.weekday - 1]; // 요일 추출 (1부터 시작)

        return '$formattedDate ($weekday) $formattedTime'.obs;
      }

      return Scaffold(
        backgroundColor: CatchmongColors.gray50,
        appBar: CloseAppbar(
          title: "예약완료",
          // onClose: () {
          //   reservationConteroller.selectedReservationDate.value =
          //       DateTime.now();
          //   reservationConteroller.selectedReservationTimeIdx.value = 0;
          //   reservationConteroller.selectedReservationNumOfPeopleIdx.value = 0;
          //   reservationConteroller.reservationReqController.clear();
          //   reservationConteroller.agreePrivacy.value = false;
          // },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/file-edit-icon.svg'),
                          Text(
                            "신청 후 확정 매장",
                            style: TextStyle(
                              color: CatchmongColors.gray_800,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "업체에서 확인 후 예약을 확정합니다.",
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200, // 카드의 높이와 동일하게 설정

                    child: ImgCard(
                      path: !setting.reservationImage!.contains("uploads")
                          ? setting.reservationImage!
                          : "http://$myPort:3000/${setting.reservationImage!}",
                      width: double.infinity, // 부모의 너비에 맞게 확장
                      height: double.infinity, // 부모의 높이에 맞게 확장
                      isLocal: !setting.reservationImage!.contains("uploads"),
                    )),
                //예약 안내문
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: 128,
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 10,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reservationConteroller.formatReservationPeriod(
                            setting.startTime, setting.endTime),
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "*예약은 최소 1시간전 시간부터 가능합니다.\n예약 시간맞춰서 방문 부탁드립니다.\n*${setting.description ?? ""}",
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 3, // 최대 줄 수
                        overflow: TextOverflow.ellipsis, // 초과된 텍스트를 ...로 표시
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
//예약 완료했을때 뜨는거
                Container(
                  width: width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SvgPicture.asset('assets/images/check.svg'),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "마이페이지에서 내 예약을 확인하세요!",
                        style: TextStyle(
                          color: CatchmongColors.sub_gray,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: CatchmongColors.gray100,
                            )),
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reservationConteroller.formatReservationPeriod(
                                  setting.startTime, setting.endTime),
                              style: TextStyle(
                                color: CatchmongColors.gray_800,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width: 120,
                                    child: Text(
                                      "일정",
                                      style: TextStyle(
                                        color: CatchmongColors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    )),
                                Text(
                                  formatConfirmDateTime(DateTime(
                                    reservationConteroller
                                        .selectedReservationDate
                                        .value
                                        .year, // 연도
                                    reservationConteroller
                                        .selectedReservationDate
                                        .value
                                        .month, // 월
                                    reservationConteroller
                                        .selectedReservationDate.value.day, // 일
                                    timeSlots[reservationConteroller
                                            .selectedReservationTimeIdx.value]
                                        .hour, // 시간
                                    timeSlots[reservationConteroller
                                            .selectedReservationTimeIdx.value]
                                        .minute, // 분
                                    timeSlots[reservationConteroller
                                            .selectedReservationTimeIdx.value]
                                        .second, // 초 (선택적)
                                    timeSlots[reservationConteroller
                                            .selectedReservationTimeIdx.value]
                                        .millisecond, // 밀리초 (선택적)
                                    timeSlots[reservationConteroller
                                            .selectedReservationTimeIdx.value]
                                        .microsecond, // 마이크로초 (선택적)
                                  )).value,
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width: 120,
                                    child: Text(
                                      "인원",
                                      style: TextStyle(
                                        color: CatchmongColors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    )),
                                Text(
                                  "${numbers[reservationConteroller.selectedReservationNumOfPeopleIdx.value]}명",
                                  style: TextStyle(
                                    color: CatchmongColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width: 120,
                                    child: Text(
                                      "요청사항",
                                      style: TextStyle(
                                        color: CatchmongColors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    )),
                                Expanded(
                                  child: Text(
                                    reservationConteroller
                                        .reservationReqController.text,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: CatchmongColors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 36,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ).then((_) {
    reservationConteroller.selectedReservationDate.value = DateTime.now();
    reservationConteroller.selectedReservationTimeIdx.value = 0;
    reservationConteroller.selectedReservationNumOfPeopleIdx.value = 0;
    reservationConteroller.reservationReqController.clear();
    reservationConteroller.agreePrivacy.value = false;
  });
}

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri phoneUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    // 에러 처리를 할 수 있습니다.
    print("전화 연결 실패");
  }
}
