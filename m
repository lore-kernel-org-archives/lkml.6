Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB1C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797FB20779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797FB20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJVPVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:21:11 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:12351 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbeJVPVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:21:11 -0400
X-IronPort-AV: E=Sophos;i="5.54,411,1534834800"; 
   d="scan'208";a="21894764"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Oct 2018 00:03:55 -0700
Received: from CHN-SV-EXMX03.mchp-main.com ([fe80::58f5:b949:4b1:3df4]) by
 chn-sv-exch03.mchp-main.com ([fe80::9916:1afa:df82:7a64%13]) with mapi id
 14.03.0352.000; Mon, 22 Oct 2018 00:03:54 -0700
From:   <Nisar.Sayed@microchip.com>
To:     <frieder.schrempf@exceet.de>, <steve.glendinning@shawell.net>,
        <UNGLinuxDriver@microchip.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>
CC:     <oneukum@suse.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: SMSC9730 Autosuspend/Resume Questions
Thread-Topic: SMSC9730 Autosuspend/Resume Questions
Thread-Index: AQHUZi119hv5sadJsU6P217TGUVvCKUq3ZjA
Date:   Mon, 22 Oct 2018 07:03:54 +0000
Message-ID: <CE371C1263339941885964188A0225FA44571A@CHN-SV-EXMX03.mchp-main.com>
References: <69e14429-a4d9-dd5c-5e70-c22086490cc0@exceet.de>
In-Reply-To: <69e14429-a4d9-dd5c-5e70-c22086490cc0@exceet.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.76.4]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRnJpZWRlciwNCg0KPiBIaSwNCj4gDQo+IEkgcmVjZW50bHkgdGVzdGVkIGEgYm9hcmQgd2l0
aCBTTVNDOTczMCBjb25uZWN0ZWQgdmlhIFVTQiBIU0lDIHRvIGFuDQo+IGkuTVg2UyBTT0MuIEkg
dXNlZCB0aGVzZSBwYXRjaGVzIG9uIHRvcCBvZiB2NC4xNC1yYzggZm9yIHRoZSBVU0IgSFNJQw0K
PiBzdXBwb3J0OiBbMV0uDQo+IA0KPiBXaGVuIEkgdHVybmVkIG9uIGF1dG9zdXNwZW5kLCB0aGUg
c21zYzk1eHggc3RvcHBlZCBpbiB0aGUgbWlkZGxlIG9mIHRoZQ0KPiBzdXNwZW5kaW5nIHJvdXRp
bmUgYW5kIC9zeXMvYnVzL3VzYi9kZXZpY2VzL3VzYjMvMy0NCj4gMS9wb3dlci9ydW50aW1lX3N0
YXR1cyByZXBvcnRlZCAic3VzcGVuZGluZyINCj4gZm9yZXZlci4NCj4gDQo+IFdpdGggc29tZSBk
ZWJ1ZyBsb2dzIEkgZm91bmQgb3V0LCB0aGF0IHRoZSBsYXN0IGxpbmUgb2YgY29kZSB0aGF0IHdh
cw0KPiBleGVjdXRlZCBpcyBbMl0sIGFmdGVyIHRoYXQgSSBkaWRuJ3QgZ2V0IGFueSBmdXJ0aGVy
IG1lc3NhZ2VzLg0KPiANCj4gVGhlbiBJIGFwcGxpZWQgdGhlIGZvbGxvd2luZyBkaWZmIGFuZCB0
aGUgc3VzcGVuZC9yZXN1bWUgc3RhcnRlZCB0byB3b3JrDQo+IHJlbGlhYmx5Og0KPiANCj4gQEAg
LTEzODIsMTAgKzEzODUsMTEgQEAgc3RhdGljIGludCBzbXNjOTV4eF9saW5rX29rX25vcG0oc3Ry
dWN0IHVzYm5ldA0KPiAqZGV2KQ0KPiAgICAgICAgICByZXQgPSBzbXNjOTV4eF9tZGlvX3JlYWRf
bm9wbShkZXYtPm5ldCwgbWlpLT5waHlfaWQsIE1JSV9CTVNSKTsNCj4gICAgICAgICAgaWYgKHJl
dCA8IDApDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gLQ0KPiArICAgICAgIC8q
DQo+ICAgICAgICAgIHJldCA9IHNtc2M5NXh4X21kaW9fcmVhZF9ub3BtKGRldi0+bmV0LCBtaWkt
PnBoeV9pZCwgTUlJX0JNU1IpOw0KPiAgICAgICAgICBpZiAocmV0IDwgMCkNCj4gICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiArICAgICAgICovDQo+IA0KPiAgICAgICAgICByZXR1cm4g
ISEocmV0ICYgQk1TUl9MU1RBVFVTKTsNCj4gICB9DQo+IA0KPiBTbyBpdCBzZWVtcyBsaWtlIHRo
ZSBkdW1teSByZWFkLCB0aGF0IGlzIGNvbW1lbnRlZCB3aXRoICJmaXJzdCwgYSBkdW1teQ0KPiBy
ZWFkLCBuZWVkZWQgdG8gbGF0Y2ggc29tZSBNSUkgcGh5cyIgY2F1c2VzIHByb2JsZW1zIGluIG15
IHNldHVwLiBEbyB5b3UNCj4gaGF2ZSBhbiBpZGVhIHdoYXQgY291bGQgYmUgdGhlIHJlYXNvbj8g
SXMgdGhpcyBhIHByb3BlciBmaXg/DQo+DQogDQpMaW5rIHN0YXR1cyBiaXQgaXMgbGF0Y2ggbG93
IHJlZ2lzdGVyIGFuZCBuZWVkcyB0byBiZSByZWFkIHR3aWNlLiBZb3UgbWF5IGdldCB3cm9uZyBM
aW5rIHN0YXR1cyB3aXRoIHRoaXMgZml4Lg0KDQotIE5pc2FyDQo=
