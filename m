Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DA4C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6C921872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBGKHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:07:01 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:50366 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfBGKHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:07:01 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 89B6065A738;
        Thu,  7 Feb 2019 11:06:57 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 7 Feb 2019
 11:06:57 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Thu, 7 Feb 2019 11:06:57 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: Add support for EN25Q80A
Thread-Topic: [PATCH 1/2] mtd: spi-nor: Add support for EN25Q80A
Thread-Index: AQHUsvEnBk05JSMTaE23Hh40f7Dva6XOJEMAgAX+zQA=
Date:   Thu, 7 Feb 2019 10:06:56 +0000
Message-ID: <52338dfe-aca1-503d-6871-c4be09f1f3ac@kontron.de>
References: <20190123075538.12681-1-frieder.schrempf@kontron.de>
 <f0b2c97b-419a-1e3e-4624-52c60fe32065@microchip.com>
In-Reply-To: <f0b2c97b-419a-1e3e-4624-52c60fe32065@microchip.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <16C277EE8EFCF64CAACF83042236BCC0@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 89B6065A738.ADAF4
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com, richard@nod.at,
        tudor.ambarus@microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVHVkb3IsDQoNCk9uIDAzLjAyLjE5IDE0OjMzLCBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+IEhpLCBGcmllZGVyLA0KPiANCj4gT24gMDEvMjMvMjAxOSAwOTo1NiBBTSwg
U2NocmVtcGYgRnJpZWRlciB3cm90ZToNCj4+IEZyb206IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVk
ZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4+DQo+PiBUaGlzIGFkZHMgc3VwcG9ydCBmb3IgdGhl
IEVPTiBFTjI1UTgwQSwgYSA4TWIgU1BJIE5PUiBjaGlwLg0KPiANCj4gSSB3b3VsZCBzdWdnZXN0
IHRvIHNwZWNpZnkgd2hvIGlzIHVzaW5nIHRoaXMgZmxhc2ggYW5kIGhvdyBkaWQgeW91IHRlc3Qg
aXQuIFRoaXMNCj4gd2F5IHdlIHdpbGwgbm90IGVuZCB1cCB3aXRoIHN1cHBvcnQgZm9yIGZsYXNo
ZXMgdGhhdCBhcmUgbm90IGFjdHVhbGx5IHVzZWQuDQoNCk9rLiBUaGUgZmxhc2ggaXMgdXNlZCBi
eSBhIGJvYXJkIHRoYXQgSSBwbGFuIHRvIHVwc3RyZWFtLiBNYXliZSBJIHNob3VsZCANCmp1c3Qg
cmVzdWJtaXQgdGhpcyB0b2dldGhlciB3aXRoIHRoZSBhY3R1YWwgYm9hcmQgc3VwcG9ydCBwYXRj
aGVzPw0KDQpMaWtld2lzZSBmb3IgbXkgb3RoZXIgcGF0Y2ggKE1YMjVWODAzNUYpLCB0aGlzIGlz
IGZvciBhbm90aGVyIGJvYXJkIEkgDQpwbGFuIHRvIHVwc3RyZWFtIHNvb24uDQoNCj4gDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250
cm9uLmRlPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIHwgMiAr
Kw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9z
cGktbm9yLmMNCj4+IGluZGV4IDZlMTNiYmQxYWFhNS4uYWE4YTA0MjkzYTI1IDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4+ICsrKyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3Ivc3BpLW5vci5jDQo+PiBAQCAtMTczNyw2ICsxNzM3LDggQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBmbGFzaF9pbmZvIHNwaV9ub3JfaWRzW10gPSB7DQo+PiAgIAkvKiBFT04gLS0gZW4y
NXh4eCAqLw0KPj4gICAJeyAiZW4yNWYzMiIsICAgIElORk8oMHgxYzMxMTYsIDAsIDY0ICogMTAy
NCwgICA2NCwgU0VDVF80SykgfSwNCj4+ICAgCXsgImVuMjVwMzIiLCAgICBJTkZPKDB4MWMyMDE2
LCAwLCA2NCAqIDEwMjQsICAgNjQsIDApIH0sDQo+PiArCXsgImVuMjVxODBhIiwgICBJTkZPKDB4
MWMzMDE0LCAwLCA2NCAqIDEwMjQsICAgMTYsDQo+PiArCQkJU0VDVF80SyB8IFNQSV9OT1JfRFVB
TF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+IA0KPiBJJ20gcmVhZGluZyBFTjI1UTgw
QSBSZXYuIEgsIElzc3VlIERhdGU6IDIwMTIvMTAvMjMNCj4gICBkYXRhc2hlZXQuIEkgZG9uJ3Qg
c2VlIHRoZSBiZnB0IHRhYmxlIGRlc2NyaWJlZCwgc28gcHJvYmFibHkgaXQgZG9lc24ndCBzdXBw
b3J0DQo+IGl0LiBUaGUgZmxhc2ggYWR2ZXJ0aXNlcyBTUElOT1JfT1BfUkVBRF8xXzRfNCAoMHhl
YiksIGJ1dCBub3QNCj4gU1BJTk9SX09QX1JFQURfMV8xXzQgKDB4NmIpLiBJbiBzcGlfbm9yX2lu
aXRfcGFyYW1zKCksIHdoZW4gU1BJX05PUl9RVUFEX1JFQUQgaXMNCj4gc2V0LCB3ZSBhc3N1bWUg
dGhhdCBTTk9SX0hXQ0FQU19SRUFEXzFfMV80IGlzIHN1cHBvcnRlZCwgc28gd2Ugd2lsbCB1c2Ug
MHg2YiBmb3INCj4gcXVhZCByZWFkcy4gSSBjYW4ndCBzZWUgaG93IHRoZSBmbGFzaCB3b3JrcyB3
aXRoIDB4NmIsIHVubGVzcyB0aGVyZSBpcyBhIGJmcHQNCj4gdGFibGUgdGhhdCBpbmRpY2F0ZXMg
c3VwcG9ydCBmb3IgMHhlYmguDQo+IA0KPiBJZiBpdCBkb2VzIHN1cHBvcnQgYmZwdCwgc2V0IGp1
c3QgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFELCB0aGUgbGF0dGVyIHdpbGwNCj4gdHJpZ2dl
ciB0aGUgYmZwdCBwYXJzaW5nLg0KDQpUaGFua3MgZm9yIGV4cGxhaW5pbmcgdGhpcy4gSSBtaXNz
ZWQgdGhlIHBvaW50LCB0aGF0IFNQSV9OT1JfUVVBRF9SRUFEIA0KYWN0dWFsbHkgcmVxdWlyZXMg
c3VwcG9ydCBmb3IgU1BJTk9SX09QX1JFQURfMV8xXzQuDQoNCj4gDQo+IElmIHlvdSB3aWxsIHJl
c3VibWl0LCBwbGVhc2Ugb3JkZXIgdGhlIGVudHJ5IGluIGFscGhhYmV0aWNhbCBvcmRlciwgYnkg
bmFtZS4NCg0KT2suDQoNClRoYW5rcywNCkZyaWVkZXI=
