Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027E0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B152087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="P1miwXpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfAHLlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:41:35 -0500
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:2128
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfAHLlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh6y/9XDS3fyu8D9W6p+TxUyTWbMGHYahIsiuJxd63c=;
 b=P1miwXpDFCB1NLeDfTfbhCEDHfuPR+iswZN/2lgLWJp2QZ2Z1ZcKpci3PL7glYpAVKLuyLaXBXTOSYz2E7lxQeyb70u3WnlLgWR1i1m9WuJTijvsJGKG/8XC+NS48+3cpbBrjIzhWVX35C693d0LO5HG2vyslLKRxawBZ8yBYVc=
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com (52.133.38.156) by
 AM0PR0402MB3521.eurprd04.prod.outlook.com (52.133.45.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Tue, 8 Jan 2019 11:40:51 +0000
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72]) by AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72%5]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 11:40:51 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Thread-Topic: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Thread-Index: AQHUlt/bwU7HN6OdJEGSFUlfmMcu7qWUhk+AgBDZ8YA=
Date:   Tue, 8 Jan 2019 11:40:51 +0000
Message-ID: <f3a0e689-b0d5-e08c-b0b8-faf2a366dd93@ysoft.com>
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
 <CAOMZO5CuPr_BxMP_wjPuZNTCinHQ-cb08wPHr=Od_Qw_aafPTw@mail.gmail.com>
In-Reply-To: <CAOMZO5CuPr_BxMP_wjPuZNTCinHQ-cb08wPHr=Od_Qw_aafPTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0060.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::37) To AM0PR0402MB3716.eurprd04.prod.outlook.com
 (2603:10a6:208:d::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3521;6:oOxRcCQqqptxLshuJaocn66bxXkh5PvCxWwa5w0GvcZPtV8CMYHCuYy22JEm6UQezz34skzGyTWyWkwQg+qaeXQ9YoDj7j96MKrDSGd6/p9bBcmNatjlyatJdxYtTXGcKJoncuVpD/JWHFqdATZ7jG1nyYgUb5y2gbBNECPTyx/r6TNYPg4uQ7CLX4oOhGjFbzkqIHbcooX7MerfX7OooyVnG5j9r2PAiIt4Kd1dyqEEs03I7/IVJxtBKqMY3hI+pD/jElVkVN3TU8lxHkpvMsG3av3jDPyoa6uYEfdajR17Db1MPKyMSEY8yivS1aRv12USngjgEeEvCpdVodQz1qiDGBrJ2tj3CK3nb8SUjo/8Tgh+IKCArkb28qrtbYKYFiVfjH6Wkv3Qb+EhTD6UZ7ATiHHn2ehwiS5Uwwv84MnjUcudvmRrFNhfAiuqnalKAs9U3aCemkQ/n1pWhLQ+1g==;5:jbXSOyfF22H4XRTKzqLpkxfnUP08NMddkynQoS0CJjI3oQZV2DPG1Ja8mGB1v2mPOeJKHqBsNuokd2ITf2K3vK7tDcZFQjkhF4zhYM6/X6vNsI/nnKezER/hrClUuIMn9GewoWRAQR7vxwcWbosNBpapn3if3Oq3fbyqlmow2OfMx0dEL2JjunSYqa0Oxss1OcnIWorkzwKqetEStdu+Xg==;7:o1dedIj/0XA7FYXhq1Hc7gpRsVo46Qfha1f/rQ36WqQvexd1cqCxZPrvPhifWEfwiL4JM9Z6LpaDjkfX6435vjTouElbW+iiwWKhaBRawjh6Pu0Q9YxVsiOWA7aIGsO3L6TiPgMMg3xbY6MpvNdTMw==
x-ms-office365-filtering-correlation-id: 8bf68b0b-c373-4e83-47e4-08d6755e23d6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3521;
x-ms-traffictypediagnostic: AM0PR0402MB3521:
x-microsoft-antispam-prvs: <AM0PR0402MB352106456D1D8F214822C5239E8A0@AM0PR0402MB3521.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3521;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3521;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(39850400004)(376002)(199004)(189003)(52116002)(316002)(97736004)(68736007)(5660300001)(66066001)(76176011)(229853002)(6436002)(54906003)(102836004)(6486002)(26005)(53546011)(36756003)(6916009)(6506007)(386003)(6512007)(6246003)(8676002)(85182001)(14454004)(4326008)(81156014)(39060400002)(81166006)(6116002)(3846002)(8936002)(53936002)(71190400001)(71200400001)(72206003)(478600001)(186003)(25786009)(2906002)(446003)(476003)(11346002)(305945005)(2616005)(7736002)(31696002)(486006)(86362001)(345774005)(106356001)(31686004)(105586002)(1411001)(256004)(14444005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3521;H:AM0PR0402MB3716.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /4JBHcbl3dOBRq/gvtHolx9X8iGVxRMCkg2kWcspqInRqNfuHJJFCArxx1FWVjMmEgPKDSrf7w2GpT/5dxYPC6hmk2DmDxl/OjlfVJX1nQon2LGfY6aVhzkwkrB50qiJd36FuIafwhpnFhN0qcWxIZ24FZlrkIEwcL3IzQCdskdfAEmVir2hWQaDig8Yc7RxGlwlG9CsIL+eSfn30TFT9U7LZmpgbuv+Nr5XkkeyePHR2VZilSueQskvZVQOIt0FtXbT1Ir7znxOkTiBgG0re6C/G6zWpu4GgWoPRC4yU3ynhQGyJGpKLH3MU9vKSKje
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <14560E487B979C479F72CE2D5A9827B9@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf68b0b-c373-4e83-47e4-08d6755e23d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 11:40:50.5312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjguMTIuMjAxOCAxOToyMCwgRmFiaW8gRXN0ZXZhbSB3cm90ZToNCj4gT24gVHVlLCBEZWMg
MTgsIDIwMTggYXQgMTI6NDIgUE0gVm9rw6HEjSBNaWNoYWwgPE1pY2hhbC5Wb2thY0B5c29mdC5j
b20+IHdyb3RlOg0KPiANCj4+ICsmZmVjIHsNCj4+ICsgICAgICAgcGluY3RybC1uYW1lcyA9ICJk
ZWZhdWx0IjsNCj4+ICsgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX2VuZXQ+Ow0KPj4gKyAg
ICAgICBwaHktbW9kZSA9ICJyZ21paS1pZCI7DQo+PiArICAgICAgIHBoeS1yZXNldC1ncGlvcyA9
IDwmZ3BpbzEgMjUgR1BJT19BQ1RJVkVfSElHSD47DQo+IA0KPiBBcmUgeW91IHN1cmUgdGhpcyBp
cyBhY3RpdmUgaGlnaD8NCj4gDQo+IFRoZSBGRUMgZHJpdmVyIGlnbm9yZXMgdGhlIHBvbGFyaXR5
IG9mIHBoeS1yZXNldC1ncGlvcyBhbmQgaXQgYXNzdW1lcw0KPiB0aGUgR1BJTyByZXNldCBhcyBh
Y3RpdmUgbG93Lg0KPiANCj4gSWYgaXQgcmVhbGx5IGlzIGFjdGl2ZSBoaWdoLCB0aGVuIHlvdSB3
b3VsZCBuZWVkIHRvIHBhc3MgdGhlDQo+ICJwaHktcmVzZXQtYWN0aXZlLWhpZ2giIHByb3BlcnR5
Lg0KDQpHb29kIGNhdGNoISBPcmlnaW5hbGx5IGl0IHdhcyBwaHktcmVzZXQtZ3Bpb3MgPSA8Jmdw
aW8xIDI1IDA+IHdoaWNoIGlzDQphY3RpdmUgaGlnaCBhcyB3ZWxsLiBBbmQgYXMgeW91IHNheSwg
dGhlIHBvbGFyaXR5IGlzIGlnbm9yZWQuIExhdGVyIG9uDQpJIGRlY2lkZWQgdG8gY2hhbmdlIGFs
bCB0aGUgR1BJTyBzcGVjaWZpZXJzIHRvIHVzZSBkZWZpbmVzIGluc3RlYWQgb2YNCm51bWJlcnMu
IEkganVzdCBzd2FwcGVkIDAgZm9yIEdQSU9fQUNUSVZFX0hJR0ggd2l0aG91dCB1c2luZyBicmFp
biBjZWxscy4NCg0KSSB3aWxsIHVzZSBHUElPX0FDVElWRV9MT1cgdGhlcmUgdG8gYmUgY29ycmVj
dCBldmVuIHRob3VnaCBpdCBpcyBpZ25vcmVkLg0KDQo+PiArLyB7DQo+PiArICAgICAgIG1vZGVs
ID0gIlkgU29mdCBJT1RBIERyYWNvIGkuTVg2U29sbyBib2FyZCI7DQo+PiArICAgICAgIGNvbXBh
dGlibGUgPSAieXNvZnQsaW14NmRsLXlhcHA0LWRyYWNvIiwgImZzbCxpbXg2ZGwiOw0KPj4gKw0K
Pj4gKyAgICAgICBjcHVzIHsNCj4+ICsgICAgICAgICAgICAgICAvZGVsZXRlLW5vZGUvIGNwdUAx
Ow0KPiANCj4gSXMgdGhpcyByZWFsbHkgbmVlZGVkPyBXZSBkb24ndCB1c3VhbGx5IGRvIHRoaXMg
b24gaW14NnNvbG8gZHRzIGJvYXJkIGZpbGVzLg0KPiANCj4gT25seSBvbmUgQ1BVIHdpbGwgYmUg
YnJvdWdodCB1cCBvbmxpbmUgb24gaW14NnNvbG8gYW55d2F5Lg0KDQpPSywgaXQgaXMgcmVhbGx5
IG5vdCBuZWNlc3NhcnkuIEkgd2lsbCByZW1vdmUgaXQuDQoNCj4+ICsgICAgICAgfTsNCj4+ICsN
Cj4+ICsgICAgICAgbWVtb3J5QDEwMDAwMDAwIHsNCj4gDQo+IE5lZWQgdG8gcGFzcyAiZGV2aWNl
X3R5cGUgPSAibWVtb3J5IjsiDQoNCk9LLg0KDQo+PiArLyB7DQo+PiArICAgICAgIG1vZGVsID0g
IlkgU29mdCBJT1RBIEh5ZHJhIGkuTVg2RHVhbExpdGUgYm9hcmQiOw0KPj4gKyAgICAgICBjb21w
YXRpYmxlID0gInlzb2Z0LGlteDZkbC15YXBwNC1oeWRyYSIsICJmc2wsaW14NmRsIjsNCj4+ICsN
Cj4+ICsgICAgICAgbWVtb3J5QDEwMDAwMDAwIHsNCj4gDQo+IE5lZWQgdG8gcGFzcyAiZGV2aWNl
X3R5cGUgPSAibWVtb3J5IjsiDQoNCk9LLg0KDQo+PiArICAgICAgIG1lbW9yeUAxMDAwMDAwMCB7
DQo+IA0KPiBOZWVkIHRvIHBhc3MgImRldmljZV90eXBlID0gIm1lbW9yeSI7Ig0KDQpPSy4NCg0K
VGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IEZhYmlvLg0KQWxsIHRoZSBiZXN0LA0KTWljaGFsDQoN
Cg==
