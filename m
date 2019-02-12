Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11952C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0762222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dKpDsK5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbfBLTiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:38:16 -0500
Received: from mail-eopbgr750057.outbound.protection.outlook.com ([40.107.75.57]:49504
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbfBLTiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbV3/MZBPS4UjhtIn1YI5kp7WYpgfueh6Y1FOxm5uYM=;
 b=dKpDsK5e27eQ1/vFUWw5lAZIHEwmQCScDGc1jw+URUGYk8e0Dhni/b25sAmwsNtteMVO9N1TkHXykAplNWfNJ3dc0b6hVqFSU6r7G0eOYYAPHhs7AGUBlh8yniircwjrV0gAWaZvNyYPesYcXv2JjYWXBw65/KQ4qbuTo2yOv9Q=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1466.namprd12.prod.outlook.com (10.172.38.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 19:38:12 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::2ca1:de3d:a1a8:de9a]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::2ca1:de3d:a1a8:de9a%4]) with mapi id 15.20.1622.016; Tue, 12 Feb 2019
 19:38:12 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Colin King <colin.king@canonical.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, "Zhu, Rex" <Rex.Zhu@amd.com>,
        "Quan, Evan" <Evan.Quan@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: fix several indentation issues
Thread-Topic: [PATCH] drm/amdgpu: fix several indentation issues
Thread-Index: AQHUwtv6PSpAUTtFNkSsiSYHqft6pKXcjzkA
Date:   Tue, 12 Feb 2019 19:38:12 +0000
Message-ID: <4322b978-ad1d-e8c6-3942-289cfb1f30a7@amd.com>
References: <20190212140508.9296-1-colin.king@canonical.com>
In-Reply-To: <20190212140508.9296-1-colin.king@canonical.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6P194CA0050.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::27) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5370e71b-7b9a-469b-f152-08d691219fa2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1466;
x-ms-traffictypediagnostic: DM5PR12MB1466:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1466;20:YDmgphkfxIRrPNwih+5Xjvcz3uQCgIELbOZu6NR8wFgjUJ5cfQUk5FqbOf9/wDqfaeJmnxlI/aZRKE4YB0KmU2yPUN9U+NOZqCfltL3+4KU9N/tPQzFx7S3eb1v9N81ra8UInRwjf5MR/WkCxT7VkTqDoZofGoEpPg4szuqSaL71AXTNsw81C1bShtLwosu+PtmxCqFhunr59X5QSLc2OGjb4EkhaKkSFfIzNt8TFngoItENEYzrAxYcOtSpDQgh
x-microsoft-antispam-prvs: <DM5PR12MB14665047E31D4266DC106D3783650@DM5PR12MB1466.namprd12.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(305945005)(6512007)(6436002)(229853002)(6486002)(7736002)(2501003)(71200400001)(46003)(256004)(31686004)(64126003)(76176011)(65956001)(65806001)(102836004)(52116002)(8676002)(99286004)(386003)(81166006)(81156014)(6506007)(186003)(4326008)(25786009)(31696002)(2201001)(476003)(72206003)(86362001)(2616005)(8936002)(446003)(110136005)(105586002)(58126008)(6246003)(97736004)(2906002)(316002)(486006)(65826007)(36756003)(53936002)(6116002)(14454004)(68736007)(478600001)(71190400001)(11346002)(54906003)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1466;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rvNy3qXVdV0n+oYIeoEtU83GagJisrOgeQO3QFF4a7iJ7QvaO5kQmgM1vB6RLy2xnxVT3YfV2EZgsZxnAn9U4DnUygQMsq2RuWrr4KA017imWxBGaMsNTHZOe1sEQe8t6BvNahXTseDpwk1RiiTa/Q2ArnEz2bUMsVeLU9r2L/LyKH20uiknIrz1+Xfa43ClDA9spwT6Of/bJoT/eYjaC7lQT/qbcyUZrSUrKPQUhWLmpZiVkzPQ+yK116LsiuVTmrTeV7nW1Uo+P42ANQr7aE3Z5WPl7tKdorarOSJ2HZKM9f7SlL4h2QMu2UMcTfmETl7t0U6GW7f5DAUdZAejFAeekonO1a6gH8lDvAkIThwgJw1C0vDr9CPUM2/0YyKVKt13r970Adtqkqh7hgASRvaSpLnxoubkIlRV+S38Xmg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E585D55A1C0A94D93863678B546B7F4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5370e71b-7b9a-469b-f152-08d691219fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 19:38:09.8372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTIuMDIuMTkgdW0gMTU6MDUgc2NocmllYiBDb2xpbiBLaW5nOg0KPiBGcm9tOiBDb2xpbiBJ
YW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPg0KPiBUaGVyZSBhcmUgc2V2ZXJh
bCBzdGF0ZW1lbnRzIHRoYXQgYXJlIGluY29ycmVjdGx5IGluZGVudGVkLiBGaXggdGhlc2UuDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5j
b20+DQoNClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2tt
cy5jICAgICAgICAgICAgICB8IDIgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9k
Y2VfdjZfMC5jICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L25iaW9fdjdfNC5jICAgICAgICAgICAgICAgfCAyICstDQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2kuYyAgICAgICAgICAgICAgICAgICAgICB8IDIgKy0NCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X3Bvd2VydHVuZS5jIHwgMiArLQ0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21nci5jICAg
fCAyICstDQo+ICAgNiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
a21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMNCj4gaW5kZXgg
YmM2MmJmNDFiN2U5Li5iNjVlMTgxMDExMDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfa21zLmMNCj4gQEAgLTIwNyw3ICsyMDcsNyBAQCBpbnQgYW1kZ3B1X2RyaXZl
cl9sb2FkX2ttcyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB1bnNpZ25lZCBsb25nIGZsYWdzKQ0K
PiAgIAlpZiAoIXIpIHsNCj4gICAJCWFjcGlfc3RhdHVzID0gYW1kZ3B1X2FjcGlfaW5pdChhZGV2
KTsNCj4gICAJCWlmIChhY3BpX3N0YXR1cykNCj4gLQkJZGV2X2RiZygmZGV2LT5wZGV2LT5kZXYs
DQo+ICsJCQlkZXZfZGJnKCZkZXYtPnBkZXYtPmRldiwNCj4gICAJCQkJIkVycm9yIGR1cmluZyBB
Q1BJIG1ldGhvZHMgY2FsbFxuIik7DQo+ICAgCX0NCj4gICANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92Nl8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9kY2VfdjZfMC5jDQo+IGluZGV4IGRiNDQzZWM1M2QzYS4uYmVhMzJmMDc2YjkxIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92Nl8wLmMNCj4gQEAgLTI5ODAsNyArMjk4
MCw3IEBAIHN0YXRpYyBpbnQgZGNlX3Y2XzBfcGFnZWZsaXBfaXJxKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LA0KPiAgIAkJCQkgc3RydWN0IGFtZGdwdV9pcnFfc3JjICpzb3VyY2UsDQo+ICAg
CQkJCSBzdHJ1Y3QgYW1kZ3B1X2l2X2VudHJ5ICplbnRyeSkNCj4gICB7DQo+IC0JCXVuc2lnbmVk
IGxvbmcgZmxhZ3M7DQo+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gICAJdW5zaWduZWQgY3J0
Y19pZDsNCj4gICAJc3RydWN0IGFtZGdwdV9jcnRjICphbWRncHVfY3J0YzsNCj4gICAJc3RydWN0
IGFtZGdwdV9mbGlwX3dvcmsgKndvcmtzOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbmJpb192N180LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlv
X3Y3XzQuYw0KPiBpbmRleCAyMjFmMjZlNTAzMjIuLmM2OWQ1MTU5OGNmZSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmJpb192N180LmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbmJpb192N180LmMNCj4gQEAgLTMyLDcgKzMyLDcgQEANCj4g
ICANCj4gICBzdGF0aWMgdTMyIG5iaW9fdjdfNF9nZXRfcmV2X2lkKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQ0KPiAgIHsNCj4gLSAgICB1MzIgdG1wID0gUlJFRzMyX1NPQzE1KE5CSU8sIDAs
IG1tUkNDX0RFVjBfRVBGMF9TVFJBUDApOw0KPiArCXUzMiB0bXAgPSBSUkVHMzJfU09DMTUoTkJJ
TywgMCwgbW1SQ0NfREVWMF9FUEYwX1NUUkFQMCk7DQo+ICAgDQo+ICAgCXRtcCAmPSBSQ0NfREVW
MF9FUEYwX1NUUkFQMF9fU1RSQVBfQVRJX1JFVl9JRF9ERVYwX0YwX01BU0s7DQo+ICAgCXRtcCA+
Pj0gUkNDX0RFVjBfRVBGMF9TVFJBUDBfX1NUUkFQX0FUSV9SRVZfSURfREVWMF9GMF9fU0hJRlQ7
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2kuYw0KPiBpbmRleCA3OWMxYTliYmNjMjEuLjlkOGRmNjg4
OTNiOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2kuYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaS5jDQo+IEBAIC0xNDM2LDcgKzE0MzYs
NyBAQCBzdGF0aWMgaW50IHNpX2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkNCj4gICAJ
CQlBTURfQ0dfU1VQUE9SVF9VVkRfTUdDRyB8DQo+ICAgCQkJQU1EX0NHX1NVUFBPUlRfSERQX0xT
IHwNCj4gICAJCQlBTURfQ0dfU1VQUE9SVF9IRFBfTUdDRzsNCj4gLQkJCWFkZXYtPnBnX2ZsYWdz
ID0gMDsNCj4gKwkJYWRldi0+cGdfZmxhZ3MgPSAwOw0KPiAgIAkJYWRldi0+ZXh0ZXJuYWxfcmV2
X2lkID0gKGFkZXYtPnJldl9pZCA9PSAwKSA/IDEgOg0KPiAgIAkJCQkJKGFkZXYtPnJldl9pZCA9
PSAxKSA/IDUgOiA2Ow0KPiAgIAkJYnJlYWs7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X3Bvd2VydHVuZS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19wb3dlcnR1bmUuYw0KPiBpbmRleCBkMTM4ZGRhZTU2
M2QuLjU4ZjU1ODlhYWYxMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvaHdtZ3Ivc211N19wb3dlcnR1bmUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9od21nci9zbXU3X3Bvd2VydHVuZS5jDQo+IEBAIC0xMjExLDcgKzEyMTEsNyBA
QCBpbnQgc211N19wb3dlcl9jb250cm9sX3NldF9sZXZlbChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdy
KQ0KPiAgIAkJCQlod21nci0+cGxhdGZvcm1fZGVzY3JpcHRvci5URFBBZGp1c3RtZW50IDoNCj4g
ICAJCQkJKC0xICogaHdtZ3ItPnBsYXRmb3JtX2Rlc2NyaXB0b3IuVERQQWRqdXN0bWVudCk7DQo+
ICAgDQo+IC0JCSBpZiAoaHdtZ3ItPmNoaXBfaWQgPiBDSElQX1RPTkdBKQ0KPiArCQlpZiAoaHdt
Z3ItPmNoaXBfaWQgPiBDSElQX1RPTkdBKQ0KPiAgIAkJCXRhcmdldF90ZHAgPSAoKDEwMCArIGFk
anVzdF9wZXJjZW50KSAqIChpbnQpKGNhY190YWJsZS0+dXNURFAgKiAyNTYpKSAvIDEwMDsNCj4g
ICAJCWVsc2UNCj4gICAJCQl0YXJnZXRfdGRwID0gKCgxMDAgKyBhZGp1c3RfcGVyY2VudCkgKiAo
aW50KShjYWNfdGFibGUtPnVzQ29uZmlndXJhYmxlVERQICogMjU2KSkgLyAxMDA7DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMjBfaHdtZ3Iu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21nci5jDQo+
IGluZGV4IDA3NjliMWVjNTYyYi4uYWFkNzlhZmZiMDgxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMjBfaHdtZ3IuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMjBfaHdtZ3IuYw0KPiBAQCAtMzQ1
Niw3ICszNDU2LDcgQEAgc3RhdGljIGludCB2ZWdhMjBfYXBwbHlfY2xvY2tzX2FkanVzdF9ydWxl
cyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQ0KPiAgIAlkaXNhYmxlX21jbGtfc3dpdGNoaW5nID0g
KCgxIDwgaHdtZ3ItPmRpc3BsYXlfY29uZmlnLT5udW1fZGlzcGxheSkgJiYNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAhaHdtZ3ItPmRpc3BsYXlfY29uZmlnLT5tdWx0aV9tb25pdG9y
X2luX3N5bmMpIHx8DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZibGFua190b29f
c2hvcnQ7DQo+IC0gICAgbGF0ZW5jeSA9IGh3bWdyLT5kaXNwbGF5X2NvbmZpZy0+ZGNlX3RvbGVy
YWJsZV9tY2xrX2luX2FjdGl2ZV9sYXRlbmN5Ow0KPiArCWxhdGVuY3kgPSBod21nci0+ZGlzcGxh
eV9jb25maWctPmRjZV90b2xlcmFibGVfbWNsa19pbl9hY3RpdmVfbGF0ZW5jeTsNCj4gICANCj4g
ICAJLyogZ2Z4Y2xrICovDQo+ICAgCWRwbV90YWJsZSA9ICYoZGF0YS0+ZHBtX3RhYmxlLmdmeF90
YWJsZSk7DQoNCg==
