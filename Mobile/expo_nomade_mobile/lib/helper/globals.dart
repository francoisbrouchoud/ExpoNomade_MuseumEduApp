/// Class GlobalConstants contains all global constants used throughout the application.
class GlobalConstants {
  /// Width of container for map filter
  static const double mapFilterContainerWidth = 300;

  /// Height of container for map filter
  static const double mapFilterContainerHeight = 500;

  /// Size of button for map floating button
  static const double mapFilterContainerTop = 160;

  /// Space betwen border and button for map floating button
  static const double mapFloatingButtonSpace = 16;

  /// the max zoom allow in the map.
  static const double mapMaxZoom = 20;

  /// the init zoom in the map.
  static const double mapInitZoom = 10;

  /// the path of the map design
  static const String mapStyleUrl =
      "https://api.mapbox.com/styles/v1/laumey/clk7147pb009801nw2y750jx5/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoibGF1bWV5IiwiYSI6ImNsazcxbWRiZDA1a2kzdHA2OTFzd2JkdmYifQ.8xOnsXZQ7GZprIYer0llfw";

  /// the path of the marker us in map page
  static const String markerMapImagePath = 'assets/images/marker.png';

  /// Size of the marker in the map page.
  static const double markerMapSize = 50;

  /// Filter year number of step.
  static const int stepInYearsFilter = 32;

  /// Height for SizeBox separating two buttons vertically.
  static const double multiButtonVerticalSpacing = 10.0;

  /// Default dimensions for icons displayed in the application.
  static const double iconsDefaultDimension = 24.0;

  /// Default dimensions for image displayed in the application.
  static const double imagesDefaultDimension = 232.0;

  /// Editor block top and bottom margin height.
  static const double blockTopBottomMarginHeight = 15.0;

  /// Editor block to add espace between to block.
  static const double sizeOfTheBlock = 25.0;

  // padding Horizontal for little container
  static const double containerLittlePaddingHorizontal = 40.0;

  /// Application global padding
  static const double appMinPadding = 10.0;

  /// Label margin for custom form widgets containing multiple TextFormFields.
  static const double multiTFFLabelMargin = 20.0;

  /// TextFormField right margin for custom widgets where the TextFormField could be followed by an icon.
  static const double textFormFieldIconRightMargin = 50.0;

  /// Width for bottom border of the UnderLinedContainerWidget.
  static const double ulcBottomBorderWidth = 1.0;

  /// String representing an empty string, used to store translated fields in the database, even if the translation hasn't been input.
  static const String emptyString = "EMPTY";

  /// Minimal number of coordinates to enter for an event BO.
  static const int eventMinCoordinatesNb = 3;

  /// Minimal number of coordinates to enter for an object BO.
  static const int objectMinCoordinatesNb = 1;

  /// Application buttons vertical padding.
  static const double appBtnVertPadding = 10.0;

  /// Application buttons horizontal padding.
  static const double appBtnHorzPadding = 20.0;

  /// Minimum of options in the quiz
  static const int quizOptionMinNb = 2;

  /// Maximum of options in the quiz
  static const int quizOptionMaxNb = 4;

  /// Home page title bottom spacing.
  static const double homePageTitleBSpacing = 50.0;

  /// Home page buttons horizontal spacing.
  static const double homePageMainButtonSpacing = 25.0;

  /// Lang buttons padding.
  static const double langBtnHSpacing = 15.0;

  /// Lang buttons width.
  static const double langBtnWidth = 50.0;

  /// Container margin for the title widget.
  static const double titleWidgetContMargin = 8.0;

  /// Container padding for the title widget.
  static const double titleWidgetContPadding = 12.0;

  /// Default border radius for the application.
  static const double defaultBorderRadius = 16.0;

  /// Text padding for the title widget.
  static const double titleWidgetTextPad = 10.0;

  /// Application default width multiplicator.
  static const double defaultWidgetWidthMult = 0.7;

  /// Quiz page width multiplicator.
  static const double quizPageWidthMult = 0.85;

  /// Quiz default width multiplicator.
  static const double quizWidgetsWidthMult = 0.9;

  /// Ok text message.
  static const String okMsg = "OK";

  /// Container widget before title place holder height.
  static const double cwBefTitlePHH = 60.0;

  /// Container widget after title place holder height.
  static const double cwAftTitlePHH = 30.0;

  /// Container widget container margin.
  static const double cwContMargin = 8.0;

  /// Container widget container padding.
  static const double cwContPadding = 12.0;

  /// Container widget body padding.
  static const double cwBodyPadding = 10.0;

  /// Score submission page padding size.
  static const double quizDefPaddingSize = 16.0;

  /// Results considered very good from...
  static const int resVeryGood = 90;

  /// Results considered good from...
  static const int resGood = 80;

  /// Results considered average from...
  static const int resAvg = 60;

  /// Number of questions randomly taken for the quiz.
  static const int quizQuestionsNb = 5;

  /// Quiz page container margin.
  static const double quizPageContMargin = 8;

  /// Quiz page container padding.
  static const double quizPageContPadding = 12;

  /// InfoPanel & InfoPanelEvent Padding
  static const double infoPanelsPadding = 32;

  /// InfoPanel & InfoPanelEvent Small Spacing
  static const double infoPanelsSmallSpacing = 10;

  /// InfoPanel & InfoPanelEvent Medium Spacing
  static const double infoPanelsMediumSpacing = 20;

  /// Gets now's DateTime formatted for database insert.
  static String getNowFormattedForDB() {
    final DateTime now = DateTime.now();
    return "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}${now.millisecond.toString().padLeft(3, '0')}";
  }
}
