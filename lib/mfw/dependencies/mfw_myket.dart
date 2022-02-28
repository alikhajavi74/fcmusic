/*
// PubDev main package: https://pub.dev/packages/myket_iap
// First read this: https://myket.ir/kb/pages/iab-flutter/
// NOTE: add this permission to your manifest <uses-permission android:name="ir.mservices.market.BILLING" />

import 'dart:async';

import 'package:gymmanager/mfw/dependencies/mfw_prints.dart';
import 'package:myket_iap/myket_iap.dart';
import 'package:myket_iap/util/iab_result.dart';
import 'package:myket_iap/util/inventory.dart';
import 'package:myket_iap/util/purchase.dart';

// --------------------------------------------------------------------------------------------------------------------

// Myket IAB utils:

Future<bool> mInitMyket({required String rsaKey, bool enableDebugLogging = false, int durationSeconds = 60}) async {
  try {
    IabResult? iabResult = await MyketIAP.init(rsaKey: rsaKey, enableDebugLogging: enableDebugLogging).timeout(Duration(seconds: durationSeconds));
    if (iabResult!.isSuccess()) {
      mPrintGreen("Myket connected");
      return true;
    } else {
      mPrintRed("Myket not connected\n${iabResult.mMessage}\n${iabResult.mResponse}");
      return false;
    }
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut init Myket\n$e");
    return false;
  } catch (e) {
    mPrintRed(e);
    return false;
  }
}

Future<Purchase?> mPurchaseInMyket({required String sku, required String developerPayload}) async {
  try {
    Map result = await MyketIAP.launchPurchaseFlow(sku: sku, payload: developerPayload);
    mPrint(result.toString());
    IabResult iabResault = result[MyketIAP.RESULT];
    Purchase purchaseResault = result[MyketIAP.PURCHASE];
    if (iabResault.isSuccess()) {
      mPrintGreen("Purchase done in Myket");
      return purchaseResault;
    }
    mPrintRed("Purchase faild in Myket");

    return null;
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut purchase in Myket\n$e");
    return null;
  } catch (e) {
    mPrintRed(e);
    return null;
  }
}

Future<Purchase?> mGetPurchasedProductInMyket({required String sku, bool querySkuDetails = false, int durationSeconds = 20}) async {
  try {
    Map result = await MyketIAP.getPurchase(sku: sku, querySkuDetails: querySkuDetails).timeout(Duration(seconds: durationSeconds));
    mPrint(result.toString());
    IabResult iabResault = result[MyketIAP.RESULT];
    Purchase purchaseResault = result[MyketIAP.PURCHASE];
    if (iabResault.isSuccess()) {
      mPrintGreen("Purchases info received in myket");
      return purchaseResault;
    }
    mPrintRed("Purchases info not received in myket");
    return null;
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut get all purchased products in Bazaar\n$e");
    return null;
  } catch (e) {
    mPrintRed(e);
    return null;
  }
}

Future<Inventory?> mGetAllPurchasedProductsInMyket({bool querySkuDetails = false, int durationSeconds = 20}) async {
  try {
    Map result = await MyketIAP.queryInventory(querySkuDetails: querySkuDetails).timeout(Duration(seconds: durationSeconds));
    mPrint(result.toString());
    IabResult iabResault = result[MyketIAP.RESULT];
    Inventory inventoryResault = result[MyketIAP.INVENTORY];
    if (iabResault.isSuccess()) {
      mPrintGreen("Purchases info received in myket");
      return inventoryResault;
    }
    mPrintRed("Purchases info not received in myket");
    return null;
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut get all purchased products in Bazaar\n$e");
    return null;
  } catch (e) {
    mPrintRed(e);
    return null;
  }
}

Future<bool> mConsumePurchaseInMyket({required Purchase purchase, int durationSeconds = 20}) async {
  try {
    Map result = await MyketIAP.consume(purchase: purchase).timeout(Duration(seconds: durationSeconds));
    mPrint(result.toString());
    IabResult iabResault = result[MyketIAP.RESULT];
    // Purchase purchaseResault = result[MyketIAP.PURCHASE];
    if (iabResault.isSuccess()) {
      mPrintGreen("Purchase consumed in Myket");
      return true;
    }
    mPrintRed("Purchase not consumed in Myket");
    return false;
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut consume purchase in Myket\n$e");
    return false;
  } catch (e) {
    mPrintRed(e);
    return false;
  }
}

Future<void> mDisposeMyket() async {
  await MyketIAP.dispose();
}

// --------------------------------------------------------------------------------------------------------------------
*/
