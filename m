Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9BAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2234F20855
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="YYACa7aE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfBSIUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:20:55 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:1040
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfBSIUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEPfD8eHqq+KZTc8gJyOF91eUa2qvk7U3Bh5mJ8vpEw=;
 b=YYACa7aEMpLL91Q46QyOHYDwljQLXLQ64ZLDmKrGQ8DidZ2kyKNSSJOoiR6hAaf6VtVj3Wi3Xv1P+c634uYr8biEKk1CNY+z7O2JgXLkjll+nC/1cBq+Jd126YlVewY3/Y0SO32m0XAvCbsIdOxgddaN6PV+Kpm6wN5QWl7+Ivc=
Received: from HE1PR05MB3257.eurprd05.prod.outlook.com (10.170.243.19) by
 HE1PR05MB3402.eurprd05.prod.outlook.com (10.170.244.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 19 Feb 2019 08:20:48 +0000
Received: from HE1PR05MB3257.eurprd05.prod.outlook.com
 ([fe80::550a:a35e:2062:792a]) by HE1PR05MB3257.eurprd05.prod.outlook.com
 ([fe80::550a:a35e:2062:792a%7]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 08:20:48 +0000
From:   Tariq Toukan <tariqt@mellanox.com>
To:     David Miller <davem@davemloft.net>,
        "colin.king@canonical.com" <colin.king@canonical.com>
CC:     Tariq Toukan <tariqt@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/mlx4_en: fix spelling mistake: "quiting" ->
 "quitting"
Thread-Topic: [PATCH] net/mlx4_en: fix spelling mistake: "quiting" ->
 "quitting"
Thread-Index: AQHUxxUCv2ce2u0HVkKjUo1mCtzjkqXl/UsAgADMjwA=
Date:   Tue, 19 Feb 2019 08:20:48 +0000
Message-ID: <58d80104-da39-7845-f8cb-3d3c7483d893@mellanox.com>
References: <20190217230331.18678-1-colin.king@canonical.com>
 <20190218.120836.1419708231583986821.davem@davemloft.net>
In-Reply-To: <20190218.120836.1419708231583986821.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0017.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::30) To HE1PR05MB3257.eurprd05.prod.outlook.com
 (2603:10a6:7:35::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cc6db4b-75e9-4edc-991d-08d696432720
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3402;
x-ms-traffictypediagnostic: HE1PR05MB3402:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtIRTFQUjA1TUIzNDAyOzIzOmczQStmRHFrZGJWWUJFVy9rb3poU1JwTWlQ?=
 =?utf-8?B?UkNJSjlQbUE5V1A5OWQ5U1NETWlKMEEwakZ4Uk9jV1hsVW5RZUxpRkN3MU42?=
 =?utf-8?B?eVEveFhaa1Yrc1lERmozZVJLMUpETVVjbGMwWTQ3WTVDclNleWJOaWF4WE5r?=
 =?utf-8?B?NHJ4RHk5V3NUeFJyeVNqUHJ1U0pVV2xDSGlwV2RISmpLSFNYaDJDWkpFSnBp?=
 =?utf-8?B?UklTeHRIVVM3Sy9YWHpyay9wM0RudzFyMm85YkJNSk82Z3dZRkhVYnc5QVNT?=
 =?utf-8?B?dzFIcUFCamsyMDV0UkV3Yk1rL1JnVVJLbnFvbEdhdVNQZnBMampybTNQVlhG?=
 =?utf-8?B?RExBKyt5WTZOWms5R2FkTWVjMjNZR0FTQ3ZmRU9vNDg2cHVLWTI2bk1UQXhH?=
 =?utf-8?B?dlR1S3pXWm5NQkF2aFIxZXliS3JiTFpKYjRSNXF5cXltZEkxMU5vZlpKaDVK?=
 =?utf-8?B?bkhpUGJkRDlSUkN2OEdaT1krWUJtT0NoT21oUDJZTE1OU3ZTK0YxRk5oYzdX?=
 =?utf-8?B?dTNxSmlrcnozRDV2ODRrb0FQQjhHK0Q5NUoxQTZyMHBFVy9na1J0cUFTaURI?=
 =?utf-8?B?WmZvVUxBcUZCcEVCMUZiQmp3WkZvQjRHYUNmQzR4bHc1NWJQeTBlQ2NFNzNj?=
 =?utf-8?B?RU9wMWY0YjR2aHR5L3h3TlBFRExyMnI4TnUwN1NUdCtkS3dOR0kxVSs5WVJq?=
 =?utf-8?B?dG51ZHNzSTdCOE95bjY2bkN3aEFnbGRMQXV3dCs1clVkVldDK0FSQnVUNWtJ?=
 =?utf-8?B?YVpBaTlLeFN5WVJaZ2RwMUZ2MHBZd2M5azBESWJRVWk5dklmU2h2R3ozeE0x?=
 =?utf-8?B?Um9FcGhLeVdDank3eWZJa2l0WXBOUWFQZHpqNFpmbk41RWVuWUk5YmhHMjlP?=
 =?utf-8?B?VldFTWVSWmUrQ2JFd290QzExWE1Qb0VJWFEyVGJJdDlnL3F1aU94dm5JYlFw?=
 =?utf-8?B?SkhVUnFPZ1d2NkplanNKWTZQaUhJU1BqOU1mMmdzcnVsOHNiYUV5NUlYU2Er?=
 =?utf-8?B?d3Jla2hmN295eU5BTnNWQ0JsL3phN2dETitFQk93ekd2Snl5VzVXZmVHb09K?=
 =?utf-8?B?c1k4cncvSFJHMlRwbVdOczFZNXZ3dkVjcGUwYUNjTG93Q2YxT2dhdnRwNHRO?=
 =?utf-8?B?RXMzOWx5Q2YvaitxZnUxVzN5NWNJZUh6QmkzUzVUSDZVQm85SW9JbWd0cm9m?=
 =?utf-8?B?Wk01b3lXRnFBTTZXS3UxcDF6NjBjOTNOSUx5STJBb3Q1NndBcFc0UmhFSlpz?=
 =?utf-8?B?RXM4ZHd6YjRzVy9Nb2Yrektzei85dWNPcGhESGQ1QXdubTJyb3ZjZDUzQTBq?=
 =?utf-8?B?a3pxdlRCcjV1UUVBM0N3cGtJU0pySTFpSnZ5aUFkMnFKbWN6QTQzZVliSlR6?=
 =?utf-8?B?bm84Ulh6Z3FkcXpLQXVlcVNBRkVrU1FzdS9HUVBTYXhPMHc2eU1KT1lGTUpF?=
 =?utf-8?B?alUzRnJERjNnZll4bUZnK0lFN25WcXQzN09QTTdES2thVFo2ajFjK3JXV2sw?=
 =?utf-8?B?QUJvRmZPR21lWWMrTEgzREZ4cXp0azhVa09JMzdKZU5jSEo2WjZlMUtoV1R6?=
 =?utf-8?B?alN1MmRucU45aEpnTm9OTzNodGhoeVBhdG10aU5ETE81eXpib0ZsYjUvM2VL?=
 =?utf-8?B?emVVSThhZUh6M0pqMDhDdDBqbDd2NU9yclArQnUxTk9nZ3Fleit5QmFiZjVZ?=
 =?utf-8?B?dGtUaEgrVDNhSXcycGFsSldUUTJPQWQ2WnhKRk9IeWFKWnA3d0ZINk9ZcWNV?=
 =?utf-8?B?cjY2QXE1VnV4QlBQS3RackQwcXAzdmVKWnNMeWV6N2NIWUdCb0RBdFFzZEVP?=
 =?utf-8?Q?rra/usj6U7L0m?=
x-microsoft-antispam-prvs: <HE1PR05MB3402A787093B22BA58EAA26DAE7C0@HE1PR05MB3402.eurprd05.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(396003)(39860400002)(51914003)(199004)(189003)(36756003)(6116002)(3846002)(2906002)(71200400001)(71190400001)(86362001)(256004)(11346002)(4326008)(66066001)(31696002)(5660300002)(53936002)(6246003)(4744005)(486006)(476003)(2616005)(446003)(106356001)(25786009)(105586002)(186003)(31686004)(26005)(102836004)(68736007)(53546011)(386003)(6506007)(8676002)(52116002)(478600001)(6512007)(81156014)(99286004)(81166006)(76176011)(316002)(6486002)(305945005)(7736002)(97736004)(110136005)(54906003)(6436002)(2501003)(14454004)(229853002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3402;H:HE1PR05MB3257.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cl8gRq9tq9s8eMirRF/GQEMwXBdMnmHt7VmBSxurtrA7Oz7M3zBXfMfhncswn5O42Ku86M5Tq2YlfiETlfmqQ/nb+MpD1B0TO7/xO84agMVPaa3PcpTM8q0fJqNSYbK0asczzWVIp5IIRdwjpsOV/QBfyn1HXOVRJtKHEbe5IYWOYyf2IWWVxXsZcW3WZglcjRTy6enjxVvEuli5qeOgGl1hOW8AcPk2xzUSI+9hV6wrX8Lp3ZbTvuU5EX85atUJ2jgf1r+9vRbsyegoYabbx5PIdbQpipy252+W2funbFOOGLoIa1TZsEpzF+I0tOrmhxifb9x7TVupY1mwREMGWGlyrodI35ujZ3UnRd3SvXfuXiIj1B9fhpG4/15bClVDqFQNvOk0pMJQ3wQcNryAO45th7Qd1E4q86Lhif23tFU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <408D09F0E782AC4DBAB7097AE77F243E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc6db4b-75e9-4edc-991d-08d696432720
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 08:20:47.4000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3402
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIvMTgvMjAxOSAxMDowOCBQTSwgRGF2aWQgTWlsbGVyIHdyb3RlOg0KPiBGcm9tOiBD
b2xpbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IERhdGU6IFN1biwgMTcgRmVi
IDIwMTkgMjM6MDM6MzEgKzAwMDANCj4gDQo+PiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4u
a2luZ0BjYW5vbmljYWwuY29tPg0KPj4NCj4+IFRoZXJlIGlzIGEgc3BlbGxpbmcgbWlzdGFrZSBp
biBhIGVuX2VyciBlcnJvciBtZXNzYWdlLiBGaXggaXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
Q29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gDQo+IEFwcGxpZWQs
IHRoYW5rcyBDb2xpbi4NCj4gDQo+IEFuZCBJIGFncmVlIHRoYXQgdGhpcyBkb2Vzbid0IHJlYWxs
eSBkZXNlcnZlIGEgRml4ZXM6IHRhZy4NCj4gDQo+IEZpeGVzOiB0YWdzIHNob3VsZCByZWFsbHkg
YmUgZm9yIGNoYW5nZXMgdGhhdCBpbnRyb2R1Y2UgdHJ1bHkNCj4gZnVuY3Rpb25hbCBidWdzLg0K
PiANCj4gQW5kIHRoYXQgY291bGQgZXZlbiBiZSBhcHBsaWVkIGluIHRoaXMgY2FzZSBfaWZmXyB0
aGUgc3RyaW5nDQo+IHdhcyBlc3NlbnRpYWwgaW4gc29tZSB3YXkgZm9yIHVzZXJsYW5kIHRvb2xz
IHdoaWNoIHBhcnNlIHRoZQ0KPiBvdXRwdXQgb3Igc2ltaWxhci4gIEJ1dCB0aGF0IGlzIG5vdCB0
aGUgY2FzZSBoZXJlLg0KPiANCg0KVGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4NCg0KPiBB
bnl3YXlzLCB0aGFua3MuDQo+IA0K
