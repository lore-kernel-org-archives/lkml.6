Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC41BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646F220811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="fp+FrajC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646F220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeLKL60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:58:26 -0500
Received: from mail-eopbgr30109.outbound.protection.outlook.com ([40.107.3.109]:36241
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbeLKL6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48BMNXiAYD34aRsHMe5wS3ulrzabDgvwtVGoUnYbEE0=;
 b=fp+FrajCQqHLebW2uRz9RuvXvZoZr3Geg42SkhW3G2PenA5MQtGB4ciR6phuIaA6VuaBeXW9QuYDEAYibh03V4qhOUBxXXLa1rLIBi6ryrphuSCWE9Upg/HkmX7nrBPul9p+OkcZTW+FzbHQqHIgHLIsiCY4LXaPek55PYBvhhQ=
Received: from VI1PR07MB5088.eurprd07.prod.outlook.com (20.177.203.160) by
 VI1PR07MB5855.eurprd07.prod.outlook.com (20.178.122.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.10; Tue, 11 Dec 2018 11:58:22 +0000
Received: from VI1PR07MB5088.eurprd07.prod.outlook.com
 ([fe80::c6b:1f98:e4e9:7240]) by VI1PR07MB5088.eurprd07.prod.outlook.com
 ([fe80::c6b:1f98:e4e9:7240%3]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 11:58:22 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>, Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add entry for i2c-axxia driver
Thread-Topic: [PATCH] MAINTAINERS: add entry for i2c-axxia driver
Thread-Index: AQHUkUjQStRrcBVA/U+Pk41ciGV4Pg==
Date:   Tue, 11 Dec 2018 11:58:22 +0000
Message-ID: <44c12ad6-8d22-3e68-9099-6f224917cce3@nokia.com>
References: <20181211091733.GA28051@localhost.localdomain>
In-Reply-To: <20181211091733.GA28051@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.165]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
x-clientproxiedby: HE1P18901CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::11) To VI1PR07MB5088.eurprd07.prod.outlook.com
 (2603:10a6:803:9e::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR07MB5855;6:dxkMtHEWnmRbGu36hopt6IZT/4fASgFICFeTMpHJ84jQ2QdUIaK+2OocLBRxZ9JwC2fJpGxVq6flWgnOGyDBD8215y6L+8RnP7hRTeW+NOxN/BHaPmUiqxfQ20MChl8Vwvwg3P0aRHFntLcfLhPMzwXq3yIXlt4kViehSCmXIFkZnf2aERX9nL1+9mj98FMYa/XgFgyf/+WSfoMh0QE/VVgIg9uZCXuOHocCE/8VYZZoPGS7Vu3tw3QuIW7l6FbCVT+VPbwuFn7mv/ZkbFCtxDz33gBhVUEvjYZKbJ5OtxMH9IYA4RslXWOJr4rE5w03EPE+5X9gf9qwtaUwqVe7mg0Lsq35vly/ZveThP9mRxjR4ihIR1gzaLdVrIj5XWthyuhTqgtLaTxacJkgVCY6oZkCpusk917FfLu8MZ7pnl6eeOstq2JqCVOIdbhDnU1iqCPgYJh5JrTD9pEse62O0w==;5:8gU+W6O0c0HIHljZJUgjgSX6ghsmAr3b37lAB/xSBZWbmHCfAjn4y9MD1K1wzNlA2BIbMseIIg6vuMtDq4IdlL4WwtOAQM09PHDuyS3kJnY/2RBsNRQq4AdTLd5pwTgIPRabdO1uAfxnllHONxoKwiCOYk1M3EC8JcJnPDrFG0Q=;7:Fh62p5fDbrtIsGrlN3hivrpS7eVcEu3lb1sXkBnxV5+nVuU+CczguPZC06gfkLJRf8eQkTAEriq00mFTZtB+JSBYUJSNj69t15QRgJW31JovhHirVrXS6ll0ug6Nm3w6cRiQ+RmNjiJF7nnVWQvEUg==
x-ms-office365-filtering-correlation-id: e07ef5a8-98e4-4ebb-77df-08d65f5ff319
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:VI1PR07MB5855;
x-ms-traffictypediagnostic: VI1PR07MB5855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-microsoft-antispam-prvs: <VI1PR07MB5855A873A5D2F977BDE939E288A60@VI1PR07MB5855.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(806100)(6040522)(2401047)(8121501046)(5005006)(3231472)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR07MB5855;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB5855;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(366004)(39860400002)(199004)(189003)(97736004)(64126003)(36756003)(3846002)(6116002)(6246003)(53936002)(2906002)(31696002)(6512007)(305945005)(7736002)(14454004)(58126008)(8936002)(81166006)(54906003)(110136005)(478600001)(316002)(25786009)(8676002)(81156014)(26005)(186003)(256004)(53546011)(386003)(102836004)(476003)(6506007)(14444005)(106356001)(486006)(446003)(11346002)(105586002)(2616005)(65826007)(6436002)(31686004)(229853002)(68736007)(86362001)(4326008)(575784001)(52116002)(65956001)(76176011)(5660300001)(6486002)(99286004)(65806001)(71190400001)(66066001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB5855;H:VI1PR07MB5088.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qOQdL9A1LNqwL4fx38I54WfyC9oJQDzZyhe4mkHrOne5eHZ5EL/u+CNJ3D8q/XWrfuS0H2++DKLEE4m7+GYhYXL4SzZzSH6hWtQxrgq1op5Cp6g4xEX9BhxgsCgb47kRVn5XLYCNb0B/qtqT/3hPObSIpJ6iLcyOkXB8AcY3nYxlAVNtzDHe2DQmhN8hiEccNCUqAD+/aJkXJK3O47iR7DfWdCEIkSaHLOxjer2zpH8y5jyu8W1FdtHk27USuR00e5EQR/pAOoWIARYgdMep/kfrC4bsb+t+UIcihMHZmYjs+HInwGgWnRYh/vKiryPX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F9FB8E6E776F844BD18B79C016BAA14@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07ef5a8-98e4-4ebb-77df-08d65f5ff319
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 11:58:22.6899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNCk9uIDExLzEyLzIwMTggMTA6MTcsIEFkYW1za2ksIEtyenlzenRvZiAoTm9raWEgLSBQ
TC9Xcm9jbGF3KSB3cm90ZToNCj4gQ3JlYXRlIHNlcGFyYXRlIGVudHJ5IGZvciBpMmMtYXh4aWEg
YW5kIHNldCBteXNlbGYgYXMgbWFpbnRhaW5lci4NCj4gDQo+IEV2ZW4gdGhvdWdoIEkgZG9uJ3Qg
d29yayBmb3IgSW50ZWwvTFNJIHdobyBpcyB0aGUgbWFudWZhY3R1cmVyIG9mIHRoaXMNCj4gSVAs
IEkgZG8gaGF2ZSBhY2Nlc3MgdG8gc29tZSBkb2N1bWVudGF0aW9uIGFuZCB0aGUgYWN0dWFsIGhh
cmR3YXJlIHVzaW5nDQo+IHRoaXMgZHJpdmVyIGFuZCBJJ20gZmFtaWxpYXIgd2l0aCB0aGUgY29k
ZS4NCg0KU291bmRzIGdvb2QgdG8gbWUsDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGlu
IDxhbGV4YW5kZXIuc3ZlcmRsaW5Abm9raWEuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IEtyenlz
enRvZiBBZGFtc2tpIDxrcnp5c3p0b2YuYWRhbXNraUBub2tpYS5jb20+DQo+IC0tLQ0KPiAgTUFJ
TlRBSU5FUlMgfCA3ICsrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IDA3
NjdmMWQxYjU3OS4uMjk2MWI0ZDBhOGU4IDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiAr
KysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtMjYzMyw2ICsyNjMzLDEzIEBAIFM6CU1haW50YWluZWQN
Cj4gIEY6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9heGVudGlhLCoN
Cj4gIEY6CXNvdW5kL3NvYy9hdG1lbC90c2U4NTAtcGNtNTE0Mi5jDQo+ICANCj4gK0FYWElBIEky
QyBDT05UUk9MTEVSDQo+ICtNOglLcnp5c3p0b2YgQWRhbXNraSA8a3J6eXN6dG9mLmFkYW1za2lA
bm9raWEuY29tPg0KPiArTDoJbGludXgtaTJjQHZnZXIua2VybmVsLm9yZw0KPiArUzoJTWFpbnRh
aW5lZA0KPiArRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMtYXh4
aWEudHh0DQo+ICtGOglkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWF4eGlhLmMNCj4gKw0KPiAgQVo2
MDA3IERWQiBEUklWRVINCj4gIE06CU1hdXJvIENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYkBrZXJu
ZWwub3JnPg0KPiAgTDoJbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnDQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KQWxleGFuZGVyIFN2ZXJkbGluLg0K
