Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C77C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2472089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Y2K9I+QG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfBTUvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:51:36 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:8149 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBTUvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:51:36 -0500
X-IronPort-AV: E=Sophos;i="5.58,392,1544511600"; 
   d="scan'208";a="26627450"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Feb 2019 13:51:34 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 20 Feb 2019 13:51:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPM5gtRS89YmVkLPoZjF3jM5kPkUik32DrNH1AFgdL8=;
 b=Y2K9I+QG1bLTH02aJPvfviJf4tafQbyMBfd6eP+y7px8Nj/I4ZYnhRWZHSFq/3W/VVDYh0tK1/Wq5XXjV6Ef6VfQmPlNqio+iTt04AxW5nlHf+s/JimCbPhXh7FJeMcRBn0T3OXiNo7UGobOvIR1PzdlE+RGcSlPSrllyiirIfU=
Received: from DM5PR11MB1850.namprd11.prod.outlook.com (10.175.92.17) by
 DM5PR11MB1850.namprd11.prod.outlook.com (10.175.92.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 20:51:32 +0000
Received: from DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::4125:8d55:234b:a4a1]) by DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::4125:8d55:234b:a4a1%11]) with mapi id 15.20.1622.018; Wed, 20 Feb
 2019 20:51:32 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <colin.king@canonical.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <bbrezillon@kernel.org>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] mtd: spi-nor: cadence-quadspi: fix spelling
 mistake: "Couldnt't" -> "Couldn't"
Thread-Topic: [PATCH][next] mtd: spi-nor: cadence-quadspi: fix spelling
 mistake: "Couldnt't" -> "Couldn't"
Thread-Index: AQHUxUGBTHS8Qr7/UUu2H/rO0QEfqKXpMZEA
Date:   Wed, 20 Feb 2019 20:51:32 +0000
Message-ID: <1dfae650-fd74-b1ad-3175-f7497214fc39@microchip.com>
References: <20190215151547.17532-1-colin.king@canonical.com>
In-Reply-To: <20190215151547.17532-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P193CA0006.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::16) To DM5PR11MB1850.namprd11.prod.outlook.com
 (2603:10b6:3:114::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.52.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d6f02ad-b76a-4d98-2840-08d6977531fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB1850;
x-ms-traffictypediagnostic: DM5PR11MB1850:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtETTVQUjExTUIxODUwOzIzOmJ1cVVtZ0pqNVRaVEN6Qm1kUU8rcko4TkNL?=
 =?utf-8?B?a2JLd25FTUVYTEVzOXlNRzFVazZpUWFzMWtpZXprTUdqWDJXejBHRVFybHl3?=
 =?utf-8?B?ZHdqdStUVWxkVUx2SDVWbC9GOFF0L2xZTEZNeUo5WHNYZU8vM0k5bFZrV1VC?=
 =?utf-8?B?TlNtTDlRTUZic3R0Q1hjNzRIUzhTZEs0ZjJFdXJwbEJPR3JYaU4vM2dYUUlR?=
 =?utf-8?B?N3R0RWdWZlRyVGV3SW1QMTJzQW5sQ2F3M3ozVHNRcGplcFhVNHZyWGxJRXpx?=
 =?utf-8?B?ZjRHRFpZcDhiTHRGa3JGTnpYcWdXRFBOb3dmRTBuWGQ3VFg2RXRZdFY2OWMr?=
 =?utf-8?B?a0lsd1VwOWFuRWNjVHZ1dE5EK2x5dGp2aXZyZnZPekZRdDUwVHdIZlRNUlgv?=
 =?utf-8?B?OGh2M3dWZUlyUjlNQ1RFNWkwZkRrSmZzMTFMWUo5amoxMkF6SFpDNk52cG82?=
 =?utf-8?B?R3ZUVXBxcE5BK09JcDgrem4vYXJ1WFdJTGhlWHgwUFRiNkZxVnVYWkZuQlZW?=
 =?utf-8?B?cnJ0c2JydlhCb2dlUFJ2MjRMekpEdXJsbE9qVFZmT1E3SS9HSXg1OEwxZUtV?=
 =?utf-8?B?N3VDU3IwSFlTMy9XYUNueXYzaHBWUTFnOUI2eEsyNkNTWVpMbWszcVJGSkw5?=
 =?utf-8?B?dS9GS2loUDNIb2Y1M25aUWk3SkxWNnpuSTh0RDNtM0VEd25wby85RzhUV3U2?=
 =?utf-8?B?OVpZZ1QxUkZxb09zcks0L0p3WVZFQ1lPUVFlSk9VQXBaOERKQXlKc056bW43?=
 =?utf-8?B?dXljNGJjMnhCRmtYSnJpYUhtZHB4UFoyb0ZhcXVPZnc2SnI1djJiNzBIWEFi?=
 =?utf-8?B?TzZMa2lEQ1ZsV2N0Ym1mMi9xQWlCVUI2S2hWN2NORG15d1ExeUlKK1RUQmps?=
 =?utf-8?B?amtWUFVsdlQycDdtbm5YcUhWTjVTRkMrQ3RveWRKbmUyV0luQ3RJUTQ4NWQ3?=
 =?utf-8?B?VDhFaitGM05McFJRbE9zQVFjbWNzaUFCL1pvOThVYm9hYWpGZ2NSTGdyMDl5?=
 =?utf-8?B?bTFldmRaU3BBd3g5cm0zTXVDRVZjVXYvMlRaZWVrd2RIQnFDeGxtUkRGZUtB?=
 =?utf-8?B?ekVwaGVaaXhqTm1BQ0R5eUhlem9keUUxQ2cxVnllV2l1MnpWYmZyclZEbHRJ?=
 =?utf-8?B?L2N4YWZ0MEl2Y3hyV09BQmhvT2lkZHEySjlnblROekRFM1ByQjJMRjhLQjg1?=
 =?utf-8?B?VHoyd3FLOUJIU04vanQ0QW9CVGNHUkJDdjdtWUFlOHR2eWNSL2c0NS8wZXVU?=
 =?utf-8?B?amlOSVFESDNKUW9qZXRHWks2bTEzKysySXEzZFFkSVc2NG5GMCtZQlE3OWhG?=
 =?utf-8?B?V0RodC9weVBZVmNuNk03c1hyaGswQmJOV3h0aDB4TldNbXl1ZGZMeDNXV3Ra?=
 =?utf-8?B?aHJla2pnRVNrU3hYeXgxY0dMeXdRQWE0TitMVUVQYTIyMEdWcVdWbDdkM3BZ?=
 =?utf-8?B?bVFTZ2RsVXV6Z2Y0cXJpa2VFcittckYxK3JhOUs2aHhMQzlZcmJGUnh6K3U5?=
 =?utf-8?B?MVRyYisxU1dyWjRVdjB1bS9na3pPVmR0TEFSN1ByNHRmeU9DWXdyVS9meHVZ?=
 =?utf-8?B?QXlEMkk5aW5UTmdLMmxmYm9VVkpmRjJPV3VReWV1a3N3N1ZzaFB0aGFnbDIv?=
 =?utf-8?B?UVRteUhMVGc4LzkrTWtBdXNzV1ZUa0IwOVlqUzJ0WXpxZU5YL2hXM2ZOandy?=
 =?utf-8?B?cnVrK3ViQlNkYzJjZ09NY3dPd3JNb1FHRGI4c0VxaTR5bGpUaGw2TDZYUmFQ?=
 =?utf-8?B?TnFRcnNhajdCOWJUSUppVldxWndtUUtlamhkRlVGb1V5VEZEa0xxSk9KRndJ?=
 =?utf-8?B?SXBUMVBkOUZyZjhQNHZuUW9QV1d0VHRubzZ2NmhoMTdTdUE9PQ==?=
x-microsoft-antispam-prvs: <DM5PR11MB1850EF55E4F031CF305C4EF5F07D0@DM5PR11MB1850.namprd11.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(6512007)(71200400001)(386003)(25786009)(6506007)(2906002)(5660300002)(8676002)(97736004)(53546011)(6436002)(2616005)(476003)(305945005)(14454004)(256004)(229853002)(486006)(68736007)(102836004)(99286004)(4326008)(14444005)(36756003)(3846002)(6116002)(72206003)(52116002)(76176011)(6486002)(8936002)(106356001)(316002)(4744005)(446003)(31686004)(186003)(110136005)(66066001)(478600001)(26005)(2501003)(81156014)(53936002)(54906003)(71190400001)(81166006)(31696002)(86362001)(7736002)(6246003)(105586002)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1850;H:DM5PR11MB1850.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cOgB/Rk3wNhU2Caeovk2g3mH8VmORyocsDK0ED+818VSHG/fjh+jjt7IcxPUtA+96qnJG6zzb/s0/b2JE2cDIpyVyJfXiZatM770/Yd4kCaPDv6uWni79EqPRFu1i8pj3495oWXoXip2YKJZ9KS/Ei2lFy4dFiZ3CSgcqLAfaCf2pUoijJFX5fzaSqXggnkhSGC8ulGYHLxlA+eeV3+vAu2tE92K4AR0334pwrSFh/Vc9AWX68U0G3X3qdQm7ZSn6CMHDZUIap1WzTK6bpzzM1Er/cnDLxtEi5mQd2hQ0w2ZnvTrk+EzfRDOoePCRi5TpmQBPJMLxmwuE/VCuJb+llJvLvHKgp3luf4nlAUZYTVO5QwMA7pJA3x6rzEkCggHpRdyQqId/Umd3h65Kv1zzjD75N1Rm42EG+bRDkW43fQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD8F9F791B7BE141AC3DCF7CDD05DCFF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6f02ad-b76a-4d98-2840-08d6977531fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 20:51:30.5933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1850
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzE1LzIwMTkgMDU6MTUgUE0sIENvbGluIEtpbmcgd3JvdGU6DQo+IEZyb206IENv
bGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IA0KPiBUaGVyZSBpcyBh
IHNwZWxsaW5nIG1pc3Rha2UgaW4gYSBkZXZfZXJyb3IgbWVzc2FnZS4gRml4IGl0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNv
bT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY2FkZW5jZS1xdWFkc3BpLmMgfCAy
ICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5jIGIv
ZHJpdmVycy9tdGQvc3BpLW5vci9jYWRlbmNlLXF1YWRzcGkuYw0KPiBpbmRleCA1NjUxMmMwMzY4
ZjkuLjc5MjYyODc1MGVlYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jYWRl
bmNlLXF1YWRzcGkuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNw
aS5jDQo+IEBAIC0xMjQ5LDcgKzEyNDksNyBAQCBzdGF0aWMgaW50IGNxc3BpX3NldHVwX2ZsYXNo
KHN0cnVjdCBjcXNwaV9zdCAqY3FzcGksIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApDQo+ICANCj4g
IAlkZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiAgCWlmICghZGRhdGEp
IHsNCj4gLQkJZGV2X2VycihkZXYsICJDb3VsZG50J3QgZmluZCBkcml2ZXIgZGF0YVxuIik7DQo+
ICsJCWRldl9lcnIoZGV2LCAiQ291bGRuJ3QgZmluZCBkcml2ZXIgZGF0YVxuIik7DQo+ICAJCXJl
dHVybiAtRUlOVkFMOw0KPiAgCX0NCj4gIAlod2NhcHMubWFzayA9IGRkYXRhLT5od2NhcHNfbWFz
azsNCj4gDQo=
