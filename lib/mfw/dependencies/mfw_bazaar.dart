/*
// PubDev main package: https://pub.dev/packages/flutter_poolakey
// First read this: https://developers.cafebazaar.ir/fa/guidelines/in-app-billing/implementation/flutter#

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poolakey/flutter_poolakey.dart';

import 'mfw_prints.dart';

// --------------------------------------------------------------------------------------------------------------------

// Bazaar IAB utils:

Future<bool> mInitBazaar({required String rsaKey, VoidCallback? onDisconnected, int durationSeconds = 60}) async {
  try {
    bool isConnected = await FlutterPoolakey.connect(rsaKey, onDisconnected: onDisconnected).timeout(Duration(seconds: durationSeconds));
    if (isConnected) {
      mPrintGreen("Bazaar connected");
    }
    return isConnected;
  } on PlatformException catch (platformException) {
    mPrintRed("A PlatformException occured in Bazaar\nCode: ${platformException.code}\nMessage: ${platformException.message}\nDetails: ${platformException.details}");
    return false;
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut init Bazaar\n$e");
    return false;
  } catch (e) {
    mPrintRed(e);
    return false;
  }
}

Future<PurchaseInfo?> mPurchaseInBazaar({required String productID, required String developerPayload}) async {
  try {
    PurchaseInfo purchaseInfo = await FlutterPoolakey.purchase(productID, payload: developerPayload);
    mPrintGreen("Purchase done in Bazaar");
    mPrint(purchaseInfo.toString());
    return purchaseInfo;
  } on PlatformException catch (platformException) {
    mPrintRed("A PlatformException occured in Bazaar\nCode: ${platformException.code}\nMessage: ${platformException.message}\nDetails: ${platformException.details}");
    return null;
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut purchase in Bazaar\n$e");
    return null;
  } catch (e) {
    mPrintRed(e);
    return null;
  }
}

Future<List<PurchaseInfo>?> mGetAllPurchasedProductsInBazaar({int durationSeconds = 20}) async {
  try {
    List<PurchaseInfo> purchases = await FlutterPoolakey.getAllPurchasedProducts().timeout(Duration(seconds: durationSeconds));
    mPrintGreen("Purchases info received in Bazaar");
    mPrint(purchases.toString());
    return purchases;
  } on PlatformException catch (platformException) {
    mPrintRed("A PlatformException occured in Bazaar\nCode: ${platformException.code}\nMessage: ${platformException.message}\nDetails: ${platformException.details}");
    return null;
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut get all purchased products in Bazaar\n$e");
    return null;
  } catch (e) {
    mPrintRed(e);
    return null;
  }
}

Future<bool> mConsumePurchaseInBazaar({required String purchaseToken, int durationSeconds = 20}) async {
  try {
    bool isConsumed = await FlutterPoolakey.consume(purchaseToken).timeout(Duration(seconds: durationSeconds));
    if (isConsumed) {
      mPrintGreen("Purchase consumed in Bazaar");
    }
    return isConsumed;
  } on PlatformException catch (platformException) {
    mPrintRed("A PlatformException occured in Bazaar\nCode: ${platformException.code}\nMessage: ${platformException.message}\nDetails: ${platformException.details}");
    return false;
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut consume purchase in Bazaar\n$e");
    return false;
  } catch (e) {
    mPrintRed(e);
    return false;
  }
}

// --------------------------------------------------------------------------------------------------------------------
*/
