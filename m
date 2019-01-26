Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2339FC282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2807218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfAZDOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:14:18 -0500
Received: from mail-oln040092000081.outbound.protection.outlook.com ([40.92.0.81]:6416
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfAZDOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:14:18 -0500
Received: from BN3NAM01FT031.eop-nam01.prod.protection.outlook.com
 (10.152.66.57) by BN3NAM01HT039.eop-nam01.prod.protection.outlook.com
 (10.152.66.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sat, 26 Jan
 2019 03:14:14 +0000
Received: from BYAPR02MB5495.namprd02.prod.outlook.com (10.152.66.54) by
 BN3NAM01FT031.mail.protection.outlook.com (10.152.67.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sat, 26 Jan 2019 03:14:14 +0000
Received: from BYAPR02MB5495.namprd02.prod.outlook.com
 ([fe80::b889:1a99:77fa:d4fe]) by BYAPR02MB5495.namprd02.prod.outlook.com
 ([fe80::b889:1a99:77fa:d4fe%2]) with mapi id 15.20.1558.021; Sat, 26 Jan 2019
 03:14:14 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?utf-8?B?UGF3ZcWCIENobWllbA==?= <pawel.mikolaj.chmiel@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "colyli@suse.de" <colyli@suse.de>,
        "ckeepax@opensource.wolfsonmicro.com" 
        <ckeepax@opensource.wolfsonmicro.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "xiaotong.lu@spreadtrum.com" <xiaotong.lu@spreadtrum.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: input: Add documentation for gp2a sensor
Thread-Topic: [PATCH 4/4] dt-bindings: input: Add documentation for gp2a
 sensor
Thread-Index: AQHUtNaG8EAwL07Gf0mUl9lwMbRi1aXAxFyAgAAcYgA=
Date:   Sat, 26 Jan 2019 03:14:14 +0000
Message-ID: <BYAPR02MB54959FD8A7CF5977B0D4B5B7A3940@BYAPR02MB5495.namprd02.prod.outlook.com>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125175045.22576-5-pawel.mikolaj.chmiel@gmail.com>
 <20190126013237.GF212026@dtor-ws>
In-Reply-To: <20190126013237.GF212026@dtor-ws>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR18CA0033.namprd18.prod.outlook.com
 (2603:10b6:320:31::19) To BYAPR02MB5495.namprd02.prod.outlook.com
 (2603:10b6:a03:9a::25)
x-incomingtopheadermarker: OriginalChecksum:EE2EBE4EDB2C26CA0DEAC704B620E217766D9DD7231C6CCA5A9ED02DB133D107;UpperCasedChecksum:58D8A52DEE8C4BEFE7798022AD4A22FE58E3CBD80D0CE335A632F6979C18D47A;SizeAsReceived:9333;Count:64
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ORB4IdqSo0zg+jWJMbsSKwXm/NUYjTtzuHZRkc8TaF/fJjZCu0uKTMxKZh94GMcD]
x-microsoft-original-message-id: <3d31818f-7c62-2c4e-e5a6-ea30fef99413@live.ca>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3NAM01HT039;6:GA0BkVkQrQqNfh7Fv4UyJVfOHghSJ/HcfXOiL2A0GroDbKVM3k2/AtIW2Ce4QxamVgfWgWolkeJWVAGSXXHp0CUYXpjfP7+yh81i7HBHF6e+C905OCMvPoaeip+XMkGc8w7MnwS8Yfr/Lp0sI4ok6ZE7V5C+163aX5gWUGqytsVUBn1yynQTW42nhrT0vn2sp3GiIX+c/0wLB0DSBhtiypeC90df8v5mwlalf2mtGC58Jjq/IVEOxF4nwGcaTVnTU0TEP3bn8epZffwOMdPP8GGb+MjqcEo6y3RXjXEbxpnGj3td2IBHefc8HlOnoJ1EHjjFDxzuXRSYqGoHX1wWw7Xm623SRESvbFkwKv7IN6/8Wapp7FRbDWMhJ9ZC2w0NXtfQDGFkg7CrfTgLiCm2sWBvEwC7SK8G2ns3k+v2xU6fBb0uDWHTNTVWiAOBuR9w1tF1nkbTY2/MEiRxTIN3hA==;5:I7slEexAefuKn8+8vwB4OOaD29PgVc3S8Nj4ZlKrgbnx4fptp5miLsOrX0TLRI7sQFDFWwyTIhdMFwDDXmWWptLZaa38jj7PNn8YxZ8oXxMllDn8xpeSCRcJEgbgnUmi7uANH0KI5hgDkIqkCvBxig03sk5IgbxOxOjJz5uxm9FWjv/DqDzlfL/Aa+aW2E9r1q3bDZfZhjYpeXGxQ5Z4TA==;7:8DQe6Iy0RwYMjXiRMzObT2t0BM3jcWLpKhpS+Nyo91s+bEV7r8inV1Xia4jEka6lziXoeSol7np5ZD8QkxTGPA9bLONv01I2BBIp8+5snH1CVnSP+ErmEET+jr+q9cyhDAUGJKZeRww/aaE+4dMo5w==
x-incomingheadercount: 64
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:BN3NAM01HT039;
x-ms-traffictypediagnostic: BN3NAM01HT039:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BN3NAM01HT039;BCL:0;PCL:0;RULEID:;SRVR:BN3NAM01HT039;
x-microsoft-antispam-message-info: APXEyy51/t8F4RLStThcSOuRuaPq8adAd+fJ2R9669Do4ywTQfFBz0N8w+RPFzcD
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5B4C8A28AC48D4489BEF83537B93157@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9bd8b953-1c55-4da7-b616-8bcad099ae8b
X-MS-Exchange-CrossTenant-Network-Message-Id: d255b618-e598-4da4-5535-08d6833c5983
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9bd8b953-1c55-4da7-b616-8bcad099ae8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2019 03:14:13.6622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3NAM01HT039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5LA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IG9mIHRoZSBwYXRjaGVzLg0KDQpD
b25zaWRlcmluZyB0aGF0IHRoZSBsaWdodCBzZW5zb3IgcGFydCBzaG91bGQgYmUgaW4gSUlPLCBz
aG91bGQgdGhlIGVudGlyZSBkcml2ZXIgYmUgcmV3cml0dGVuIGFzIGFuIElJTyBkcml2ZXI/ICBU
aGVyZSdzIGFscmVhZHkgdGhlIGRyaXZlciBmb3IgZ3AyYXAwMjBhMDBmIHRoZXJlIHdoaWNoIGlz
IHByZXN1bWFibHkgdGhlIGdwMmFwMDAyYTAwZidzIHN1Y2Nlc3NvciBhbmQgZG9lcyB0aGUgc2Ft
ZSBmdW5jdGlvbnMuDQoNCk9uIDIwMTktMDEtMjUgNTozMiBwLm0uLCBEbWl0cnkgVG9yb2tob3Yg
d3JvdGU6DQo+IE9uIEZyaSwgSmFuIDI1LCAyMDE5IGF0IDA2OjUwOjQ1UE0gKzAxMDAsIFBhd2XF
giBDaG1pZWwgd3JvdGU6DQo+PiBGcm9tOiBKb25hdGhhbiBCYWtrZXIgPHhjLXJhY2VyMkBsaXZl
LmNhPg0KPj4NCj4+IFRoaXMgY29tbWl0IGFkZHMgZG9jdW1lbnRhdGlvbiBmb3IgU2hhcnAgR1Ay
QVAwMDJBMDBGLg0KPj4gSXQncyBQcm94aW1pdHkvT3B0byBTZW5zb3IgY29ubmVjdGVkIG92ZXIg
aTJjLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIEJha2tlciA8eGMtcmFjZXIyQGxp
dmUuY2E+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNo
bWllbEBnbWFpbC5jb20+DQo+PiAtLS0NCj4+ICAuLi4vYmluZGluZ3MvaW5wdXQvc2hhcnAsZ3Ay
YXAwMDJhMDBmLnR4dCAgICAgfCAyOSArKysrKysrKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNo
YW5nZWQsIDI5IGluc2VydGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L3NoYXJwLGdwMmFwMDAyYTAwZi50eHQNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0
L3NoYXJwLGdwMmFwMDAyYTAwZi50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaW5wdXQvc2hhcnAsZ3AyYXAwMDJhMDBmLnR4dA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uYzUyNGViN2QzZDYwDQo+PiAtLS0gL2Rldi9udWxsDQo+
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW5wdXQvc2hhcnAsZ3Ay
YXAwMDJhMDBmLnR4dA0KPj4gQEAgLTAsMCArMSwyOSBAQA0KPj4gKyogU2hhcnAgR1AyQVAwMDJB
MDBGIEkyQyBQcm94aW1pdHkvT3B0byBTZW5zb3INCj4+ICsNCj4+ICtSZXF1aXJlZCBwcm9wZXJ0
aWVzOg0KPj4gKy0gY29tcGF0aWJsZSA6IFNob3VsZCBiZSAic2hhcnAsZ3AyYXAwMDJhMDBmIg0K
Pj4gKy0gcmVnIDogVGhlIEkyQyBhZGRyZXNzIG9mIHRoZSBzZW5zb3INCj4+ICstIHZvdXQtZ3Bp
byA6IFRoZSBncGlvIGNvbm5lY3RlZCB0byB0aGUgdm91dCBwaW4NCj4gDQo+IERvIHlvdSBrbm93
IHdoYXQgaXQgaXMgZm9yPw0KPiANCkl0J3MgdGhlIGNvbnRyb2wgb2YgdGhlIG1haW4gcG93ZXIg
c3VwcGx5IHRvIHRoZSBjaGlwLg0KPj4gKy0gaW50ZXJydXB0LXBhcmVudCA6IHNob3VsZCBiZSB0
aGUgcGhhbmRsZSBmb3IgdGhlIGludGVycnVwdCBjb250cm9sbGVyDQo+PiArLSBpbnRlcnJ1cHRz
IDogSW50ZXJydXB0IG1hcHBpbmcgZm9yIEdQSU8gSVJRLCBpdCBzaG91bGQgYnkgY29uZmlndXJl
ZCB3aXRoDQo+PiArCQlmbGFncyBJUlFfVFlQRV9FREdFX0JPVEgNCj4+ICsNCj4+ICtPcHRpb25h
bCBwcm9wZXJ0aWVzOg0KPj4gKy0gd2FrZXVwIDogSWYgdGhlIGRldmljZSBpcyBjYXBhYmxlIG9m
IHdha2luZyB1cCB0aGUgc3lzdGVtDQo+PiArLSBpby1jaGFubmVscyA6IFBoYW5kbGUgdG8gYW4g
QURDIGNoYW5uZWwgY29ubmVjdGVkIHRvIHRoZSBsaWdodCBzZW5zb3INCj4+ICstIGlvLWNoYW5u
ZWwtbmFtZXMgPSAibGlnaHQiOw0KPj4gKy0gcG9sbC1pbnRlcnZhbCA6IFBvbGwgaW50ZXJ2YWwg
dGltZSBpbiBtaWxsaXNlY29uZHMsIGRlZmF1bHQgNTAwbXMNCj4+ICstIGxpZ2h0LWFkYy1tYXgg
OiBNYXhpbXVtIGxpZ2h0IHZhbHVlIHJlcG9ydGVkLCBkZWZhdWx0IDQwOTYNCj4+ICstIGxpZ2h0
LWFkYy1mdXp6IDogRnV6eiB2YWx1ZSBmb3IgcmVwb3J0ZWQgbGlnaHQgdmFsdWUsIGRlZmF1bHQg
ODANCj4+ICsNCj4+ICtFeGFtcGxlOg0KPj4gKw0KPj4gK2dwMmFANDQgew0KPj4gKwljb21wYXRp
YmxlID0gInNoYXJwLGdwMmFwMDAyYTAwZiI7DQo+PiArCXJlZyA9IDwweDQ0PjsNCj4+ICsJdm91
dC1ncGlvID0gPCZncGgwIDIgR1BJT19BQ1RJVkVfSElHSD47DQo+PiArCWludGVycnVwdC1wYXJl
bnQgPSA8JmdwaDA+Ow0KPj4gKwlpbnRlcnJ1cHRzID0gPDIgSVJRX1RZUEVfRURHRV9CT1RIPjsN
Cj4+ICsJaW8tY2hhbm5lbHMgPSA8JmFkYyA5PjsNCj4+ICsJaW8tY2hhbm5lbC1uYW1lcyA9ICJs
aWdodCI7DQo+PiArfTsNCj4+IC0tIA0KPj4gMi4xNy4xDQo+Pg0KPiANClRoYW5rcywNCkpvbmF0
aGFuDQo=
