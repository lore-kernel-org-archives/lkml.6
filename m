Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23073C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D407A20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="gGIGMD7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D407A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeLJMuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:50:35 -0500
Received: from mail-eopbgr790079.outbound.protection.outlook.com ([40.107.79.79]:2913
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbeLJMue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9pjdHicDxs+nthW91cuK94ZqL9FuP3wEUQ/HXwKtLc=;
 b=gGIGMD7gSoVDObWBD02K/fMa72bMrPQSdtVt1D+l2obsYGq6sBuW7djLtGFXrmEzdPbqwvdc8oU09K6oRQyLRPll1UId9Kf+keWK7a2g2uGZMaUpiuCV5gPAOMWUd/vlEy3ykAVyfPvSvqH/zgULgd92e1w+GAlATbFvDg6kkkA=
Received: from BYAPR05MB5592.namprd05.prod.outlook.com (20.177.186.153) by
 BYAPR05MB4566.namprd05.prod.outlook.com (52.135.204.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.11; Mon, 10 Dec 2018 12:50:30 +0000
Received: from BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::fdd0:e9d4:4502:5cf7]) by BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::fdd0:e9d4:4502:5cf7%5]) with mapi id 15.20.1425.016; Mon, 10 Dec 2018
 12:50:30 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        Deepak Singh Rawat <drawat@vmware.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "airlied@linux.ie" <airlied@linux.ie>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH][drm-next] drm/selftest: fix spelling mistake "dimention"
 -> "dimenstion"
Thread-Topic: [PATCH][drm-next] drm/selftest: fix spelling mistake "dimention"
 -> "dimenstion"
Thread-Index: AQHUkGpqiLhij7n4uUG68Ma9b3r7aKV37QaA
Date:   Mon, 10 Dec 2018 12:50:29 +0000
Message-ID: <1a41c8390de02ae0e7ca97fb3af033ee522e62fa.camel@vmware.com>
References: <20181210092619.4016-1-colin.king@canonical.com>
In-Reply-To: <20181210092619.4016-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4566;20:HgfF1oPLvSxVfrGCoHXGVEDupksMC7BYZ5O5eDCfzWfD5eNBhybDbv81nzaiKvHZy9J8j5RNxH8IuihBXxEfCWqEYe1SkLuyPc7WvyMzFntPaixSVMJnjzBDjIdFP4+UblPrQ9vQIUknGGOiVgS9YYLPY/Yu/KebvoAKd50UO4A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c50f5689-8181-44fa-03e5-08d65e9e111b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4566;
x-ms-traffictypediagnostic: BYAPR05MB4566:
x-microsoft-antispam-prvs: <BYAPR05MB45669796FB6D439E797A8C4CA1A50@BYAPR05MB4566.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4566;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4566;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(4001150100001)(7736002)(6436002)(97736004)(5660300001)(186003)(3846002)(6116002)(2501003)(305945005)(6486002)(25786009)(76176011)(478600001)(2616005)(476003)(486006)(106356001)(99286004)(105586002)(2906002)(26005)(229853002)(14454004)(6506007)(68736007)(316002)(118296001)(446003)(102836004)(54906003)(110136005)(71200400001)(11346002)(71190400001)(86362001)(2201001)(53936002)(8676002)(81166006)(81156014)(8936002)(36756003)(66066001)(6512007)(4326008)(6246003)(256004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4566;H:BYAPR05MB5592.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Mo2X4d7xBu6HT+T7Eyl0HMbZ22IIJuQf2Qqzsfg7j7D4SNW5YX/EJK1THUwFXV3z0r5hvaG9y4Z/0lzz62R4Je0WQmb4m3f9ynC2nXGvc1y2ztoJbHMK4UAbY7ahY1qYKYSp9RWtnRxD4nXBJwPn6M4cUuKkmS5wupugccs0iSveHpJ4DwAAk2LFM0jUGhUClcAGbXGKrgHIYA/aIR2+9apF7vRcDLYdcGZMVjGES+xhjZIAGdEsHJZq1YfIyQ1rvuAdvAHuSLBbwGAr0EWnkPPqeD8Xy9JzhDZSUK6FcyXGXo9mHTxZmD7NbNxGri7+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E7BBD3E17DDC244A6AA271DE559C441@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50f5689-8181-44fa-03e5-08d65e9e111b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 12:50:29.9837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTEyLTEwIGF0IDA5OjI2ICswMDAwLCBDb2xpbiBLaW5nIHdyb3RlOg0KDQpS
ZXZpZXdlZC1ieTogVGhvbWFzIEhlbGxzdHJvbSA8dGhlbGxzdHJvbUB2bXdhcmUuY29tPg0KDQpJ
J2xsIHRha2UgdGhpcyBpbiB0aGUgbmV4dCBwdWxsIHJlcXVlc3QgdW5sZXNzIEknbSB0b2xkIG90
aGVyd2lzZS4NCg0KL1Rob21hcw0KDQo+IEZyb206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5n
QGNhbm9uaWNhbC5jb20+DQo+IA0KPiBUaGVyZSBpcyBhIHNwZWxsaW5nIG1pc3Rha2UgaW4gYSBw
cl9lcnIgbWVzc2FnZSwgZml4IHRoaXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4g
S2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9zZWxmdGVzdHMvdGVzdC1kcm1fZGFtYWdlX2hlbHBlci5jIHwgMiArLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3NlbGZ0ZXN0cy90ZXN0LWRybV9kYW1hZ2VfaGVscGVyLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vc2VsZnRlc3RzL3Rlc3QtZHJtX2RhbWFnZV9oZWxwZXIuYw0KPiBpbmRl
eCBhMmY3NTMyMDVhM2UuLjlkMmJjZGY4YmMyOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL3NlbGZ0ZXN0cy90ZXN0LWRybV9kYW1hZ2VfaGVscGVyLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL3NlbGZ0ZXN0cy90ZXN0LWRybV9kYW1hZ2VfaGVscGVyLmMNCj4gQEAgLTUzLDcgKzUz
LDcgQEAgc3RhdGljIGJvb2wgY2hlY2tfZGFtYWdlX2NsaXAoc3RydWN0DQo+IGRybV9wbGFuZV9z
dGF0ZSAqc3RhdGUsIHN0cnVjdCBkcm1fcmVjdCAqciwNCj4gIAlpbnQgc3JjX3kyID0gKHN0YXRl
LT5zcmMueTIgPj4gMTYpICsgISEoc3RhdGUtPnNyYy55MiAmDQo+IDB4RkZGRik7DQo+ICANCj4g
IAlpZiAoeDEgPj0geDIgfHwgeTEgPj0geTIpIHsNCj4gLQkJcHJfZXJyKCJDYW5ub3QgaGF2ZSBk
YW1hZ2UgY2xpcCB3aXRoIG5vIGRpbWVudGlvbi5cbiIpOw0KPiArCQlwcl9lcnIoIkNhbm5vdCBo
YXZlIGRhbWFnZSBjbGlwIHdpdGggbm8gZGltZW5zaW9uLlxuIik7DQo+ICAJCXJldHVybiBmYWxz
ZTsNCj4gIAl9DQo+ICANCg==
