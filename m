Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C69ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5701020852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="kTPxLD6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5701020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbeGWQqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:46:11 -0400
Received: from mail-eopbgr80099.outbound.protection.outlook.com ([40.107.8.99]:30606
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388068AbeGWQqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w08SzPdvvGE4j5HyDzsRQ/sLFR7a/MvX7j/DUbmyKAI=;
 b=kTPxLD6fRYuheCwzDt3NQE+yV5JeC7Xco6+ZmryppWv71PFCmbe8jPi5mdo6Ia5JmgyuIIeY+9s/oIKkrZkiX22kT9NMTE/UIu0SMGuQ53ZSsHlLOdtJ0bgKqWGb2Ru8hhpolSOfrZB4n4l9UvWO7ahetejE9KTIfLvSaQHm2MA=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2749.eurprd05.prod.outlook.com (10.172.11.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 15:44:17 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.018; Mon, 23 Jul 2018
 15:44:17 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "corbet@lwn.net" <corbet@lwn.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "hsweeten@visionengravers.com" <hsweeten@visionengravers.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "vz@mleia.com" <vz@mleia.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] mtd: nand: fix spelling in driver api documentation
Thread-Topic: [PATCH] mtd: nand: fix spelling in driver api documentation
Thread-Index: AQHUH/7NhXdaZjTiwkmcgf7uSZJnDqSc9qwAgAABW4A=
Date:   Mon, 23 Jul 2018 15:44:17 +0000
Message-ID: <1532360655.18760.2.camel@toradex.com>
References: <20180720075334.24254-1-marcel@ziswiler.com>
         <20180723093924.04af0e2f@lwn.net>
In-Reply-To: <20180723093924.04af0e2f@lwn.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2749;6:fsTjHgjkqNj3Eso+ptCvAguJXQoKZ1DxiWMAM4feDqpnMgU+n4e8NGQZS9heFgq5HeQeXcLxcwNcbjJUwo9Em///Eqw8r85jvDeRlofUrRf2uF+2v4laCG+s0BNSCZUpEE4TlpRaE0AFbazehYcSu+YDLhbalyCsB3hNZg8CxAMFD4A2fCOkAtUaFBbe0jT38P19+LsqrV1yr2sG1B/xCYvAZXosLxiBJvcDM98iY9ALedG6vQY4itxmCB7x7YVOSD59/WKkAz59iOhxfCzeLCrfxZ9meZzg9ASPZMYkQWTOgzP98vYjwXEi4odKKIzJIcq8OGobBp/jJY3JQlDd0JR6m/pkCqvt0edBMpHjUdaRMf+TJqo1fzz93uvw8bxDsYRjNe26VyT+bFImjtfDy4105idhTdPNkEjxNw7tVwIYFdZDBKtltTBpQANe33LcnVF1Nh0Qrp+Di2O7hj5kzg==;5:liwoBz0a/flYMgZJoGw1MVYfULVA666VxfHNvtpfcjrpGHRjdP9CJHrsJzfHN4jB+izGqXskC5MdNtpsLR8zdYpVDWSJGXR0td61KtFg91wiBrd9XpkAmK0eYRbiPVDJuSZX9X6qZ93l79EILA7a8tIBma58I0rC+knWe99uRLY=;7:s4I4Yf5hOqfePFRb99xt0FrA8AOSY8QrFwh3JIrdelVFzpyeYCBVO+2UaHNQxm1SuupGpsvgyl1Xg90qaYqFlh+N7/H7Qm1kdmb1Pi0vg+N1k9oaOE7or9PZ+JmOWhcx4i+HffUeiCEzcVuOsptFp0k52mW7j4uD/dJfXihtZHuWUZevjZAktsPD/Zn+xFGbsdNhBGYZikwcVh2VVtHbVB5rqa7ivcbxH3+udBtOT20E6oCkS+H7GYf+8hKHSif1
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9688ea93-424a-4641-3d78-08d5f0b3267d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2749;
x-ms-traffictypediagnostic: VI1PR0501MB2749:
x-microsoft-antispam-prvs: <VI1PR0501MB27490D8690E68F4F2D8EB2DFFB560@VI1PR0501MB2749.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2749;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2749;
x-forefront-prvs: 0742443479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(396003)(136003)(346002)(366004)(199004)(189003)(54534003)(305945005)(6116002)(66066001)(4326008)(2616005)(486006)(476003)(97736004)(256004)(229853002)(44832011)(11346002)(6246003)(53936002)(36756003)(25786009)(2906002)(6916009)(86362001)(5660300001)(2900100001)(99286004)(446003)(81156014)(76176011)(5250100002)(81166006)(26005)(103116003)(8676002)(1730700003)(2351001)(8936002)(68736007)(186003)(2501003)(6506007)(102836004)(7736002)(105586002)(6436002)(3846002)(316002)(5640700003)(6512007)(54906003)(106356001)(6486002)(478600001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2749;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ou51PPBf1XdTeKfrxfDilq8eesXOWGmHo+aZkagWhZSrEP0m+2Pz2kT4tHBMLeZRk+jiB7M/0am/K6GvehjdlH4M9t1CUjshbJe25RBA9N18M+lDgbuNvpKDC2qgcceVqlhEfgQSZq/1CamhsqCNUXyzT/PyDaN5pFzJd/5Ifj1gcrEEzHnSqNA5gq2kloQ0/boSqj3FwN8JEHR8OYJEy8AQqJnhbPlt0FpvQIvKKWWkUftAE95c23FUolPbDoKRPuFAAbwJq0wpNCdzd1cYQk/tMYd6J09/2RKPbqIsCV94cNZtXXDf+foBFpuzumw8nes2sn7D3hnsrRMInTwuBpWhGiQWJ4j8V/FGK6btmbA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3FA34BB246340429689E5A5F6E7908B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9688ea93-424a-4641-3d78-08d5f0b3267d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 15:44:17.6635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA3LTIzIGF0IDA5OjM5IC0wNjAwLCBKb25hdGhhbiBDb3JiZXQgd3JvdGU6
DQo+IE9uIEZyaSwgMjAgSnVsIDIwMTggMDk6NTM6MzMgKzAyMDANCj4gTWFyY2VsIFppc3dpbGVy
IDxtYXJjZWxAemlzd2lsZXIuY29tPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogTWFyY2VsIFppc3dp
bGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4gVGhpcyBmaXhlcyBz
b21lIHNwZWxsaW5nIG1pc3Rha2VzLg0KPiANCj4gU28gSSBoYXRlIHRvIGNvbXBsYWluIGFib3V0
IGEgZG9jdW1lbnRhdGlvbiBpbXByb3ZlbWVudCwgYnV0Li4uDQo+IA0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0K
PiA+IA0KPiA+IC0tLQ0KPiA+IA0KPiA+ICBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvbXRkbmFu
ZC5yc3QgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kcml2ZXIt
YXBpL210ZG5hbmQucnN0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvbXRkbmFuZC5y
c3QNCj4gPiBpbmRleCBkY2Q2MzU5OWY3MDAuLmM1NWE2MDM0YzM5NyAxMDA2NDQNCj4gPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvbXRkbmFuZC5yc3QNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RyaXZlci1hcGkvbXRkbmFuZC5yc3QNCj4gPiBAQCAtMzc0LDcgKzM3NCw3IEBAIFRo
ZSBuYW5kIGRyaXZlciBzdXBwb3J0cyB0aHJlZSBkaWZmZXJlbnQgdHlwZXMNCj4gPiBvZiBoYXJk
d2FyZSBFQ0MuDQo+ID4gIA0KPiA+ICAtICBOQU5EX0VDQ19IVzhfNTEyDQo+ID4gIA0KPiA+IC0g
ICBIYXJkd2FyZSBFQ0MgZ2VuZXJhdG9yIHByb3ZpZGluZyA2IGJ5dGVzIEVDQyBwZXIgNTEyIGJ5
dGUuDQo+ID4gKyAgIEhhcmR3YXJlIEVDQyBnZW5lcmF0b3IgcHJvdmlkaW5nIDggYnl0ZXMgRUND
IHBlciA1MTIgYnl0ZS4NCj4gDQo+IFRoYXQncyBub3QgYSBzcGVsbGluZyBtaXN0YWtlLCB0aGF0
J3MgYSBmYWN0dWFsIGNoYW5nZS4gIEknbGwgYXBwbHkNCj4gdGhlDQo+IHBhdGNoIHNpbmNlIGl0
IGFwcGVhcnMgdG8gYmUgY29ycmVjdCwgYnV0IHdpbGwgYmUgdHdlYWtpbmcgdGhlDQo+IGNoYW5n
ZWxvZy4NCg0KWWVhaCwgcHJvYmFibHkgYSBjb3B5L3Bhc3RlIG1pc3Rha2UuIE5vIHB1biBpbnRl
bmRlZC4NCg0KPiBUaGFua3MsDQo+IA0KPiBqb24=
