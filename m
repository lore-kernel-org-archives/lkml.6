Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E80C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C052420859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbfAPLRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:17:14 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:48508 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbfAPLRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:17:13 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 674D165EEF2;
        Wed, 16 Jan 2019 11:42:44 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 16 Jan
 2019 11:42:44 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 16 Jan 2019 11:42:44 +0100
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
Thread-Index: AQHUrV+t77TqUacwvUKG6ryfUQIOIKWxpOiA
Date:   Wed, 16 Jan 2019 10:42:43 +0000
Message-ID: <9152bc6f-d27f-cdb2-a5f4-cefd88eb4f8a@kontron.de>
References: <20190116055319.2755-1-tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
In-Reply-To: <20190116055319.2755-1-tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <32AB193965CAEE4C87B16C3F85C1C75F@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 674D165EEF2.A177A
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

SGkgWW9zaGlvLA0KDQpPbiAxNi4wMS4xOSAwNjo1MywgWW9zaGlvIEZ1cnV5YW1hIHdyb3RlOg0K
PiBBZGQgZGV2aWNlIHRhYmxlIGZvciBUb3NoaWJhIE1lbW9yeSBwcm9kdWN0cy4NCj4gQWxzbywg
Z2VuZXJhbGl6ZSBPT0IgbGF5b3V0IHN0cnVjdHVyZSBhbmQgZnVuY3Rpb24gbmFtZXMuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBZb3NoaW8gRnVydXlhbWEgPHRtY21jLW1iLXlmdXJ1eWFtYTdAbWwu
dG9zaGliYS5jby5qcD4NCj4gDQo+IC0tLQ0KPiAgIGRyaXZlcnMvbXRkL25hbmQvc3BpL3Rvc2hp
YmEuYyB8ICAgNzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3NwaS90b3NoaWJhLmMgYi9kcml2ZXJzL210
ZC9uYW5kL3NwaS90b3NoaWJhLmMNCj4gaW5kZXggMDgxMjY1NS4uMDkxNjk2MiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9tdGQvbmFuZC9zcGkvdG9zaGliYS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRk
L25hbmQvc3BpL3Rvc2hpYmEuYw0KPiBAQCAtMjUsMTkgKzI1LDE5IEBAIHN0YXRpYyBTUElOQU5E
X09QX1ZBUklBTlRTKHdyaXRlX2NhY2hlX3ZhcmlhbnRzLA0KPiAgIHN0YXRpYyBTUElOQU5EX09Q
X1ZBUklBTlRTKHVwZGF0ZV9jYWNoZV92YXJpYW50cywNCj4gICAJCVNQSU5BTkRfUFJPR19MT0FE
KGZhbHNlLCAwLCBOVUxMLCAwKSk7DQo+ICAgDQo+IC1zdGF0aWMgaW50IHRjNThjdmcyczBoX29v
YmxheW91dF9lY2Moc3RydWN0IG10ZF9pbmZvICptdGQsIGludCBzZWN0aW9uLA0KPiArc3RhdGlj
IGludCB0YzU4Y3hneHN4X29vYmxheW91dF9lY2Moc3RydWN0IG10ZF9pbmZvICptdGQsIGludCBz
ZWN0aW9uLA0KPiAgIAkJCQkgICAgIHN0cnVjdCBtdGRfb29iX3JlZ2lvbiAqcmVnaW9uKQ0KPiAg
IHsNCj4gLQlpZiAoc2VjdGlvbiA+IDcpDQo+ICsJaWYgKHNlY3Rpb24gPiAwKQ0KPiAgIAkJcmV0
dXJuIC1FUkFOR0U7DQo+ICAgDQo+IC0JcmVnaW9uLT5vZmZzZXQgPSAxMjggKyAxNiAqIHNlY3Rp
b247DQo+IC0JcmVnaW9uLT5sZW5ndGggPSAxNjsNCj4gKwlyZWdpb24tPm9mZnNldCA9IG10ZC0+
b29ic2l6ZSAvIDI7DQo+ICsJcmVnaW9uLT5sZW5ndGggPSBtdGQtPm9vYnNpemUgLyAyOw0KPiAg
IA0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgaW50IHRjNThjdmcyczBo
X29vYmxheW91dF9mcmVlKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBpbnQgc2VjdGlvbiwNCj4gK3N0
YXRpYyBpbnQgdGM1OGN4Z3hzeF9vb2JsYXlvdXRfZnJlZShzdHJ1Y3QgbXRkX2luZm8gKm10ZCwg
aW50IHNlY3Rpb24sDQo+ICAgCQkJCSAgICAgIHN0cnVjdCBtdGRfb29iX3JlZ2lvbiAqcmVnaW9u
KQ0KPiAgIHsNCj4gICAJaWYgKHNlY3Rpb24gPiAwKQ0KPiBAQCAtNDUsMTcgKzQ1LDE3IEBAIHN0
YXRpYyBpbnQgdGM1OGN2ZzJzMGhfb29ibGF5b3V0X2ZyZWUoc3RydWN0IG10ZF9pbmZvICptdGQs
IGludCBzZWN0aW9uLA0KPiAgIA0KPiAgIAkvKiAyIGJ5dGVzIHJlc2VydmVkIGZvciBCQk0gKi8N
Cj4gICAJcmVnaW9uLT5vZmZzZXQgPSAyOw0KPiAtCXJlZ2lvbi0+bGVuZ3RoID0gMTI2Ow0KPiAr
CXJlZ2lvbi0+bGVuZ3RoID0gbXRkLT5vb2JzaXplIC8gMiAtIDI7DQo+ICAgDQo+ICAgCXJldHVy
biAwOw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRkX29vYmxheW91dF9v
cHMgdGM1OGN2ZzJzMGhfb29ibGF5b3V0ID0gew0KPiAtCS5lY2MgPSB0YzU4Y3ZnMnMwaF9vb2Js
YXlvdXRfZWNjLA0KPiAtCS5mcmVlID0gdGM1OGN2ZzJzMGhfb29ibGF5b3V0X2ZyZWUsDQo+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IG10ZF9vb2JsYXlvdXRfb3BzIHRjNThjeGd4c3hfb29ibGF5b3V0
ID0gew0KPiArCS5lY2MgPSB0YzU4Y3hneHN4X29vYmxheW91dF9lY2MsDQo+ICsJLmZyZWUgPSB0
YzU4Y3hneHN4X29vYmxheW91dF9mcmVlLA0KPiAgIH07DQo+ICAgDQo+IC1zdGF0aWMgaW50IHRj
NThjdmcyczBoX2VjY19nZXRfc3RhdHVzKHN0cnVjdCBzcGluYW5kX2RldmljZSAqc3BpbmFuZCwN
Cj4gK3N0YXRpYyBpbnQgdGM1OGN4Z3hzeF9lY2NfZ2V0X3N0YXR1cyhzdHJ1Y3Qgc3BpbmFuZF9k
ZXZpY2UgKnNwaW5hbmQsDQo+ICAgCQkJCSAgICAgIHU4IHN0YXR1cykNCj4gICB7DQo+ICAgCXN0
cnVjdCBuYW5kX2RldmljZSAqbmFuZCA9IHNwaW5hbmRfdG9fbmFuZChzcGluYW5kKTsNCj4gQEAg
LTk0LDE1ICs5NCw2NiBAQCBzdGF0aWMgaW50IHRjNThjdmcyczBoX2VjY19nZXRfc3RhdHVzKHN0
cnVjdCBzcGluYW5kX2RldmljZSAqc3BpbmFuZCwNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGNv
bnN0IHN0cnVjdCBzcGluYW5kX2luZm8gdG9zaGliYV9zcGluYW5kX3RhYmxlW10gPSB7DQo+IC0J
U1BJTkFORF9JTkZPKCJUQzU4Q1ZHMlMwSCIsIDB4Q0QsDQo+ICsJLyogMy4zViAxR2IgKi8NCj4g
KwlTUElOQU5EX0lORk8oIlRDNThDVkcwUzMiLCAweEMyLA0KPiArCQkgICAgIE5BTkRfTUVNT1JH
KDEsIDIwNDgsIDEyOCwgNjQsIDEwMjQsIDEsIDEsIDEpLA0KPiArCQkgICAgIE5BTkRfRUNDUkVR
KDgsIDUxMiksDQo+ICsJCSAgICAgU1BJTkFORF9JTkZPX09QX1ZBUklBTlRTKCZyZWFkX2NhY2hl
X3ZhcmlhbnRzLA0KPiArCQkJCQkgICAgICAmd3JpdGVfY2FjaGVfdmFyaWFudHMsDQo+ICsJCQkJ
CSAgICAgICZ1cGRhdGVfY2FjaGVfdmFyaWFudHMpLA0KPiArCQkgICAgIDAsDQo+ICsJCSAgICAg
U1BJTkFORF9FQ0NJTkZPKCZ0YzU4Y3hneHN4X29vYmxheW91dCwNCj4gKwkJCQkgICAgIHRjNThj
eGd4c3hfZWNjX2dldF9zdGF0dXMpKSwNCj4gKwkvKiAzLjNWIDJHYiAqLw0KPiArCVNQSU5BTkRf
SU5GTygiVEM1OENWRzFTMyIsIDB4Q0IsDQo+ICsJCSAgICAgTkFORF9NRU1PUkcoMSwgMjA0OCwg
MTI4LCA2NCwgMjA0OCwgMSwgMSwgMSksDQo+ICsJCSAgICAgTkFORF9FQ0NSRVEoOCwgNTEyKSwN
Cj4gKwkJICAgICBTUElOQU5EX0lORk9fT1BfVkFSSUFOVFMoJnJlYWRfY2FjaGVfdmFyaWFudHMs
DQo+ICsJCQkJCSAgICAgICZ3cml0ZV9jYWNoZV92YXJpYW50cywNCj4gKwkJCQkJICAgICAgJnVw
ZGF0ZV9jYWNoZV92YXJpYW50cyksDQo+ICsJCSAgICAgMCwNCj4gKwkJICAgICBTUElOQU5EX0VD
Q0lORk8oJnRjNThjeGd4c3hfb29ibGF5b3V0LA0KPiArCQkJCSAgICAgdGM1OGN4Z3hzeF9lY2Nf
Z2V0X3N0YXR1cykpLA0KPiArCS8qIDMuM1YgNEdiICovDQo+ICsJU1BJTkFORF9JTkZPKCJUQzU4
Q1ZHMlMwIiwgMHhDRCwNCj4gKwkJICAgICBOQU5EX01FTU9SRygxLCA0MDk2LCAyNTYsIDY0LCAy
MDQ4LCAxLCAxLCAxKSwNCj4gKwkJICAgICBOQU5EX0VDQ1JFUSg4LCA1MTIpLA0KPiArCQkgICAg
IFNQSU5BTkRfSU5GT19PUF9WQVJJQU5UUygmcmVhZF9jYWNoZV92YXJpYW50cywNCj4gKwkJCQkJ
ICAgICAgJndyaXRlX2NhY2hlX3ZhcmlhbnRzLA0KPiArCQkJCQkgICAgICAmdXBkYXRlX2NhY2hl
X3ZhcmlhbnRzKSwNCj4gKwkJICAgICAwLA0KPiArCQkgICAgIFNQSU5BTkRfRUNDSU5GTygmdGM1
OGN4Z3hzeF9vb2JsYXlvdXQsDQo+ICsJCQkJICAgICB0YzU4Y3hneHN4X2VjY19nZXRfc3RhdHVz
KSksDQo+ICsJLyogMS44ViAxR2IgKi8NCj4gKwlTUElOQU5EX0lORk8oIlRDNThDWUcwUzMiLCAw
eEIyLA0KPiArCQkgICAgIE5BTkRfTUVNT1JHKDEsIDIwNDgsIDEyOCwgNjQsIDEwMjQsIDEsIDEs
IDEpLA0KPiArCQkgICAgIE5BTkRfRUNDUkVRKDgsIDUxMiksDQo+ICsJCSAgICAgU1BJTkFORF9J
TkZPX09QX1ZBUklBTlRTKCZyZWFkX2NhY2hlX3ZhcmlhbnRzLA0KPiArCQkJCQkgICAgICAmd3Jp
dGVfY2FjaGVfdmFyaWFudHMsDQo+ICsJCQkJCSAgICAgICZ1cGRhdGVfY2FjaGVfdmFyaWFudHMp
LA0KPiArCQkgICAgIDAsDQo+ICsJCSAgICAgU1BJTkFORF9FQ0NJTkZPKCZ0YzU4Y3hneHN4X29v
YmxheW91dCwNCj4gKwkJCQkgICAgIHRjNThjeGd4c3hfZWNjX2dldF9zdGF0dXMpKSwNCj4gKwkv
KiAxLjhWIDJHYiAqLw0KPiArCVNQSU5BTkRfSU5GTygiVEM1OENZRzFTMyIsIDB4QkIsDQo+ICsJ
CSAgICAgTkFORF9NRU1PUkcoMSwgMjA0OCwgMTI4LCA2NCwgMjA0OCwgMSwgMSwgMSksDQo+ICsJ
CSAgICAgTkFORF9FQ0NSRVEoOCwgNTEyKSwNCj4gKwkJICAgICBTUElOQU5EX0lORk9fT1BfVkFS
SUFOVFMoJnJlYWRfY2FjaGVfdmFyaWFudHMsDQo+ICsJCQkJCSAgICAgICZ3cml0ZV9jYWNoZV92
YXJpYW50cywNCj4gKwkJCQkJICAgICAgJnVwZGF0ZV9jYWNoZV92YXJpYW50cyksDQo+ICsJCSAg
ICAgMCwNCj4gKwkJICAgICBTUElOQU5EX0VDQ0lORk8oJnRjNThjeGd4c3hfb29ibGF5b3V0LA0K
PiArCQkJCSAgICAgdGM1OGN4Z3hzeF9lY2NfZ2V0X3N0YXR1cykpLA0KPiArCS8qIDEuOFYgNEdi
ICovDQo+ICsJU1BJTkFORF9JTkZPKCJUQzU4Q1lHMlMwIiwgMHhCRCwNCj4gICAJCSAgICAgTkFO
RF9NRU1PUkcoMSwgNDA5NiwgMjU2LCA2NCwgMjA0OCwgMSwgMSwgMSksDQo+ICAgCQkgICAgIE5B
TkRfRUNDUkVRKDgsIDUxMiksDQo+ICAgCQkgICAgIFNQSU5BTkRfSU5GT19PUF9WQVJJQU5UUygm
cmVhZF9jYWNoZV92YXJpYW50cywNCj4gICAJCQkJCSAgICAgICZ3cml0ZV9jYWNoZV92YXJpYW50
cywNCj4gICAJCQkJCSAgICAgICZ1cGRhdGVfY2FjaGVfdmFyaWFudHMpLA0KPiAtCQkgICAgIFNQ
SU5BTkRfSEFTX1FFX0JJVCwNCg0KWW91J3JlIHJlbW92aW5nIHRoZSBTUElOQU5EX0hBU19RRV9C
SVQuIEkganVzdCBkb3VibGUgY2hlY2tlZCBvbmUgb2YgdGhlIA0KZGF0YXNoZWV0cyBhbmQgaXQg
c2VlbXMgbGlrZSB0aGVyZSBpcyBpbmRlZWQgbm8gUUUgYml0IGluIHRoZSANCmNvbmZpZ3VyYXRp
b24gcmVnaXN0ZXIuIEkgd29uZGVyIHdoZXJlIEkgZ290IHRoYXQgaW5mb3JtYXRpb24gZnJvbS4g
DQpNYXliZSBJIHdhcyBsb29raW5nIGF0IHRoZSB3cm9uZyBkYXRhc2hlZXQhPw0KDQpBbnl3YXks
IEkgd2lsbCB0cnkgdG8gZG8gYSBxdWljayB0ZXN0IG9uIG15IGRldmljZSB3aXRoIFRDNThDVkcy
UzAgYW5kIA0KbGV0IHlvdSBub3cgYWJvdXQgdGhlIHJlc3VsdHMuDQoNClRoYW5rcywNCkZyaWVk
ZXINCg0KPiAtCQkgICAgIFNQSU5BTkRfRUNDSU5GTygmdGM1OGN2ZzJzMGhfb29ibGF5b3V0LA0K
PiAtCQkJCSAgICAgdGM1OGN2ZzJzMGhfZWNjX2dldF9zdGF0dXMpKSwNCj4gKwkJICAgICAwLA0K
PiArCQkgICAgIFNQSU5BTkRfRUNDSU5GTygmdGM1OGN4Z3hzeF9vb2JsYXlvdXQsDQo+ICsJCQkJ
ICAgICB0YzU4Y3hneHN4X2VjY19nZXRfc3RhdHVzKSksDQo+ICAgfTsNCj4gICANCj4gICBzdGF0
aWMgaW50IHRvc2hpYmFfc3BpbmFuZF9kZXRlY3Qoc3RydWN0IHNwaW5hbmRfZGV2aWNlICpzcGlu
YW5kKQ0KPiA=
