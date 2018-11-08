Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D8CC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2D72081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2D72081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeKHRoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:44:30 -0500
Received: from mail4.tencent.com ([183.57.53.109]:58312 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeKHRoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:44:30 -0500
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail4.tencent.com (Postfix) with ESMTP id CB15450787;
        Thu,  8 Nov 2018 16:10:03 +0800 (CST)
Received: from EXMBX-SZMAIL022.tencent.com ([fe80::dcc:e364:cd45:89d9]) by
 EXHUB-SZMail01.tencent.com ([::1]) with mapi id 14.03.0415.000; Thu, 8 Nov
 2018 16:10:01 +0800
From:   =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
Subject: RE: [PATCH V2] binder: ipc namespace support for android binder
Thread-Topic: [PATCH V2] binder: ipc namespace support for android binder
Thread-Index: AdR3OmFpavZuljQ4RQWTEbQliuhT3g==
Date:   Thu, 8 Nov 2018 08:09:57 +0000
Message-ID: <5FBCBE569E134E4CA167B91C0A77FD610198F8495C@EXMBX-SZMAIL022.tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.96.209.168]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYXZpZGxvaHIgQnVlc28gPGRhdmVAc3Rnb2xhYnMubmV0Pg0KPiBTZW50OiBUaHVy
c2RheSwgTm92ZW1iZXIgOCwgMjAxOCAzOjAwIFBNDQo+IA0KPiBPbiBNb24sIDI5IE9jdCAyMDE4
LCBjaG91cnl6aG91KD8/Pz8/Pykgd3JvdGU6DQo+ID5AQCAtNjMsNiArNjMsMTIgQEAgc3RydWN0
IGlwY19uYW1lc3BhY2Ugew0KPiA+ICAgICAgICB1bnNpZ25lZCBpbnQgICAgbXFfbXNnX2RlZmF1
bHQ7DQo+ID4gICAgICAgIHVuc2lnbmVkIGludCAgICBtcV9tc2dzaXplX2RlZmF1bHQ7DQo+ID4N
Cj4gPisgICAgICAgLyogbmV4dCBmaWVsZHMgYXJlIGZvciBiaW5kZXIgKi8NCj4gPisgICAgICAg
c3RydWN0IG11dGV4ICAgICAgYmluZGVyX3Byb2NzX2xvY2s7DQo+ID4rICAgICAgIHN0cnVjdCBo
bGlzdF9oZWFkIGJpbmRlcl9wcm9jczsNCj4gPisgICAgICAgc3RydWN0IG11dGV4ICAgICAgYmlu
ZGVyX2NvbnRleHRzX2xvY2s7DQo+ID4rICAgICAgIHN0cnVjdCBobGlzdF9oZWFkIGJpbmRlcl9j
b250ZXh0czsNCj4gDQo+IEkgZG9uJ3QgdGhpbmsgeW91IHdhbnQgYSBtdXRleCBoZXJlIHByb3Rl
Y3RpbmcgdGhlIGJpbmRlcl9jb250ZXh0cyBsaXN0Lg0KPiBBZmFpY3QgdGhlcmUgaXMgbm8gY29u
Y3VycmVuY3kgZ29pbmcgb246IHlvdSBvbmx5IG1vZGlmeSBpdCBpbiB3aGVuIGRvaW5nDQo+IG5h
bWVzcGFjZSBpbml0IGFuZCBleGl0IChmb3Igd2hpY2ggeW91IGhhdmUgbm8gc2VyaWFsaXphdGlv
bik7IGRvIHlvdSBldmVuDQo+IG5lZWQgYSBsb2NrIGhlcmU/IE9yIGF0IGxlYXN0IEkgd291bGQg
dGhpbmsgYSBtb3JlIGxpZ2h0d2VpZ2h0IGFsdGVybmF0aXZlDQo+IChyY3Uvc3BpbmxvY2svcnds
b2NrKSB3b3VsZCBzdWZmaWNlLg0KDQpZZXMsIHlvdSdyZSByaWdodCwgdGhlIGJpbmRlcl9jb250
ZXh0cyBpcyBqdXN0IG1vZGlmaWVkIHdoZW4gaW5pdGluZyBhbmQgZXhpdGluZw0KbmFtZXNwYWNl
LCB3ZSBkb24ndCBuZWVkIHRoaXMgbG9jay4NCkkgd2lsbCB1cGRhdGUgdGhlIGNvZGUgeW91IG1l
bnRpb25lZCBhYm92ZS4NCg==
