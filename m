Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11B0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E20222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yDUVuNdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbfBMLuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:50:22 -0500
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:10400
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbfBMLuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOg5zvBh6fkBNw83pzT9GeW6V1sh4agQVBP+6SXgKGQ=;
 b=yDUVuNdRumVgs6khB+g+PJmgKcfy/NvLOVVJuN3dvqPAd5arrd0HJIVzBt7Kgaywrr7zpRKu/jQGq0vw8KyZ7Yy0D57dPcxwSbjs28niuxOBDn8mASEM9okpMPXkEYZ5a0lRadabOD3uMP9TvChANgcKxZEi7c+V8omIoDz5tYs=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB4761.eurprd04.prod.outlook.com (20.176.233.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 13 Feb 2019 11:50:18 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5%6]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 11:50:18 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 2/3] arm64: mmu: early_pgtable_alloc: remove unnecessary
 comments
Thread-Topic: [PATCH 2/3] arm64: mmu: early_pgtable_alloc: remove unnecessary
 comments
Thread-Index: AQHUw3+88usP6fkoZk2E9fP50sbv3qXdlZAAgAAHwaA=
Date:   Wed, 13 Feb 2019 11:50:18 +0000
Message-ID: <DB7PR04MB4490B00D34CCC1E3BC475B8888660@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190213094831.7292-1-peng.fan@nxp.com>
 <20190213094831.7292-2-peng.fan@nxp.com>
 <20190213112136.GB22119@lakrids.cambridge.arm.com>
In-Reply-To: <20190213112136.GB22119@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e79c3ad5-8deb-46a2-edb3-08d691a96d58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4761;
x-ms-traffictypediagnostic: DB7PR04MB4761:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjdQUjA0TUI0NzYxOzIzOkRtT1VhVVRFUHVJalR2SkF6S0lWMzNRMFRk?=
 =?gb2312?B?cGkvYmtjeTdqajlQaVZwSS9IZkNqekFCRUlKZW9yOCtzajhTcEh1aXZ6SFhO?=
 =?gb2312?B?YTJDWXdLaFhpRXhwZVpNV2NmeDdGSGFoaVpOZVF1ZVpveXhmMElhcER4TEha?=
 =?gb2312?B?QnhnT1BqdzNzRlBvSjF6aE1seUhpc2EvNnZseGgzcUpSV09BclpUMW9seE14?=
 =?gb2312?B?d0RXaml5RnlIcUxzckJvQTNld0Y2OGppWDJSK2NIL2lHNHFOZ1lpOHVGa1Ri?=
 =?gb2312?B?YnFRaDVkd2NxZlZnUnJwTll2MlZ3cUhZblM4eW1JK0NuMWpJbU5rTHdIaGN1?=
 =?gb2312?B?NWR3bGFGQUhGNzFzOUI0dGhWNDcwZUhFTmxXQmN6cVpRdk4vNHNZaitmTDVP?=
 =?gb2312?B?dmRBS1A1YTF3cllCSXZJYWMrS21FTlFNN1FiOFVkWktseVpGTXVvaEpNMVFl?=
 =?gb2312?B?M1F5UFA3d1V0dlh6dkoxbjJ4b3cwREcyekRFSUwrNGFpV2pCZldTRTRCUUVU?=
 =?gb2312?B?c204R1RVd0dqdDVhaE9jQ25SY1VDSDFwZXFDTHNZYjc1ajFXY01kcnhCeEw4?=
 =?gb2312?B?QWxOTTA4Qmh0L05USEZ4Y1BxWi9SMkxJZ2F1aGZnckZIU2ZUV1lGSEdkMUJz?=
 =?gb2312?B?dzBRb3kyV0tyQXFCaEJQbW5DRVRFTnRXY2JScndjMUl3TUtKbGd2eGcwaXkv?=
 =?gb2312?B?dTk2K01xMm1OZm1CZ2NSdUZ5UkZSeERWQmZHN2krTCtSQ0RLejNNelNRejZZ?=
 =?gb2312?B?ZVlRQW9GRis3NDlaSDVrVytEYjlMOGZYOTdPdnoyN1pXRDFIYlJHK1RCMHpQ?=
 =?gb2312?B?azRMR0JxMHl1SkVDUCtkQmJKbkJwVnB4T0sreXllRmdTOUU1RlgySjl5Q3dl?=
 =?gb2312?B?OHErVlV1TDgydVI0N2UzZTBIQWxVYXNodDRtTU9IUzladGNkdXpBeWhyQzJR?=
 =?gb2312?B?SkN6cXpBRUhaVnpHZERQMGx3QkFBdEp1ZVVyandiK1VNMkNXRUVUbU5uRlRW?=
 =?gb2312?B?eElLNUJ3eTExWGd3Y0w5eW9URTluMElWUkhncWdjdGpDaGFUZDYrVWdCenRX?=
 =?gb2312?B?aGx3aGFJSVd1OXFKckxZdjdvU25CVXZROUQyM0REMHRLTnJDbTNQbnhNYkFQ?=
 =?gb2312?B?TmYyTjJUTzVKc3pwTVZXeXdWZTV2SXIzSmtDeUJXTlhQMzdCbHp0RXVSeVFt?=
 =?gb2312?B?dlgxekYycmVEOVhuTk1KYnpHcUdOOXVJN0RzY2JlOXkxMldlOWlDdFBVbFhG?=
 =?gb2312?B?Vk4xVE5iZlBOMzBQQUt3V2FUM2JVdTgyRHZhcW5xcldSbkZjYmYzMjJTWnd1?=
 =?gb2312?B?dXNRL1p2bGtFbUtZRm1hYW11aXpQVGNXdTBWMVZZYkF1aTdVbmx5TzZTVlg5?=
 =?gb2312?B?ZXM2dzBXSUYrK1phVE52Qjd5eUxiU2xXaVpLbmZBWS9FdWhYa3R1bUppQXRG?=
 =?gb2312?B?OTVGOUdzcW01a0plQ25KRG5pL014YjNtalhrNkNLN2N1WUR6MWVhWUlZQjU4?=
 =?gb2312?B?WmVpckZ1N3ZtdmQ3alU2ZjZoMzFuc011cndjeUFlTkh5UnRSdTE0anlmK0hD?=
 =?gb2312?B?c2diZU03WGg0S3J4YzJ6RUM5WWp1bUx2VVdGMGhlK3VUbEU2QWozdzF6b255?=
 =?gb2312?B?Um9HVVZrY0JSN0hMWlpHSjNDeHhFY1pGMk1DejFBNHh4MmtzOGhRcnRMbVFB?=
 =?gb2312?Q?smeKn6jd+q/BBaXwVA=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB47617755A663B0DFAC41CC1188660@DB7PR04MB4761.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(366004)(396003)(13464003)(189003)(199004)(476003)(446003)(6116002)(3846002)(11346002)(486006)(44832011)(53936002)(6246003)(229853002)(7736002)(74316002)(305945005)(97736004)(6916009)(71200400001)(71190400001)(6506007)(6436002)(53546011)(26005)(102836004)(186003)(8936002)(7696005)(99286004)(105586002)(106356001)(478600001)(25786009)(2906002)(81156014)(81166006)(55016002)(9686003)(4326008)(14454004)(8676002)(86362001)(66066001)(54906003)(68736007)(7416002)(256004)(316002)(76176011)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4761;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0sD4P9bdtyTNKORioJKl9bCsRaXNs8GeTiY+0hxdDYSzy3mBXdvsMyU4GK8NNLXRvSuzHkNvYAEZJAETwDdJ+GGZSFjXU/UvVh+NJmlQ8tXSnOFAiiJgWfb/9mTB+YDVVU2MzkiToVQlVSReCpTwZa+E7XPPCA2uVxTdySSA20UBvRyp4JHx0YGRpjQCuWJvVDaO0HTEKLJe2UrUMUjhmU/U6i/Fm5AheDBnkn6EtbDL4/ya8t4P/hMMqaEbO76TTicPQHFY33rXJMzlMRB3/IrZmCb47jQDqlYsJTO2hM4l6w2UcJ7FnIQqwjkJ7jq4NN7HhgKFY3rULkylvhIqhfkww81XLayM0AasuWTYryVXg6hqQgafskJM0HnBbAoSDl1YRKQciQ7q6Eky00SkPUuWkCRWeFNv17YtI8BEhQQ=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79c3ad5-8deb-46a2-edb3-08d691a96d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 11:50:18.7627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4761
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrIFJ1
dGxhbmQgW21haWx0bzptYXJrLnJ1dGxhbmRAYXJtLmNvbV0NCj4gU2VudDogMjAxOcTqMtTCMTPI
1SAxOToyMg0KPiBUbzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IENjOiBjYXRhbGlu
Lm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gYXJkLmJpZXNoZXV2ZWxA
bGluYXJvLm9yZzsgeWFvanVuODU1ODM2M0BnbWFpbC5jb207DQo+IGNwYW5keWFAY29kZWF1cm9y
YS5vcmc7IHJvYmluLm11cnBoeUBhcm0uY29tOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHZhbi5mcmVlbml4
QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gYXJtNjQ6IG1tdTogZWFybHlf
cGd0YWJsZV9hbGxvYzogcmVtb3ZlDQo+IHVubmVjZXNzYXJ5IGNvbW1lbnRzDQo+IA0KPiBPbiBX
ZWQsIEZlYiAxMywgMjAxOSBhdCAwOTozNzoyOUFNICswMDAwLCBQZW5nIEZhbiB3cm90ZToNCj4g
PiBUaGUgZW1wdHkgemVybyBwYWdlIGhhcyBiZWVuIG1vdmVkIHRvIGJzcyBhcmVhIGJ5IGNvbW1p
dCA1MjI3Y2ZhNzFmOWUNCj4gPiAoImFybTY0OiBtbTogcGxhY2UgZW1wdHlfemVyb19wYWdlIGlu
IGJzcyIpLA0KPiA+IGFuZCBpdCBhbHJlYXkgYWRkZWQgImRzYiAgICAgaXNoc3QiIGluIGhlYWQu
UyB0byBtYWtlIHN1cmUgdGhlIGVtcHR5DQo+ID4gemVybyBwYWdlIHZpc2libGUgdG8gUFRXLg0K
PiA+DQo+ID4gVGhlcmUgaXMgbm8gY29kZSB0byByZWZsZWN0IHRoZSBjb21tZW50LCBzbyByZW1v
dmUgaXQuDQo+IA0KPiBUaGUgY29tbWVudCBiZWxvdyByZWZlcnMgdG8gdGhlIG1lbW9yeSBwb2lu
dGVkIHRvIGJ5IHB0ciwgd2hpY2ggaXMgemVyb2VkDQo+IGJ5IHRoZSBtZW1zZXQuIFRoZSBjb21t
ZW50IGRvZXMgbm90IHJlZmVyIHRvIHRoZSBnZW5lcmljDQo+IGVtcHR5X3plcm9fcGFnZS4NCj4g
DQo+IFRoaXMgY29tbWVudCBpcyBjb3JyZWN0LCBhbmQgc2hvdWxkIHN0YXkuIFBsZWFzZSBkcm9w
IHRoaXMgcGF0Y2guDQoNCkkgdW5kZXJzdGFuZCB3cm9uZy4gWW91IGFyZSByaWdodC4NCg0KVGhh
bmtzLA0KUGVuZy4NCg0KPiANCj4gVGhhbmtzLA0KPiBNYXJrLg0KPiANCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNo
L2FybTY0L21tL21tdS5jIHwgNCAtLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvbW0vbW11LmMgYi9hcmNoL2Fy
bTY0L21tL21tdS5jIGluZGV4DQo+ID4gMDY1MjAyZGEzYWQyLi5mNjFmYTdjOGZkMmUgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9tbS9tbXUuYw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvbW0v
bW11LmMNCj4gPiBAQCAtMTEzLDEwICsxMTMsNiBAQCBzdGF0aWMgcGh5c19hZGRyX3QgX19pbml0
DQo+ID4gZWFybHlfcGd0YWJsZV9hbGxvYyh2b2lkKQ0KPiA+DQo+ID4gIAltZW1zZXQocHRyLCAw
LCBQQUdFX1NJWkUpOw0KPiA+DQo+ID4gLQkvKg0KPiA+IC0JICogSW1wbGljaXQgYmFycmllcnMg
YWxzbyBlbnN1cmUgdGhlIHplcm9lZCBwYWdlIGlzIHZpc2libGUgdG8gdGhlIHBhZ2UNCj4gPiAt
CSAqIHRhYmxlIHdhbGtlcg0KPiA+IC0JICovDQo+ID4gIAlwdGVfY2xlYXJfZml4bWFwKCk7DQo+
ID4NCj4gPiAgCXJldHVybiBwaHlzOw0KPiA+IC0tDQo+ID4gMi4xNi40DQo+ID4NCg==
