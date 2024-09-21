// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Главная`
  String get main {
    return Intl.message(
      'Главная',
      name: 'main',
      desc: '',
      args: [],
    );
  }

  /// `История`
  String get history {
    return Intl.message(
      'История',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Помощь`
  String get support {
    return Intl.message(
      'Помощь',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Профиль`
  String get profile {
    return Intl.message(
      'Профиль',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Подробнее`
  String get moreDetailed {
    return Intl.message(
      'Подробнее',
      name: 'moreDetailed',
      desc: '',
      args: [],
    );
  }

  /// `Услуги`
  String get services {
    return Intl.message(
      'Услуги',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Поиск врача`
  String get findADoctor {
    return Intl.message(
      'Поиск врача',
      name: 'findADoctor',
      desc: '',
      args: [],
    );
  }

  /// `Консультация и лечение не выходя из дома`
  String get houseCall {
    return Intl.message(
      'Консультация и лечение не выходя из дома',
      name: 'houseCall',
      desc: '',
      args: [],
    );
  }

  /// `Найти`
  String get find {
    return Intl.message(
      'Найти',
      name: 'find',
      desc: '',
      args: [],
    );
  }

  /// `Онлайн консультация`
  String get onlineConsultation {
    return Intl.message(
      'Онлайн консультация',
      name: 'onlineConsultation',
      desc: '',
      args: [],
    );
  }

  /// `Онлайн`
  String get online {
    return Intl.message(
      'Онлайн',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `Услуги процедурного кабинета у вас дома`
  String get serviceProcessOnHome {
    return Intl.message(
      'Услуги процедурного кабинета у вас дома',
      name: 'serviceProcessOnHome',
      desc: '',
      args: [],
    );
  }

  /// `Куда вызвать врача?`
  String get whereCallDoctor {
    return Intl.message(
      'Куда вызвать врача?',
      name: 'whereCallDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Ваш адрес`
  String get yourAddress {
    return Intl.message(
      'Ваш адрес',
      name: 'yourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Добавить новый адрес`
  String get addressNewAddress {
    return Intl.message(
      'Добавить новый адрес',
      name: 'addressNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Укажите адрес`
  String get specifyTheAddress {
    return Intl.message(
      'Укажите адрес',
      name: 'specifyTheAddress',
      desc: '',
      args: [],
    );
  }

  /// `Адрес`
  String get address {
    return Intl.message(
      'Адрес',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Квартира, подъезд, домофон`
  String get appartEntranceIntercom {
    return Intl.message(
      'Квартира, подъезд, домофон',
      name: 'appartEntranceIntercom',
      desc: '',
      args: [],
    );
  }

  /// `Сохранить`
  String get save {
    return Intl.message(
      'Сохранить',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Детали адреса`
  String get addressDetail {
    return Intl.message(
      'Детали адреса',
      name: 'addressDetail',
      desc: '',
      args: [],
    );
  }

  /// `Квартира`
  String get appartamnet {
    return Intl.message(
      'Квартира',
      name: 'appartamnet',
      desc: '',
      args: [],
    );
  }

  /// `Подъезд`
  String get entrance {
    return Intl.message(
      'Подъезд',
      name: 'entrance',
      desc: '',
      args: [],
    );
  }

  /// `Домофон`
  String get intercom {
    return Intl.message(
      'Домофон',
      name: 'intercom',
      desc: '',
      args: [],
    );
  }

  /// `Этаж`
  String get floor {
    return Intl.message(
      'Этаж',
      name: 'floor',
      desc: '',
      args: [],
    );
  }

  /// `Комментарий`
  String get comments {
    return Intl.message(
      'Комментарий',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Назад`
  String get back {
    return Intl.message(
      'Назад',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `История заказов`
  String get orderHistory {
    return Intl.message(
      'История заказов',
      name: 'orderHistory',
      desc: '',
      args: [],
    );
  }

  /// `Вызов {doctor} в `
  String callingTherapistIn(Object doctor) {
    return Intl.message(
      'Вызов $doctor в ',
      name: 'callingTherapistIn',
      desc: '',
      args: [doctor],
    );
  }

  /// `Помощь с заказом`
  String get helpToOrder {
    return Intl.message(
      'Помощь с заказом',
      name: 'helpToOrder',
      desc: '',
      args: [],
    );
  }

  /// `Детали заказа`
  String get orderDetail {
    return Intl.message(
      'Детали заказа',
      name: 'orderDetail',
      desc: '',
      args: [],
    );
  }

  /// `Терапевт`
  String get therapist {
    return Intl.message(
      'Терапевт',
      name: 'therapist',
      desc: '',
      args: [],
    );
  }

  /// `Врач`
  String get doctor {
    return Intl.message(
      'Врач',
      name: 'doctor',
      desc: '',
      args: [],
    );
  }

  /// `Время`
  String get date {
    return Intl.message(
      'Время',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Сумма`
  String get amount {
    return Intl.message(
      'Сумма',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Статус`
  String get status {
    return Intl.message(
      'Статус',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Симптомы`
  String get symptoms {
    return Intl.message(
      'Симптомы',
      name: 'symptoms',
      desc: '',
      args: [],
    );
  }

  /// `Обновить`
  String get update {
    return Intl.message(
      'Обновить',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Установите обновление`
  String get installUpdate {
    return Intl.message(
      'Установите обновление',
      name: 'installUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Технические работы`
  String get technicalWork {
    return Intl.message(
      'Технические работы',
      name: 'technicalWork',
      desc: '',
      args: [],
    );
  }

  /// `Чиним, пилим :)`
  String get chillAndWork {
    return Intl.message(
      'Чиним, пилим :)',
      name: 'chillAndWork',
      desc: '',
      args: [],
    );
  }

  /// `Уведомить о завершение`
  String get notifyCompletion {
    return Intl.message(
      'Уведомить о завершение',
      name: 'notifyCompletion',
      desc: '',
      args: [],
    );
  }

  /// `Упс...что-то пошло нитак!`
  String get somethingWentWrong {
    return Intl.message(
      'Упс...что-то пошло нитак!',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Создать новый аккаунт`
  String get createNewAccount {
    return Intl.message(
      'Создать новый аккаунт',
      name: 'createNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Введите номер телефона в поле ниже, чтобы продолжить регистрацию`
  String get enterPhoneNumberInBottomTextField {
    return Intl.message(
      'Введите номер телефона в поле ниже, чтобы продолжить регистрацию',
      name: 'enterPhoneNumberInBottomTextField',
      desc: '',
      args: [],
    );
  }

  /// `Регистрируясь, вы соглашаетесь с условиями `
  String get registeringYouAgreeToThe {
    return Intl.message(
      'Регистрируясь, вы соглашаетесь с условиями ',
      name: 'registeringYouAgreeToThe',
      desc: '',
      args: [],
    );
  }

  /// `Правила конфиденциальности`
  String get privacyPolicy {
    return Intl.message(
      'Правила конфиденциальности',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Продолжить регистрацию`
  String get continueRegistration {
    return Intl.message(
      'Продолжить регистрацию',
      name: 'continueRegistration',
      desc: '',
      args: [],
    );
  }

  /// `У вас есть аккаунт?`
  String get doYouHaveAccount {
    return Intl.message(
      'У вас есть аккаунт?',
      name: 'doYouHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get enter {
    return Intl.message(
      'Войти',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Подтверждение кода`
  String get conformCode {
    return Intl.message(
      'Подтверждение кода',
      name: 'conformCode',
      desc: '',
      args: [],
    );
  }

  /// `Мы отправили 6 значный код подтверждение на ваш номер телефона`
  String get weSendConformCodeToNumber {
    return Intl.message(
      'Мы отправили 6 значный код подтверждение на ваш номер телефона',
      name: 'weSendConformCodeToNumber',
      desc: '',
      args: [],
    );
  }

  /// `Повторно отправить через `
  String get resentCodeAfter {
    return Intl.message(
      'Повторно отправить через ',
      name: 'resentCodeAfter',
      desc: '',
      args: [],
    );
  }

  /// `Неверный код подтверждения!`
  String get incorrectConformCode {
    return Intl.message(
      'Неверный код подтверждения!',
      name: 'incorrectConformCode',
      desc: '',
      args: [],
    );
  }

  /// `Создать пароль`
  String get createPassword {
    return Intl.message(
      'Создать пароль',
      name: 'createPassword',
      desc: '',
      args: [],
    );
  }

  /// `Пароль должен содержать не менее 8 знаков, включать буквы, цифры и специальные символы`
  String get passwordMustHaveAtLessEight {
    return Intl.message(
      'Пароль должен содержать не менее 8 знаков, включать буквы, цифры и специальные символы',
      name: 'passwordMustHaveAtLessEight',
      desc: '',
      args: [],
    );
  }

  /// `Пароль`
  String get password {
    return Intl.message(
      'Пароль',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Повторите пароль`
  String get repeatPassword {
    return Intl.message(
      'Повторите пароль',
      name: 'repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Данные аккаунта`
  String get accountData {
    return Intl.message(
      'Данные аккаунта',
      name: 'accountData',
      desc: '',
      args: [],
    );
  }

  /// `Введите в поле ниже свой ИИН для заполнение ваших данных`
  String get enterIinNumberToData {
    return Intl.message(
      'Введите в поле ниже свой ИИН для заполнение ваших данных',
      name: 'enterIinNumberToData',
      desc: '',
      args: [],
    );
  }

  /// `Не гражданин Казахстана`
  String get notKzCitizen {
    return Intl.message(
      'Не гражданин Казахстана',
      name: 'notKzCitizen',
      desc: '',
      args: [],
    );
  }

  /// `ИИН`
  String get iin {
    return Intl.message(
      'ИИН',
      name: 'iin',
      desc: '',
      args: [],
    );
  }

  /// `Ваше имя`
  String get yourName {
    return Intl.message(
      'Ваше имя',
      name: 'yourName',
      desc: '',
      args: [],
    );
  }

  /// `Ваша фамилия`
  String get yourSecondName {
    return Intl.message(
      'Ваша фамилия',
      name: 'yourSecondName',
      desc: '',
      args: [],
    );
  }

  /// `Поддержка`
  String get supporting {
    return Intl.message(
      'Поддержка',
      name: 'supporting',
      desc: '',
      args: [],
    );
  }

  /// `Добро пожаловать!`
  String get welcomeTo {
    return Intl.message(
      'Добро пожаловать!',
      name: 'welcomeTo',
      desc: '',
      args: [],
    );
  }

  /// `Введите номер телефона в поле ниже, чтобы авторизоваться`
  String get enterNumberToAuth {
    return Intl.message(
      'Введите номер телефона в поле ниже, чтобы авторизоваться',
      name: 'enterNumberToAuth',
      desc: '',
      args: [],
    );
  }

  /// `Забыл пароль`
  String get forgetPassword {
    return Intl.message(
      'Забыл пароль',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Восстановление пароля`
  String get passwordRecovery {
    return Intl.message(
      'Восстановление пароля',
      name: 'passwordRecovery',
      desc: '',
      args: [],
    );
  }

  /// `Код подтверждение`
  String get conformCOde {
    return Intl.message(
      'Код подтверждение',
      name: 'conformCOde',
      desc: '',
      args: [],
    );
  }

  /// `Введите номер телефона по которому зарегистрировались`
  String get enterNumberYouRegistered {
    return Intl.message(
      'Введите номер телефона по которому зарегистрировались',
      name: 'enterNumberYouRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Новый пароль`
  String get newPassword {
    return Intl.message(
      'Новый пароль',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Произошла ошибка`
  String get errorOccurred {
    return Intl.message(
      'Произошла ошибка',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Введенные пароли не совпадают`
  String get errorRepPasswordMismatch {
    return Intl.message(
      'Введенные пароли не совпадают',
      name: 'errorRepPasswordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Подтвердить данные`
  String get conformData {
    return Intl.message(
      'Подтвердить данные',
      name: 'conformData',
      desc: '',
      args: [],
    );
  }

  /// `Уведомления`
  String get notification {
    return Intl.message(
      'Уведомления',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Регион`
  String get region {
    return Intl.message(
      'Регион',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `Настройка`
  String get setting {
    return Intl.message(
      'Настройка',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Контакты`
  String get contact {
    return Intl.message(
      'Контакты',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faq {
    return Intl.message(
      'FAQ',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Выйти из аккаунта`
  String get logOutAccount {
    return Intl.message(
      'Выйти из аккаунта',
      name: 'logOutAccount',
      desc: '',
      args: [],
    );
  }

  /// `Неверные данные`
  String get incorrectData {
    return Intl.message(
      'Неверные данные',
      name: 'incorrectData',
      desc: '',
      args: [],
    );
  }

  /// `Мой адрес`
  String get myAddress {
    return Intl.message(
      'Мой адрес',
      name: 'myAddress',
      desc: '',
      args: [],
    );
  }

  /// `Предоставьте информацию о вашем местоположении, чтобы наши сотрудники могли вовремя прибыть по адресу.`
  String get setInfoAboutAddressForCallDoctor {
    return Intl.message(
      'Предоставьте информацию о вашем местоположении, чтобы наши сотрудники могли вовремя прибыть по адресу.',
      name: 'setInfoAboutAddressForCallDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Изменить`
  String get change {
    return Intl.message(
      'Изменить',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Ваш профиль`
  String get yourProfile {
    return Intl.message(
      'Ваш профиль',
      name: 'yourProfile',
      desc: '',
      args: [],
    );
  }

  /// `Информация используется исключительно для обработки данных и ни в коем случае не передается третьим лицам.`
  String get infoAboutUserUsedOnlyForUs {
    return Intl.message(
      'Информация используется исключительно для обработки данных и ни в коем случае не передается третьим лицам.',
      name: 'infoAboutUserUsedOnlyForUs',
      desc: '',
      args: [],
    );
  }

  /// `Добавить`
  String get add {
    return Intl.message(
      'Добавить',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Отчество (Необезательно)`
  String get middleNameNotImportant {
    return Intl.message(
      'Отчество (Необезательно)',
      name: 'middleNameNotImportant',
      desc: '',
      args: [],
    );
  }

  /// `Дата рождения`
  String get dateOfBirth {
    return Intl.message(
      'Дата рождения',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Пол`
  String get gender {
    return Intl.message(
      'Пол',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `У Вас возникли вопросы - наши менеджера помогут Вам.`
  String get ifYouHaveQuestionChatManager {
    return Intl.message(
      'У Вас возникли вопросы - наши менеджера помогут Вам.',
      name: 'ifYouHaveQuestionChatManager',
      desc: '',
      args: [],
    );
  }

  /// `Чат`
  String get chat {
    return Intl.message(
      'Чат',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Позвонить менеджеру`
  String get callToManager {
    return Intl.message(
      'Позвонить менеджеру',
      name: 'callToManager',
      desc: '',
      args: [],
    );
  }

  /// `Сообщество`
  String get community {
    return Intl.message(
      'Сообщество',
      name: 'community',
      desc: '',
      args: [],
    );
  }

  /// `Язык приложения`
  String get applicationLanguage {
    return Intl.message(
      'Язык приложения',
      name: 'applicationLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Удаление аккаунта`
  String get deleteAccount {
    return Intl.message(
      'Удаление аккаунта',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Оцените услуги врача`
  String get rateDoctorService {
    return Intl.message(
      'Оцените услуги врача',
      name: 'rateDoctorService',
      desc: '',
      args: [],
    );
  }

  /// `Вы завершили заказ.`
  String get youClosedOrder {
    return Intl.message(
      'Вы завершили заказ.',
      name: 'youClosedOrder',
      desc: '',
      args: [],
    );
  }

  /// `Благодарю за оценку нашей работы.`
  String get thankYouFirReview {
    return Intl.message(
      'Благодарю за оценку нашей работы.',
      name: 'thankYouFirReview',
      desc: '',
      args: [],
    );
  }

  /// `Выберите пол`
  String get selectSex {
    return Intl.message(
      'Выберите пол',
      name: 'selectSex',
      desc: '',
      args: [],
    );
  }

  /// `Мужской`
  String get male {
    return Intl.message(
      'Мужской',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Женский`
  String get female {
    return Intl.message(
      'Женский',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Добавить адрес`
  String get addAddress {
    return Intl.message(
      'Добавить адрес',
      name: 'addAddress',
      desc: '',
      args: [],
    );
  }

  /// `Карта`
  String get map {
    return Intl.message(
      'Карта',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Номер дома`
  String get appartamentNumber {
    return Intl.message(
      'Номер дома',
      name: 'appartamentNumber',
      desc: '',
      args: [],
    );
  }

  /// `Выбрать адрес`
  String get selectAddress {
    return Intl.message(
      'Выбрать адрес',
      name: 'selectAddress',
      desc: '',
      args: [],
    );
  }

  /// `Способ оплаты`
  String get paymentMethod {
    return Intl.message(
      'Способ оплаты',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Привязать карту`
  String get linkCard {
    return Intl.message(
      'Привязать карту',
      name: 'linkCard',
      desc: '',
      args: [],
    );
  }

  /// `Новая карта`
  String get newCard {
    return Intl.message(
      'Новая карта',
      name: 'newCard',
      desc: '',
      args: [],
    );
  }

  /// `Удалить способ оплаты?`
  String get deletePaymentWay {
    return Intl.message(
      'Удалить способ оплаты?',
      name: 'deletePaymentWay',
      desc: '',
      args: [],
    );
  }

  /// `Да`
  String get yes {
    return Intl.message(
      'Да',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Нет`
  String get net {
    return Intl.message(
      'Нет',
      name: 'net',
      desc: '',
      args: [],
    );
  }

  /// `Номер карты`
  String get cardNumber {
    return Intl.message(
      'Номер карты',
      name: 'cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Срок действия`
  String get validityPeriod {
    return Intl.message(
      'Срок действия',
      name: 'validityPeriod',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get cvv {
    return Intl.message(
      'CVV',
      name: 'cvv',
      desc: '',
      args: [],
    );
  }

  /// `Услуги врача`
  String get serviceDoctor {
    return Intl.message(
      'Услуги врача',
      name: 'serviceDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Режим вызова`
  String get callingMode {
    return Intl.message(
      'Режим вызова',
      name: 'callingMode',
      desc: '',
      args: [],
    );
  }

  /// `Вызвать врача сейчас`
  String get callDoctorNow {
    return Intl.message(
      'Вызвать врача сейчас',
      name: 'callDoctorNow',
      desc: '',
      args: [],
    );
  }

  /// `Запланировать вызов`
  String get scheduleCall {
    return Intl.message(
      'Запланировать вызов',
      name: 'scheduleCall',
      desc: '',
      args: [],
    );
  }

  /// `Выбрать специалиста`
  String get chooseSpecialist {
    return Intl.message(
      'Выбрать специалиста',
      name: 'chooseSpecialist',
      desc: '',
      args: [],
    );
  }

  /// `Врачи на ближайшее время`
  String get doctorsForNearTime {
    return Intl.message(
      'Врачи на ближайшее время',
      name: 'doctorsForNearTime',
      desc: '',
      args: [],
    );
  }

  /// `Врачи на `
  String get doctorsFor {
    return Intl.message(
      'Врачи на ',
      name: 'doctorsFor',
      desc: '',
      args: [],
    );
  }

  /// `Дата и время`
  String get dateAndTime {
    return Intl.message(
      'Дата и время',
      name: 'dateAndTime',
      desc: '',
      args: [],
    );
  }

  /// `Утро`
  String get morning {
    return Intl.message(
      'Утро',
      name: 'morning',
      desc: '',
      args: [],
    );
  }

  /// `День`
  String get day {
    return Intl.message(
      'День',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Ночь`
  String get night {
    return Intl.message(
      'Ночь',
      name: 'night',
      desc: '',
      args: [],
    );
  }

  /// `Вечер`
  String get evening {
    return Intl.message(
      'Вечер',
      name: 'evening',
      desc: '',
      args: [],
    );
  }

  /// `Готов`
  String get ready {
    return Intl.message(
      'Готов',
      name: 'ready',
      desc: '',
      args: [],
    );
  }

  /// `Свободных врачей нет`
  String get thereNoAvailableDoctors {
    return Intl.message(
      'Свободных врачей нет',
      name: 'thereNoAvailableDoctors',
      desc: '',
      args: [],
    );
  }

  /// `Посмотреть ближайшее время`
  String get chooseNearTime {
    return Intl.message(
      'Посмотреть ближайшее время',
      name: 'chooseNearTime',
      desc: '',
      args: [],
    );
  }

  /// `Время осмотра`
  String get inspectionTime {
    return Intl.message(
      'Время осмотра',
      name: 'inspectionTime',
      desc: '',
      args: [],
    );
  }

  /// `Сегодня`
  String get today {
    return Intl.message(
      'Сегодня',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Проблема с заказом?`
  String get orderProblem {
    return Intl.message(
      'Проблема с заказом?',
      name: 'orderProblem',
      desc: '',
      args: [],
    );
  }

  /// `Информация`
  String get info {
    return Intl.message(
      'Информация',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Завершить заказ`
  String get closeOrder {
    return Intl.message(
      'Завершить заказ',
      name: 'closeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Оцените услуги врача`
  String get reviewDoctorService {
    return Intl.message(
      'Оцените услуги врача',
      name: 'reviewDoctorService',
      desc: '',
      args: [],
    );
  }

  /// `Продолжить`
  String get continueTxt {
    return Intl.message(
      'Продолжить',
      name: 'continueTxt',
      desc: '',
      args: [],
    );
  }

  /// `Оплата`
  String get payment {
    return Intl.message(
      'Оплата',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Оплатить`
  String get toPay {
    return Intl.message(
      'Оплатить',
      name: 'toPay',
      desc: '',
      args: [],
    );
  }

  /// `Отправить`
  String get send {
    return Intl.message(
      'Отправить',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Завтра`
  String get tomorrow {
    return Intl.message(
      'Завтра',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Поля обязательно к заполнению`
  String get fieldsRequiredToFill {
    return Intl.message(
      'Поля обязательно к заполнению',
      name: 'fieldsRequiredToFill',
      desc: '',
      args: [],
    );
  }

  /// `Адрес успешно добавлен`
  String get addressSuccessAdded {
    return Intl.message(
      'Адрес успешно добавлен',
      name: 'addressSuccessAdded',
      desc: '',
      args: [],
    );
  }

  /// `Адрес успешно изменен`
  String get addressSuccessChanged {
    return Intl.message(
      'Адрес успешно изменен',
      name: 'addressSuccessChanged',
      desc: '',
      args: [],
    );
  }

  /// `Восстановить`
  String get recovery {
    return Intl.message(
      'Восстановить',
      name: 'recovery',
      desc: '',
      args: [],
    );
  }

  /// `Текущий осмотр`
  String get currentCheckup {
    return Intl.message(
      'Текущий осмотр',
      name: 'currentCheckup',
      desc: '',
      args: [],
    );
  }

  /// `Осмотр врача`
  String get checkoutDoctor {
    return Intl.message(
      'Осмотр врача',
      name: 'checkoutDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Перейти`
  String get goOver {
    return Intl.message(
      'Перейти',
      name: 'goOver',
      desc: '',
      args: [],
    );
  }

  /// `Новый пароль был успешно сохранен. Нажмите Войти, чтобы авторизоваться.`
  String get newPasswordHasBeenSaved {
    return Intl.message(
      'Новый пароль был успешно сохранен. Нажмите Войти, чтобы авторизоваться.',
      name: 'newPasswordHasBeenSaved',
      desc: '',
      args: [],
    );
  }

  /// `Код для восстановление пароля был выслан на номер телефона.`
  String get linkSendToPhoneNumber {
    return Intl.message(
      'Код для восстановление пароля был выслан на номер телефона.',
      name: 'linkSendToPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Поле не может быть пустым`
  String get fieldCantBeEmpty {
    return Intl.message(
      'Поле не может быть пустым',
      name: 'fieldCantBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Введите корректное значение`
  String get enterCorrectValue {
    return Intl.message(
      'Введите корректное значение',
      name: 'enterCorrectValue',
      desc: '',
      args: [],
    );
  }

  /// `Карта успешно добавлена.`
  String get cardSuccessAdded {
    return Intl.message(
      'Карта успешно добавлена.',
      name: 'cardSuccessAdded',
      desc: '',
      args: [],
    );
  }

  /// `Карта успеха удалена.`
  String get successCardDeleted {
    return Intl.message(
      'Карта успеха удалена.',
      name: 'successCardDeleted',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
