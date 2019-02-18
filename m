Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA83DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F2D21479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="o4AHmCc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfBROyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:54:25 -0500
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:35008
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729907AbfBROyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWvvHy8HvmzxLUSIatbAIxHkUpLUPw7/+dRpeIEGJ5I=;
 b=o4AHmCc4nbYjNX7dlrn4WV+RcJJIlva2YmqvIDvcnDEGrdvvpjmsOWu8ch8azJgqz2smBGem6lkDQYjieo7jA8bU2n4DrG+iVQjPhfI2i/D18TjHgNDKBoC/WTynYNcHy4cJiGtdLCuylS3buARtJtEFegAamtZWxBPg9TL19sc=
Received: from HE1PR05MB3257.eurprd05.prod.outlook.com (10.170.243.19) by
 HE1PR05MB4636.eurprd05.prod.outlook.com (20.176.163.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 14:54:19 +0000
Received: from HE1PR05MB3257.eurprd05.prod.outlook.com
 ([fe80::550a:a35e:2062:792a]) by HE1PR05MB3257.eurprd05.prod.outlook.com
 ([fe80::550a:a35e:2062:792a%7]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 14:54:19 +0000
From:   Tariq Toukan <tariqt@mellanox.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>
CC:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/mlx4_en: fix spelling mistake: "quiting" ->
 "quitting"
Thread-Topic: [PATCH] net/mlx4_en: fix spelling mistake: "quiting" ->
 "quitting"
Thread-Index: AQHUxxUCv2ce2u0HVkKjUo1mCtzjkqXlbnAA///sEYCAAEr2gA==
Date:   Mon, 18 Feb 2019 14:54:18 +0000
Message-ID: <3dbc29c2-2f6f-5854-2ac6-729fba100f79@mellanox.com>
References: <20190217230331.18678-1-colin.king@canonical.com>
 <2a1a6636-7795-addb-d7b7-711a23dbafa5@mellanox.com>
 <20190218102557.GC17104@kadam>
In-Reply-To: <20190218102557.GC17104@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P195CA0049.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::26) To HE1PR05MB3257.eurprd05.prod.outlook.com
 (2603:10a6:7:35::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1bae95d-2b91-4be5-26a2-08d695b0f585
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4636;
x-ms-traffictypediagnostic: HE1PR05MB4636:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtIRTFQUjA1TUI0NjM2OzIzOmx3KzlrVjROZm83NGdGa0MzVnBGbisyc1M1?=
 =?utf-8?B?MjVLejdwK0RaQ1c3K3hxV0V0Nzk5L05GZy9zYTkwZkpDRWszN20wRXFBNEhD?=
 =?utf-8?B?UzJrVXNaRXFMRDZPQlVBUEpmeEJJbVVnZU1TbkxEMG9wQklzNmNEOTUyRXdz?=
 =?utf-8?B?OGYrejA2VDJNUlI1VEt1Y29UYnVveGhuQ1h4NERvZk1iTUhRakFzS0J1TXY3?=
 =?utf-8?B?SnZUc3VEMDIvYWpXM0lRempZbndnTkJ6NHpkaXpwaTZjeElTbGoveTVVUS9J?=
 =?utf-8?B?STU2TXZNamhiaXNoMWVRNFhhZWgySlBucmpIdTl2Q3ZTRGtpQTdEQm42Q2Vu?=
 =?utf-8?B?WHE4MStkWVduVFByamlrWFlURVBEYmlBNnpvc0ZOVjVrRFNwSmN3V1hzRU5n?=
 =?utf-8?B?S05pYWxIdUdFSUk2a0ZHclRIcU9Yb2dDamt6VmVOMUhuMm9QUUUvTEV4Z1dT?=
 =?utf-8?B?S29hTmIxZXdsREFWMWhYTnovU2hERW1iV1pPSVlxR3JyZURGVXErWE1kVVJB?=
 =?utf-8?B?WTNmV2Z3dm45T2VjMVNCTmhiK2svV1NVMUsxUU1iYzlJNWpPMHI3cm9TbDhp?=
 =?utf-8?B?RVJ5VE9BVEpCRUV2QklsaS9aaWJ6RlVhN05lVVlWS2xCckZVTFRDTFdhUXhD?=
 =?utf-8?B?TUE1c3ZjRm9Bbit1TEZlM2pKcWg5V1dHa2lncnBNci92Y1Q3eHF2d3luWnhy?=
 =?utf-8?B?d1psTmtTS1ZVSTRkeVFFYzFTS1M0QjR2RHE5VHh0bFpZQlhBOFB6bjh4RUh6?=
 =?utf-8?B?cHFYV0srZUIvVi9yL0pudXNjcHVmRkdNVFhwbHhFMVdnUDJnNEZiaUFPSWxP?=
 =?utf-8?B?WGtGaVl1UHBveWxTMFdaYitxaU9FNEc5WmhYYUxxVjJnUE1XaVVhbDVURnRq?=
 =?utf-8?B?VFFWWmVGZWpWKzMxNkFOK3dJN3k0WEVDYXF5L3Yzdk1YeVI4SDdVT0RoU1V2?=
 =?utf-8?B?cUxUTWY5a2FxaHNYZW93L0xrRFNZUHdxaGZNQ04xMzZiQ2tZa3JLSTIvMVlC?=
 =?utf-8?B?N0JsWExoaUJnakZLUi91TklwN1RmQWVMNDRLaHN5NVdVNXAyYlpraTlNajhF?=
 =?utf-8?B?VHNxaWVRUmFTVFRJRGYvV3ljdlJ2Y2pyVmI1V1pPZDJzWjIzSThqL1M1cUV1?=
 =?utf-8?B?UHA3WWpwd3VEUzZOWmFxZkU5cjY1UC90QzhTYmlTMjFBblhjUE1FbUVxOHRT?=
 =?utf-8?B?VWlqU1hDZWtQM05FeFc1K3ZvSFJ6UGZFb2ZZR2JXOXZ5NFlMVmFjbnFFK2Ju?=
 =?utf-8?B?YWZHSllnUGsrVjZwMkdJWDExNk9yWThvVEtSVHpGZ0lHOURxcjNqNm82ckZU?=
 =?utf-8?B?MGVKWGpMODZZd20zSTlyWm1IZG43Z0RTTXpVTjdIZTVmSXQzWVZzZXB2cHBT?=
 =?utf-8?B?OFd0MDBCaUdvQk9EcWtxR3c1NnEzWWhaSmRyZG9QdC9PazhFRFF6R0NPWFdx?=
 =?utf-8?B?Uitvd25zZ2Z4bEdqR1FQVHVLN3NZVG9ZRDFxOGRXb1M4bEhJWnplZzJHd1B1?=
 =?utf-8?B?aE5DZ3duNjZaclB2Q1U0QnJCVkcvWDhNSzhsMGlRYWMrcGVDL2JmMURtdXgr?=
 =?utf-8?B?YjQ5eWF2SFZSUGd1OEN3NjVFL1BoQ2dUNHFDVHFtZHhkTWlmZUQ4SHRUY3B6?=
 =?utf-8?B?S1RsT0IrODBBM3JuekZUYlAxd0JYRjhRZGRKQ21lYnN4UmFSZU90Q3FITnln?=
 =?utf-8?B?QnRYemZQTXVDdzRWcDBFKzZ2WGtQd2dEd2VUeFE3TEpXYXBWSTh4Y2FDdUF0?=
 =?utf-8?B?OGhVci8wTmV2YXZ3SUhtdz09?=
x-microsoft-antispam-prvs: <HE1PR05MB4636F83077729AA6FED622A1AE630@HE1PR05MB4636.eurprd05.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(53546011)(31686004)(386003)(446003)(6506007)(97736004)(6436002)(53936002)(110136005)(76176011)(8936002)(486006)(316002)(6486002)(6512007)(11346002)(6116002)(3846002)(2616005)(5660300002)(54906003)(229853002)(256004)(105586002)(14444005)(71190400001)(71200400001)(36756003)(106356001)(26005)(476003)(68736007)(25786009)(99286004)(81166006)(186003)(7736002)(14454004)(8676002)(6246003)(66066001)(31696002)(305945005)(81156014)(478600001)(4326008)(86362001)(52116002)(2906002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4636;H:HE1PR05MB3257.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NEplJgcsAqOln6wlGwyEii33G5+/EwZg8IJbBT5OWIlPYq6nUtbw1FJ4BRZZP4hGNtvTgPr0Ygtm/0aiKK9rI/OLne53V0m1/QSDlOkdP/s8W0vx2bPliAvXwREQhSnFBOuq5jaa3aWvj72NE3BRZYIo2HlmJHxcgfLMWOADfI6qMh5SFo9Esy90JczMfj1s/5fqJGwx6nIkaSvaY6APOXlodj+6rdIBAFZgjklkNP40oSVO19mf4TuAK6yB+5KAH/lXS8UStL1zz3yptp/UPomu8Z733SIO0vlDxwXGqmud+cPtX8Pci0y5fqrFu9iydcNlRYniwo+9D88ZpSPJ4avBFRqgbJR890p3LdJBl6d8f00UJYEa2ZUqMTctQYqe8RpyOxtsw8MO2UvhujrZq52coUrASvAUOdDjzvAW1jM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD3D1790EF69374298A681E7FB132C31@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bae95d-2b91-4be5-26a2-08d695b0f585
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 14:54:17.5373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIvMTgvMjAxOSAxMjoyNSBQTSwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4gT24gTW9u
LCBGZWIgMTgsIDIwMTkgYXQgMDk6Mzc6MjJBTSArMDAwMCwgVGFyaXEgVG91a2FuIHdyb3RlOg0K
Pj4NCj4+DQo+PiBPbiAyLzE4LzIwMTkgMTowMyBBTSwgQ29saW4gS2luZyB3cm90ZToNCj4+PiBG
cm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPj4+DQo+Pj4g
VGhlcmUgaXMgYSBzcGVsbGluZyBtaXN0YWtlIGluIGEgZW5fZXJyIGVycm9yIG1lc3NhZ2UuIEZp
eCBpdC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5n
QGNhbm9uaWNhbC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVs
bGFub3gvbWx4NC9lbl9uZXRkZXYuYyB8IDIgKy0NCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0L2VuX25ldGRldi5jIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NC9lbl9uZXRkZXYuYw0KPj4+IGluZGV4IDZiODg4ODFiOGUzNS4u
YzE0MzhhZTUyYTExIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxh
bm94L21seDQvZW5fbmV0ZGV2LmMNCj4+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxs
YW5veC9tbHg0L2VuX25ldGRldi5jDQo+Pj4gQEAgLTMzNjAsNyArMzM2MCw3IEBAIGludCBtbHg0
X2VuX2luaXRfbmV0ZGV2KHN0cnVjdCBtbHg0X2VuX2RldiAqbWRldiwgaW50IHBvcnQsDQo+Pj4g
ICAgCWRldi0+YWRkcl9sZW4gPSBFVEhfQUxFTjsNCj4+PiAgICAJbWx4NF9lbl91NjRfdG9fbWFj
KGRldi0+ZGV2X2FkZHIsIG1kZXYtPmRldi0+Y2Fwcy5kZWZfbWFjW3ByaXYtPnBvcnRdKTsNCj4+
PiAgICAJaWYgKCFpc192YWxpZF9ldGhlcl9hZGRyKGRldi0+ZGV2X2FkZHIpKSB7DQo+Pj4gLQkJ
ZW5fZXJyKHByaXYsICJQb3J0OiAlZCwgaW52YWxpZCBtYWMgYnVybmVkOiAlcE0sIHF1aXRpbmdc
biIsDQo+Pj4gKwkJZW5fZXJyKHByaXYsICJQb3J0OiAlZCwgaW52YWxpZCBtYWMgYnVybmVkOiAl
cE0sIHF1aXR0aW5nXG4iLA0KPj4+ICAgIAkJICAgICAgIHByaXYtPnBvcnQsIGRldi0+ZGV2X2Fk
ZHIpOw0KPj4+ICAgIAkJZXJyID0gLUVJTlZBTDsNCj4+PiAgICAJCWdvdG8gb3V0Ow0KPj4+DQo+
Pg0KPj4gSGkgQ29saW4sIHRoYW5rcyBmb3IgeW91ciBwYXRjaC4NCj4+DQo+PiBSZXZpZXdlZC1i
eTogVGFyaXEgVG91a2FuIDx0YXJpcXRAbWVsbGFub3guY29tPg0KPj4NCj4+IEkgd291bGQgc3Vn
Z2VzdCBhZGRpbmcgYSBGaXhlcyBsaW5lLCBidXQgbG9va2luZyBpbnRvIHRoZSBoaXN0b3J5IG9m
IHRoZQ0KPj4gdHlwbywgaXQgd2VudCB0aHJvdWdoIG1hbnkgcGF0Y2hlcyB0aGF0IG1vZGlmaWVk
IHRoaXMgbGluZSBidXQgcHJlc2VydmVkDQo+PiB0aGUgdHlwby4NCj4+IEFjdHVhbGx5LCBpdCBk
YXRlcyBiYWNrIHRvIHRoZSB2ZXJ5IGZpcnN0IGNvbW1pdCB0aGF0IGludHJvZHVjZXMgbWx4NA0K
Pj4gZHJpdmVyOg0KPj4NCj4+IFBhdGNoZXMgaGlzdG9yeToNCj4+IDJiM2RkZjI3ZjQ4YyBuZXQv
bWx4NF9jb3JlOiBSZXBsYWNlIFZGIHplcm8gbWFjIHdpdGggcmFuZG9tIG1hYyBpbiBtbHg0X2Nv
cmUNCj4+IGVmOTZmN2Q0NmFkOCBuZXQvbWx4NF9lbjogSGFuZGxlIHVuYXNzaWduZWQgVkYgTUFD
IGFkZHJlc3MgY29ycmVjdGx5DQo+PiA2YmJiNmQ5OWYzZDIgbmV0L21seDRfZW46IE9wdGltaXpl
IFJ4IGZhc3QgcGF0aCBmaWx0ZXIgY2hlY2tzDQo+PiA0NTNhNjA4Mjc3MzUgbWx4NF9lbjogR2l2
aW5nIGludGVyZmFjZSBuYW1lIGluIGRlYnVnIG1lc3NhZ2VzDQo+PiBjMjdhMDJjZDk0ZDYgbWx4
NF9lbjogQWRkIGRyaXZlciBmb3IgTWVsbGFub3ggQ29ubmVjdFggMTBHYkUgTklDDQo+Pg0KPj4g
SSdtIG5vdCBzdXJlIHdoYXQgdGhlICJGaXhlczoiIHBvbGljeSBpcyBpbiB0aGVzZSBjYXNlcy4N
Cj4gDQo+IEkgd291bGRuJ3QgbmVjZXNzYXJpbHkgcHV0IGEgRml4ZXMgdGFnIG9uIHRoaXMsIGJl
Y2F1c2UgZG9lcyBmaXhpbmcgdGhlDQo+IHNwZWxsaW5nIHJlYWxseSBjb3VudCBhcyBhIGJ1Z2Zp
eD8gIEl0J3MgYm9yZGVybGluZSB3aGV0aGVyIGl0J3MgYSBmaXgNCj4gb3IgYSBjbGVhbnVwLg0K
PiANCj4gcmVnYXJkcywNCj4gZGFhbiBjYXJwZW50ZXINCj4gDQoNClRoYW5rcyBEYW4sIEknbSBm
aW5lIHdpdGggdGhhdC4NCg==
