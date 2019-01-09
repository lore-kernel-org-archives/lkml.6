Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED636C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEEF20700
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfAIOTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:19:15 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:46706 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbfAIOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:19:14 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 7B11567A8CB;
        Wed,  9 Jan 2019 15:19:09 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 9 Jan 2019
 15:19:09 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 9 Jan 2019 15:19:09 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Topic: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUpzP4PV9+XjynmUWrRoOqEAtjTqWm7WUA
Date:   Wed, 9 Jan 2019 14:19:08 +0000
Message-ID: <7188c406-3dd2-88a6-b6ed-d5e8bf678df8@kontron.de>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <D484D617F02B3D468BA088497AB4F7A5@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 7B11567A8CB.A005C
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh@kernel.org,
        shawnguo@kernel.org, yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDEuMTkgMTA6MjQsIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+IC0gQWRkIGRy
aXZlciBmb3IgTlhQIEZsZXhTUEkgaG9zdCBjb250cm9sbGVyDQo+IA0KPiAgIEZsZXhTUEkgaXMg
YSBmbGV4c2libGUgU1BJIGhvc3QgY29udHJvbGxlciBbMV0sIENoYXB0ZXIgMzAgcGFnZSAxNDc1
LA0KPiAgIHdoaWNoIHN1cHBvcnRzIHR3byBTUEkgY2hhbm5lbHMgYW5kIHVwIHRvIDQgZXh0ZXJu
YWwgZGV2aWNlcy4NCj4gICBFYWNoIGNoYW5uZWwgc3VwcG9ydHMgU2luZ2xlL0R1YWwvUXVhZC9P
Y3RhbCBtb2RlIGRhdGEgdHJhbnNmZXIgKDEvMi80LzggYmlkaXJlY3Rpb25hbCBkYXRhIGxpbmVz
KQ0KPiAgIGkuZS4gRmxleFNQSSBhY3RzIGFzIGFuIGludGVyZmFjZSB0byBleHRlcm5hbCBkZXZp
Y2VzLCBtYXhpbXVtIDQsIGVhY2ggd2l0aCB1cCB0byA4DQo+ICAgYmlkaXJlY3Rpb25hbCBkYXRh
IGxpbmVzLg0KPiANCj4gLSBUZXN0ZWQgdGhpcyBkcml2ZXIgd2l0aCBtdGRfZGVidWcoRXJhc2Uv
V3JpdGUvUmVhZCkgdXRpbGl0eSBhbmQgSkZGUzINCj4gICBmaWxlc3lzdGVtIG1vdW50aW5nIGFu
ZCBib290aW5nIG9uIE5YUCBMWDIxNjBBUkRCWzJdIGFuZCBMWDIxNjBBUURTIHRhcmdldHMuDQo+
ICAgTFgyMTYwQVJEQiBpcyBoYXZpbmcgdHdvIE5PUiBzbGF2ZSBkZXZpY2UgY29ubmVjdGVkIG9u
IHNpbmdsZSBidXMgQQ0KPiAgIGkuZS4gQTAgYW5kIEExIChDUzAgYW5kIENTMSkuDQo+ICAgTFgy
MTYwQVFEUyBpcyBoYXZpbmcgdHdvIE5PUiBzbGF2ZSBkZXZpY2UgY29ubmVjdGVkIG9uIHNlcGFy
YXRlIGJ1c2VzDQo+ICAgb25lIGZsYXNoIG9uIEEwIGFuZCBzZWNvbmQgb24gQjEgaS5lLiAoQ1Mw
IGFuZCBDUzMpLg0KPiAgIFZlcmlmaWVkIHRoaXMgZHJpdmVyIG9uIGZvbGxvd2luZyBTUEkgTk9S
IGZsYXNoZXM6DQo+ICAgICBNaWNyb24sIG10MzV4dTUxMmFiYSwgW1JlYWQgLSAxIGJpdCBtb2Rl
XQ0KPiAgICAgQ3lwcmVzcywgczI1Zmw1MTJzLCBbUmVhZCAtIDEvMi80IGJpdCBtb2RlXQ0KPiAN
Cj4gWzFdIGh0dHBzOi8vd3d3Lm54cC5jb20vZG9jcy9lbi9yZWZlcmVuY2UtbWFudWFsL0lNWFJU
MTA1MFJNLnBkZg0KPiBbMl0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xp
bnV4LWFybS1rZXJuZWwvbGlzdC8/c3VibWl0dGVyPTE4MjA5Nw0KPiANCj4gWW9nZXNoIE5hcmF5
YW4gR2F1ciAoNSk6DQo+ICAgIHNwaTogc3BpLW1lbTogQWRkIGRyaXZlciBmb3IgTlhQIEZsZXhT
UEkgY29udHJvbGxlcg0KPiAgICBkdC1iaW5kaW5nczogc3BpOiBhZGQgYmluZGluZyBmaWxlIGZv
ciBOWFAgRmxleFNQSSBjb250cm9sbGVyDQo+ICAgIGFybTY0OiBkdHM6IGx4MjE2MGE6IGFkZCBG
bGV4U1BJIG5vZGUgcHJvcGVydHkNCj4gICAgYXJtNjQ6IGRlZmNvbmZpZzogZW5hYmxlIE5YUCBG
bGV4U1BJIGRyaXZlcg0KPiAgICBNQUlOVEFJTkVSUzogYWRkIG1haW50YWluZXJzIGZvciB0aGUg
TlhQIEZsZXhTUEkgZHJpdmVyDQo+IA0KPiBDaGFuZ2VzIGZvciB2NjoNCj4gLSBSZWJhc2Ugb24g
dG9wIG9mIHY1LjAtcmMxLg0KDQpZb3VyIHBhdGNoZXMgZG9uJ3QgYXBwbHkgdG8gdjUuMC1yYzEu
IEl0IHNlZW1zIGxpa2UgeW91IGhhdmUgaW5zdGVhZCANCnJlYmFzZWQgb250byB0aGUgZm9yLTUu
MSBvciBmb3ItbmV4dCBicmFuY2ggb2YgdGhlIFNQSSB0cmVlLiBJIGd1ZXNzIA0KdGhpcyBpcyBv
a2F5LCBidXQgeW91IHNob3VsZCBoYXZlIHBvaW50ZWQgdGhhdCBvdXQgY29ycmVjdGx5IGhlcmUu
DQoNCj4gLSBJbmNvcnBvcmF0ZWQgcmV2aWV3IGNvbW1lbnRzIGZvcg0KPiAgICBwYXRjaCAnc3Bp
OiBzcGktbWVtOiBBZGQgZHJpdmVyIGZvciBOWFAgRmxleFNQSSBjb250cm9sbGVyJy4NCj4gLSBV
cGRhdGVkIHMtYiB0YWcgaW4gYWxsIHBhdGNoZXMuDQo+IENoYW5nZXMgZm9yIHY1Og0KPiAtIFJl
YmFzZSBvbiB0b3Agb2YgdjQuMjAtcmMyDQo+IC0gSW5jb3Jwb3JhdGVkIHJldmlldyBjb21tZW50
cyBmb3INCj4gICAgcGF0Y2ggJ3NwaTogc3BpLW1lbTogQWRkIGRyaXZlciBmb3IgTlhQIEZsZXhT
UEkgY29udHJvbGxlcicuDQo+IENoYW5nZXMgZm9yIHY0Og0KPiAtIEluY29ycG9yYXRlZCByZXZp
ZXcgY29tbWVudHMgZm9yDQo+ICAgIHBhdGNoICdzcGk6IHNwaS1tZW06IEFkZCBkcml2ZXIgZm9y
IE5YUCBGbGV4U1BJIGNvbnRyb2xsZXInLg0KPiAtIEluY29ycG9yYXRlZCBiaW5kaW5nIGZpbGUg
cmV2aWV3IGNvbW1lbnRzLg0KPiBDaGFuZ2VzIGZvciB2MzoNCj4gLSBJbmNvcnBvcmF0ZWQgcmV2
aWV3IGNvbW1lbnRzIGZvcg0KPiAgICBwYXRjaCAnc3BpOiBzcGktbWVtOiBBZGQgZHJpdmVyIGZv
ciBOWFAgRmxleFNQSSBjb250cm9sbGVyJy4NCj4gQ2hhbmdlcyBmb3IgdjI6DQo+IC0gSW5jb3Jw
b3JhdGVkIEJvcmlzIHJldmlldyBjb21tZW50cyBhbmQgZHJvcCBiZWxvdyBwYXRjaGVzIGFzIHBl
ciB0aGUgY29tbWVudHMuDQo+ICAgLSBQYXRjaCAnc3BpOiBhZGQgc2xhdmUgZGV2aWNlIHNpemUg
aW4gc3BpX2RldmljZSBzdHJ1Y3QnDQo+ICAgLSBQYXRjaCAnc3BpOiBhZGQgZmxhZ3MgZm9yIG9j
dGFsIEkvTyBkYXRhIHRyYW5zZmVyJw0KPiAtIEluY29ycG9yYXRlZCBEVFMgYW5kIEJpbmRpbmcg
ZmlsZSByZXZpZXcgY29tbWVudHMgb2YgU2hhd24gR3VvIGFuZCBSb2IgSGVycmluZy4NCj4gDQo+
ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1ueHAtZnNwaS50eHQgIHwgICAzOSAr
DQo+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
NyArDQo+ICAgLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzICAgIHwg
ICAyMiArDQo+ICAgLi4uL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNp
IHwgICAxMyArDQo+ICAgYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAg
ICAgIHwgICAgMSArDQo+ICAgZHJpdmVycy9zcGkvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAxMCArDQo+ICAgZHJpdmVycy9zcGkvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAgMSArDQo+ICAgZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLmMgICAgICAg
ICAgICAgICAgICAgIHwgMTA5NSArKysrKysrKysrKysrKysrKw0KPiAgIDggZmlsZXMgY2hhbmdl
ZCwgMTE4OCBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLW54cC1mc3BpLnR4dA0KPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYw0KPiA=
