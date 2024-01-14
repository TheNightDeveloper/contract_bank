enum Categorys {
  category1(
      id: 3,
      title: 'ساخت و ساز ',
      imagePath: 'assets/svg/Building permit-bro 1.svg'),
  category2(
      id: 4,
      title: 'مشارکت و سرمایه گذاری',
      imagePath: 'assets/svg/Signing a contract-bro 1.svg'),
  category3(
      id: 5,
      title: 'استخدام و منابع انسانی',
      imagePath: 'assets/svg/Business deal-bro 1.svg'),
  category4(
      id: 6,
      title: 'محافظت از کسب و کار',
      imagePath: 'assets/svg/ISO Certification-bro(1) 1.svg'),
  category5(
      id: 7,
      title: 'پیمانکاری کسب و کار',
      imagePath: 'assets/svg/Paid idea-bro.svg'),
  category6(
      id: 8,
      title: ' خرید و فروش',
      imagePath: 'assets/svg/Car finance-bro 1.svg'),
  category7(
      id: 9, title: 'مالکیت', imagePath: 'assets/svg/Apartment rent-bro.svg'),
  category8(
      id: 10,
      title: 'اجاره',
      imagePath: 'assets/svg/Car rental-bro.svg'), ////// --
  category9(
      id: 11,
      title: 'سایر قرارداد ها',
      imagePath: 'assets/svg/Documents-amico 1.svg');

  final int id;
  final String title;
  final String imagePath;

  const Categorys(
      {required this.id, required this.title, required this.imagePath});
}
