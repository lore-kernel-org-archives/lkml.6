Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC3CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1876206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392929AbfAPM6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:58:52 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:50332 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390382AbfAPM6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:58:51 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id A4ED367A8CC;
        Wed, 16 Jan 2019 13:58:48 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 16 Jan
 2019 13:58:48 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 16 Jan 2019 13:58:48 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Yoshio Furuyama <tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>
CC:     "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "peron.clem@gmail.com" <peron.clem@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spinand: Add support for all Toshiba Memory products
Thread-Topic: [PATCH] mtd: spinand: Add support for all Toshiba Memory
 products
Thread-Index: AQHUrV+t77TqUacwvUKG6ryfUQIOIKWxyuyA
Date:   Wed, 16 Jan 2019 12:58:48 +0000
Message-ID: <d6230005-5dfa-60f9-7eec-87d119aa415d@kontron.de>
References: <20190116055319.2755-1-tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
In-Reply-To: <20190116055319.2755-1-tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B7C488C424FED45B78EC27878BD3537@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: A4ED367A8CC.A18ED
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, peron.clem@gmail.com, richard@nod.at,
        tmcmc-mb-yfuruyama7@ml.toshiba.co.jp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMDEuMTkgMDY6NTMsIFlvc2hpbyBGdXJ1eWFtYSB3cm90ZToNCj4gQWRkIGRldmljZSB0
YWJsZSBmb3IgVG9zaGliYSBNZW1vcnkgcHJvZHVjdHMuDQo+IEFsc28sIGdlbmVyYWxpemUgT09C
IGxheW91dCBzdHJ1Y3R1cmUgYW5kIGZ1bmN0aW9uIG5hbWVzLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogWW9zaGlvIEZ1cnV5YW1hIDx0bWNtYy1tYi15ZnVydXlhbWE3QG1sLnRvc2hpYmEuY28uanA+
DQoNClJldmlld2VkLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRy
b24uZGU+DQoNCj4gDQo+IC0tLQ0KPiAgIGRyaXZlcnMvbXRkL25hbmQvc3BpL3Rvc2hpYmEuYyB8
ICAgNzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3NwaS90b3NoaWJhLmMgYi9kcml2ZXJzL210ZC9uYW5k
L3NwaS90b3NoaWJhLmMNCj4gaW5kZXggMDgxMjY1NS4uMDkxNjk2MiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9tdGQvbmFuZC9zcGkvdG9zaGliYS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQv
c3BpL3Rvc2hpYmEuYw0KPiBAQCAtMjUsMTkgKzI1LDE5IEBAIHN0YXRpYyBTUElOQU5EX09QX1ZB
UklBTlRTKHdyaXRlX2NhY2hlX3ZhcmlhbnRzLA0KPiAgIHN0YXRpYyBTUElOQU5EX09QX1ZBUklB
TlRTKHVwZGF0ZV9jYWNoZV92YXJpYW50cywNCj4gICAJCVNQSU5BTkRfUFJPR19MT0FEKGZhbHNl
LCAwLCBOVUxMLCAwKSk7DQo+ICAgDQo+IC1zdGF0aWMgaW50IHRjNThjdmcyczBoX29vYmxheW91
dF9lY2Moc3RydWN0IG10ZF9pbmZvICptdGQsIGludCBzZWN0aW9uLA0KPiArc3RhdGljIGludCB0
YzU4Y3hneHN4X29vYmxheW91dF9lY2Moc3RydWN0IG10ZF9pbmZvICptdGQsIGludCBzZWN0aW9u
LA0KPiAgIAkJCQkgICAgIHN0cnVjdCBtdGRfb29iX3JlZ2lvbiAqcmVnaW9uKQ0KPiAgIHsNCj4g
LQlpZiAoc2VjdGlvbiA+IDcpDQo+ICsJaWYgKHNlY3Rpb24gPiAwKQ0KPiAgIAkJcmV0dXJuIC1F
UkFOR0U7DQo+ICAgDQo+IC0JcmVnaW9uLT5vZmZzZXQgPSAxMjggKyAxNiAqIHNlY3Rpb247DQo+
IC0JcmVnaW9uLT5sZW5ndGggPSAxNjsNCj4gKwlyZWdpb24tPm9mZnNldCA9IG10ZC0+b29ic2l6
ZSAvIDI7DQo+ICsJcmVnaW9uLT5sZW5ndGggPSBtdGQtPm9vYnNpemUgLyAyOw0KPiAgIA0KPiAg
IAlyZXR1cm4gMDsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgaW50IHRjNThjdmcyczBoX29vYmxh
eW91dF9mcmVlKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBpbnQgc2VjdGlvbiwNCj4gK3N0YXRpYyBp
bnQgdGM1OGN4Z3hzeF9vb2JsYXlvdXRfZnJlZShzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgaW50IHNl
Y3Rpb24sDQo+ICAgCQkJCSAgICAgIHN0cnVjdCBtdGRfb29iX3JlZ2lvbiAqcmVnaW9uKQ0KPiAg
IHsNCj4gICAJaWYgKHNlY3Rpb24gPiAwKQ0KPiBAQCAtNDUsMTcgKzQ1LDE3IEBAIHN0YXRpYyBp
bnQgdGM1OGN2ZzJzMGhfb29ibGF5b3V0X2ZyZWUoc3RydWN0IG10ZF9pbmZvICptdGQsIGludCBz
ZWN0aW9uLA0KPiAgIA0KPiAgIAkvKiAyIGJ5dGVzIHJlc2VydmVkIGZvciBCQk0gKi8NCj4gICAJ
cmVnaW9uLT5vZmZzZXQgPSAyOw0KPiAtCXJlZ2lvbi0+bGVuZ3RoID0gMTI2Ow0KPiArCXJlZ2lv
bi0+bGVuZ3RoID0gbXRkLT5vb2JzaXplIC8gMiAtIDI7DQo+ICAgDQo+ICAgCXJldHVybiAwOw0K
PiAgIH0NCj4gICANCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRkX29vYmxheW91dF9vcHMgdGM1
OGN2ZzJzMGhfb29ibGF5b3V0ID0gew0KPiAtCS5lY2MgPSB0YzU4Y3ZnMnMwaF9vb2JsYXlvdXRf
ZWNjLA0KPiAtCS5mcmVlID0gdGM1OGN2ZzJzMGhfb29ibGF5b3V0X2ZyZWUsDQo+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IG10ZF9vb2JsYXlvdXRfb3BzIHRjNThjeGd4c3hfb29ibGF5b3V0ID0gew0K
PiArCS5lY2MgPSB0YzU4Y3hneHN4X29vYmxheW91dF9lY2MsDQo+ICsJLmZyZWUgPSB0YzU4Y3hn
eHN4X29vYmxheW91dF9mcmVlLA0KPiAgIH07DQo+ICAgDQo+IC1zdGF0aWMgaW50IHRjNThjdmcy
czBoX2VjY19nZXRfc3RhdHVzKHN0cnVjdCBzcGluYW5kX2RldmljZSAqc3BpbmFuZCwNCj4gK3N0
YXRpYyBpbnQgdGM1OGN4Z3hzeF9lY2NfZ2V0X3N0YXR1cyhzdHJ1Y3Qgc3BpbmFuZF9kZXZpY2Ug
KnNwaW5hbmQsDQo+ICAgCQkJCSAgICAgIHU4IHN0YXR1cykNCj4gICB7DQo+ICAgCXN0cnVjdCBu
YW5kX2RldmljZSAqbmFuZCA9IHNwaW5hbmRfdG9fbmFuZChzcGluYW5kKTsNCj4gQEAgLTk0LDE1
ICs5NCw2NiBAQCBzdGF0aWMgaW50IHRjNThjdmcyczBoX2VjY19nZXRfc3RhdHVzKHN0cnVjdCBz
cGluYW5kX2RldmljZSAqc3BpbmFuZCwNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGNvbnN0IHN0
cnVjdCBzcGluYW5kX2luZm8gdG9zaGliYV9zcGluYW5kX3RhYmxlW10gPSB7DQo+IC0JU1BJTkFO
RF9JTkZPKCJUQzU4Q1ZHMlMwSCIsIDB4Q0QsDQo+ICsJLyogMy4zViAxR2IgKi8NCj4gKwlTUElO
QU5EX0lORk8oIlRDNThDVkcwUzMiLCAweEMyLA0KPiArCQkgICAgIE5BTkRfTUVNT1JHKDEsIDIw
NDgsIDEyOCwgNjQsIDEwMjQsIDEsIDEsIDEpLA0KPiArCQkgICAgIE5BTkRfRUNDUkVRKDgsIDUx
MiksDQo+ICsJCSAgICAgU1BJTkFORF9JTkZPX09QX1ZBUklBTlRTKCZyZWFkX2NhY2hlX3Zhcmlh
bnRzLA0KPiArCQkJCQkgICAgICAmd3JpdGVfY2FjaGVfdmFyaWFudHMsDQo+ICsJCQkJCSAgICAg
ICZ1cGRhdGVfY2FjaGVfdmFyaWFudHMpLA0KPiArCQkgICAgIDAsDQo+ICsJCSAgICAgU1BJTkFO
RF9FQ0NJTkZPKCZ0YzU4Y3hneHN4X29vYmxheW91dCwNCj4gKwkJCQkgICAgIHRjNThjeGd4c3hf
ZWNjX2dldF9zdGF0dXMpKSwNCj4gKwkvKiAzLjNWIDJHYiAqLw0KPiArCVNQSU5BTkRfSU5GTygi
VEM1OENWRzFTMyIsIDB4Q0IsDQo+ICsJCSAgICAgTkFORF9NRU1PUkcoMSwgMjA0OCwgMTI4LCA2
NCwgMjA0OCwgMSwgMSwgMSksDQo+ICsJCSAgICAgTkFORF9FQ0NSRVEoOCwgNTEyKSwNCj4gKwkJ
ICAgICBTUElOQU5EX0lORk9fT1BfVkFSSUFOVFMoJnJlYWRfY2FjaGVfdmFyaWFudHMsDQo+ICsJ
CQkJCSAgICAgICZ3cml0ZV9jYWNoZV92YXJpYW50cywNCj4gKwkJCQkJICAgICAgJnVwZGF0ZV9j
YWNoZV92YXJpYW50cyksDQo+ICsJCSAgICAgMCwNCj4gKwkJICAgICBTUElOQU5EX0VDQ0lORk8o
JnRjNThjeGd4c3hfb29ibGF5b3V0LA0KPiArCQkJCSAgICAgdGM1OGN4Z3hzeF9lY2NfZ2V0X3N0
YXR1cykpLA0KPiArCS8qIDMuM1YgNEdiICovDQo+ICsJU1BJTkFORF9JTkZPKCJUQzU4Q1ZHMlMw
IiwgMHhDRCwNCj4gKwkJICAgICBOQU5EX01FTU9SRygxLCA0MDk2LCAyNTYsIDY0LCAyMDQ4LCAx
LCAxLCAxKSwNCj4gKwkJICAgICBOQU5EX0VDQ1JFUSg4LCA1MTIpLA0KPiArCQkgICAgIFNQSU5B
TkRfSU5GT19PUF9WQVJJQU5UUygmcmVhZF9jYWNoZV92YXJpYW50cywNCj4gKwkJCQkJICAgICAg
JndyaXRlX2NhY2hlX3ZhcmlhbnRzLA0KPiArCQkJCQkgICAgICAmdXBkYXRlX2NhY2hlX3Zhcmlh
bnRzKSwNCj4gKwkJICAgICAwLA0KPiArCQkgICAgIFNQSU5BTkRfRUNDSU5GTygmdGM1OGN4Z3hz
eF9vb2JsYXlvdXQsDQo+ICsJCQkJICAgICB0YzU4Y3hneHN4X2VjY19nZXRfc3RhdHVzKSksDQo+
ICsJLyogMS44ViAxR2IgKi8NCj4gKwlTUElOQU5EX0lORk8oIlRDNThDWUcwUzMiLCAweEIyLA0K
PiArCQkgICAgIE5BTkRfTUVNT1JHKDEsIDIwNDgsIDEyOCwgNjQsIDEwMjQsIDEsIDEsIDEpLA0K
PiArCQkgICAgIE5BTkRfRUNDUkVRKDgsIDUxMiksDQo+ICsJCSAgICAgU1BJTkFORF9JTkZPX09Q
X1ZBUklBTlRTKCZyZWFkX2NhY2hlX3ZhcmlhbnRzLA0KPiArCQkJCQkgICAgICAmd3JpdGVfY2Fj
aGVfdmFyaWFudHMsDQo+ICsJCQkJCSAgICAgICZ1cGRhdGVfY2FjaGVfdmFyaWFudHMpLA0KPiAr
CQkgICAgIDAsDQo+ICsJCSAgICAgU1BJTkFORF9FQ0NJTkZPKCZ0YzU4Y3hneHN4X29vYmxheW91
dCwNCj4gKwkJCQkgICAgIHRjNThjeGd4c3hfZWNjX2dldF9zdGF0dXMpKSwNCj4gKwkvKiAxLjhW
IDJHYiAqLw0KPiArCVNQSU5BTkRfSU5GTygiVEM1OENZRzFTMyIsIDB4QkIsDQo+ICsJCSAgICAg
TkFORF9NRU1PUkcoMSwgMjA0OCwgMTI4LCA2NCwgMjA0OCwgMSwgMSwgMSksDQo+ICsJCSAgICAg
TkFORF9FQ0NSRVEoOCwgNTEyKSwNCj4gKwkJICAgICBTUElOQU5EX0lORk9fT1BfVkFSSUFOVFMo
JnJlYWRfY2FjaGVfdmFyaWFudHMsDQo+ICsJCQkJCSAgICAgICZ3cml0ZV9jYWNoZV92YXJpYW50
cywNCj4gKwkJCQkJICAgICAgJnVwZGF0ZV9jYWNoZV92YXJpYW50cyksDQo+ICsJCSAgICAgMCwN
Cj4gKwkJICAgICBTUElOQU5EX0VDQ0lORk8oJnRjNThjeGd4c3hfb29ibGF5b3V0LA0KPiArCQkJ
CSAgICAgdGM1OGN4Z3hzeF9lY2NfZ2V0X3N0YXR1cykpLA0KPiArCS8qIDEuOFYgNEdiICovDQo+
ICsJU1BJTkFORF9JTkZPKCJUQzU4Q1lHMlMwIiwgMHhCRCwNCj4gICAJCSAgICAgTkFORF9NRU1P
UkcoMSwgNDA5NiwgMjU2LCA2NCwgMjA0OCwgMSwgMSwgMSksDQo+ICAgCQkgICAgIE5BTkRfRUND
UkVRKDgsIDUxMiksDQo+ICAgCQkgICAgIFNQSU5BTkRfSU5GT19PUF9WQVJJQU5UUygmcmVhZF9j
YWNoZV92YXJpYW50cywNCj4gICAJCQkJCSAgICAgICZ3cml0ZV9jYWNoZV92YXJpYW50cywNCj4g
ICAJCQkJCSAgICAgICZ1cGRhdGVfY2FjaGVfdmFyaWFudHMpLA0KPiAtCQkgICAgIFNQSU5BTkRf
SEFTX1FFX0JJVCwNCj4gLQkJICAgICBTUElOQU5EX0VDQ0lORk8oJnRjNThjdmcyczBoX29vYmxh
eW91dCwNCj4gLQkJCQkgICAgIHRjNThjdmcyczBoX2VjY19nZXRfc3RhdHVzKSksDQo+ICsJCSAg
ICAgMCwNCj4gKwkJICAgICBTUElOQU5EX0VDQ0lORk8oJnRjNThjeGd4c3hfb29ibGF5b3V0LA0K
PiArCQkJCSAgICAgdGM1OGN4Z3hzeF9lY2NfZ2V0X3N0YXR1cykpLA0KPiAgIH07DQo+ICAgDQo+
ICAgc3RhdGljIGludCB0b3NoaWJhX3NwaW5hbmRfZGV0ZWN0KHN0cnVjdCBzcGluYW5kX2Rldmlj
ZSAqc3BpbmFuZCkNCj4g
