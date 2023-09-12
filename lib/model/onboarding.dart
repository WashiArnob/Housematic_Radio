class Onbording {
  String image;
  String title;
  String discription;

  Onbording(
      {required this.image, required this.title, required this.discription});
}

List<Onbording> contents = [
  Onbording(
      title: 'Heading One',
      image:
          'assets/images/onboarding-one.png',
      discription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
  Onbording(
      title: 'Heading Two',
      image:
          'assets/images/onboarding-two.png',
      discription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
  Onbording(
      title: 'Heading Three',
      image:
          'assets/images/onboarding-three.png',
      discription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
];
