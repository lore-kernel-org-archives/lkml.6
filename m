Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210F6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87152184A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="R1wCPjK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfBRJh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:37:29 -0500
Received: from mail-eopbgr20061.outbound.protection.outlook.com ([40.107.2.61]:30464
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727228AbfBRJh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoxuuTMfDScX6OcNJ8c6EWY5nxRUDikjUmYYLICesQo=;
 b=R1wCPjK7ovueB+ePxLCO8AbU7hL2xm9HEeq4YC4anZ7hPpp732UlwDJWuYIw/c6dpgJd05LIm0SRwyebSxVe82sa0HkL33ZY4fqRZpw6swkekaZ6azRbpKkt77k1XE3FJBz1QcDE1LFSQCPLMDVRcUI3w0Dp9D3iFKlZ7QKQzg4=
Received: from HE1PR05MB3257.eurprd05.prod.outlook.com (10.170.243.19) by
 HE1PR05MB3339.eurprd05.prod.outlook.com (10.170.243.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 09:37:22 +0000
Received: from HE1PR05MB3257.eurprd05.prod.outlook.com
 ([fe80::550a:a35e:2062:792a]) by HE1PR05MB3257.eurprd05.prod.outlook.com
 ([fe80::550a:a35e:2062:792a%7]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 09:37:22 +0000
From:   Tariq Toukan <tariqt@mellanox.com>
To:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/mlx4_en: fix spelling mistake: "quiting" ->
 "quitting"
Thread-Topic: [PATCH] net/mlx4_en: fix spelling mistake: "quiting" ->
 "quitting"
Thread-Index: AQHUxxUCv2ce2u0HVkKjUo1mCtzjkqXlTOkA
Date:   Mon, 18 Feb 2019 09:37:22 +0000
Message-ID: <2a1a6636-7795-addb-d7b7-711a23dbafa5@mellanox.com>
References: <20190217230331.18678-1-colin.king@canonical.com>
In-Reply-To: <20190217230331.18678-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P194CA0019.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::29) To HE1PR05MB3257.eurprd05.prod.outlook.com
 (2603:10a6:7:35::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa850f3e-4c23-425a-f24e-08d69584aea9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3339;
x-ms-traffictypediagnostic: HE1PR05MB3339:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtIRTFQUjA1TUIzMzM5OzIzOjR3a2tEZnpKZDdaRDN1TVFUZHJpckVhdkwy?=
 =?utf-8?B?a0ttb2plVlJlcE0xV09QVnN0QXFZRlJZZjdha3J0SXhPM2IxODBSTDVUa3lJ?=
 =?utf-8?B?ank1MHZqdUZ1RHB6enBDcTlUSTk3TG55YS9DR1llNmtFUnZELzhsY2VIR2k5?=
 =?utf-8?B?M0lWT2dhWmhtaUtsbXNIOWpUdUhoNHkxOGdFTGVmVHB4enBGMHpJTi9oekUz?=
 =?utf-8?B?KzMwTVVBVTBzdjBORDBPZXRaOGV1V3kvZVdCWEk2R2VsWG1aYWNGKzUza1NC?=
 =?utf-8?B?ZkdueFQvTXlGTTYzSm9uZDd4dHVCQzBTbTU2T1lFNzFSZVpRaHh5SkxjMU9x?=
 =?utf-8?B?Z2RBZC9SV2RKK0RaN0xpcHJoUm5vaXJRaDUveFA1b053dGVyVzBsTENHWEw2?=
 =?utf-8?B?d2V0NWpQWjRteFdYYS96Q2lDaGlRTmlEWTZ6TnlKcy9CR09LUFBmYmlPMjlK?=
 =?utf-8?B?MEFWd25saUJJSi9sZ0RCNm1TeS9vVVBsSGg2N0RwcVJCd1Fhb0dqL3VDWnVT?=
 =?utf-8?B?ZmtqY3pINVpNRk1ycktVS2NvclEvMStzRXBIeW1MdEFWVlJqdmlvQkswTGoz?=
 =?utf-8?B?eXJ6NEJIczd0cmVkRnNkNDlhbjNkbmRWYmY5MGcyYmVhVVpkekhUWFhDNER4?=
 =?utf-8?B?V1kzK2RlL245em1CVW1Qa0o1M1dIV2pMTXVHUFRNQVVQTWJnOWg5Yi9JUXVB?=
 =?utf-8?B?VEU5bVdvODJKTTRTR09DRlNUV2JHcVhKSzBPMlZRdGRaSDBVYm9CdEZ3dTZS?=
 =?utf-8?B?RTR2MFNmR1NqRjlnRll1OEFDVnArMEhIcW1ZT29YOG94NS9MbW9iaXNyK2VQ?=
 =?utf-8?B?Q0NjMUsxbm1VSUxiS1czUFFDK1lORUZWUUxDTTVvV0hRSTNjMENreUhORXRK?=
 =?utf-8?B?Qm9oTWF3WnIrUnhrUThqMkk3MVNoRVA4OGhpajNVT3JjSzNMVk5WSTV2TmI3?=
 =?utf-8?B?V3hRc3BvTmxHWXJyZnhrSHpWQVhqVkR6N3IxeDY4WjQ2R3hrQmlCVEYxemFS?=
 =?utf-8?B?bC84VmVWRHc1eWdLOWZMZVRySis5MkthSlJONjhFRU00VmVoSzNPemM3anli?=
 =?utf-8?B?d1VuR2NxRUpXS1VLeG53QUJOUWpwY0VXYmF6bkRLY3IyWWhyd3lyUkEvMnVr?=
 =?utf-8?B?bVIxSlFYMy9rSE1hVUdxdDhwVmNjT1EvNy9COGVGQVlvTStvT3FaNTRTaWxQ?=
 =?utf-8?B?Lzk0cGNCRGkxRjZGM0pQR1hNNTZHUkdueFNOYk1hbnRBRmlhV1FWaGg3SDY2?=
 =?utf-8?B?Z3dwVFVjQjdqMDR4eGtpbGl2a2Rqc0s0NVFwYXFqSm1HUWpqODhtK0NINkZN?=
 =?utf-8?B?eFkvRmVYTTJoVXE0TEFlMFAxSWx0cWJNV0hyR3hJZHlJTzlnaEFiQThoRERH?=
 =?utf-8?B?VG4xUm9vdTMxakY5NEd3djZxNUQ2bWM0ZFU1QXNZLzBLMkFxTHNlMW50OXJP?=
 =?utf-8?B?QXNBYjI0WlZlbHBva3RIOHFXLzZqNmFQUTREYXVpemVSOW5HM0RkTmRES3NT?=
 =?utf-8?B?STdEMXlpMUlvL1VaT3k2MHg5S0hrN2toTlNtelRYSkhwZlJheXhrbTNMdEFP?=
 =?utf-8?B?QmdRM0lrYkpyczNWeUlmTmIvTmZmbTFvdURwYnUwNk9reUY2cnE1emFFOGdS?=
 =?utf-8?B?bUF3ZHgrQWRPTTl0WS9KZ2psK0cyTTkvakxIWXhnUWI5S1p3WnlkL1FJM0Zz?=
 =?utf-8?B?NW03bTUyQnFrcGVJc2Y3VDdLUlArZHc2S25pNVpEWThMdzh2dzJLKzd6MGEy?=
 =?utf-8?B?QUFzUFFJdFVzcmpkQmdZc1VYUWtqQ0pDRk5yWHN0NE1tdjZRckZjV2E1bWo3?=
 =?utf-8?Q?6CqnKzmMY/mpx?=
x-microsoft-antispam-prvs: <HE1PR05MB3339E230FD6DAD36C6394B7FAE630@HE1PR05MB3339.eurprd05.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(346002)(376002)(189003)(199004)(229853002)(26005)(81166006)(478600001)(2501003)(81156014)(53936002)(446003)(386003)(53546011)(6506007)(8936002)(186003)(8676002)(5660300002)(256004)(11346002)(3846002)(6116002)(14444005)(106356001)(105586002)(71190400001)(71200400001)(76176011)(2906002)(31686004)(2616005)(2201001)(110136005)(66066001)(97736004)(54906003)(4326008)(86362001)(476003)(25786009)(7736002)(6512007)(14454004)(6436002)(102836004)(6246003)(36756003)(31696002)(68736007)(316002)(99286004)(6486002)(486006)(52116002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3339;H:HE1PR05MB3257.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /PbTfk/nP0/EfFDBodaaeLP+lxxtqpIX9KEm0d7VB0NAjcrc3dRh8Q+c1A+3ZrtN5vpa/HNHybTUnoHeg1cSkHvVgL+YnAN4c7IcgujCzw0VGdvIjgXMbZFQdPTWIJeCQlPGKLP8CV0ETk7wiNd3XD6FZTau+arQ3duffRTneagPCNIqLVQ1ZpZ3/xXDodDqFFsaagPIMIw2B2gBGqXfZeWK2hHNk137FyqG07XljsFjyHfMvJRLEdNzc9JRgw5Hdz0BmwE0RdKS0JpKOGEUmfGV1xBBmew1S/HLEp5Y4I60IGBxk89WzhCF1BRzupudZTAVD0s7wUCdiXCElr51nwRaklLzcQqn6EX/2HiPiNSjjTTkyLfJH7Rz4cwKkQHCUUpv6yq4V7oNatmDfiLWT9+l26GFyINmaZWzlSlEMqo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4FE1209D8BCC54098698E1E7606FDA6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa850f3e-4c23-425a-f24e-08d69584aea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 09:37:20.9953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIvMTgvMjAxOSAxOjAzIEFNLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBGcm9tOiBDb2xp
biBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gVGhlcmUgaXMgYSBz
cGVsbGluZyBtaXN0YWtlIGluIGEgZW5fZXJyIGVycm9yIG1lc3NhZ2UuIEZpeCBpdC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDQvZW5fbmV0ZGV2
LmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4
NC9lbl9uZXRkZXYuYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDQvZW5fbmV0
ZGV2LmMNCj4gaW5kZXggNmI4ODg4MWI4ZTM1Li5jMTQzOGFlNTJhMTEgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDQvZW5fbmV0ZGV2LmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NC9lbl9uZXRkZXYuYw0KPiBAQCAtMzM2
MCw3ICszMzYwLDcgQEAgaW50IG1seDRfZW5faW5pdF9uZXRkZXYoc3RydWN0IG1seDRfZW5fZGV2
ICptZGV2LCBpbnQgcG9ydCwNCj4gICAJZGV2LT5hZGRyX2xlbiA9IEVUSF9BTEVOOw0KPiAgIAlt
bHg0X2VuX3U2NF90b19tYWMoZGV2LT5kZXZfYWRkciwgbWRldi0+ZGV2LT5jYXBzLmRlZl9tYWNb
cHJpdi0+cG9ydF0pOw0KPiAgIAlpZiAoIWlzX3ZhbGlkX2V0aGVyX2FkZHIoZGV2LT5kZXZfYWRk
cikpIHsNCj4gLQkJZW5fZXJyKHByaXYsICJQb3J0OiAlZCwgaW52YWxpZCBtYWMgYnVybmVkOiAl
cE0sIHF1aXRpbmdcbiIsDQo+ICsJCWVuX2Vycihwcml2LCAiUG9ydDogJWQsIGludmFsaWQgbWFj
IGJ1cm5lZDogJXBNLCBxdWl0dGluZ1xuIiwNCj4gICAJCSAgICAgICBwcml2LT5wb3J0LCBkZXYt
PmRldl9hZGRyKTsNCj4gICAJCWVyciA9IC1FSU5WQUw7DQo+ICAgCQlnb3RvIG91dDsNCj4gDQoN
CkhpIENvbGluLCB0aGFua3MgZm9yIHlvdXIgcGF0Y2guDQoNClJldmlld2VkLWJ5OiBUYXJpcSBU
b3VrYW4gPHRhcmlxdEBtZWxsYW5veC5jb20+DQoNCkkgd291bGQgc3VnZ2VzdCBhZGRpbmcgYSBG
aXhlcyBsaW5lLCBidXQgbG9va2luZyBpbnRvIHRoZSBoaXN0b3J5IG9mIHRoZSANCnR5cG8sIGl0
IHdlbnQgdGhyb3VnaCBtYW55IHBhdGNoZXMgdGhhdCBtb2RpZmllZCB0aGlzIGxpbmUgYnV0IHBy
ZXNlcnZlZCANCnRoZSB0eXBvLg0KQWN0dWFsbHksIGl0IGRhdGVzIGJhY2sgdG8gdGhlIHZlcnkg
Zmlyc3QgY29tbWl0IHRoYXQgaW50cm9kdWNlcyBtbHg0IA0KZHJpdmVyOg0KDQpQYXRjaGVzIGhp
c3Rvcnk6DQoyYjNkZGYyN2Y0OGMgbmV0L21seDRfY29yZTogUmVwbGFjZSBWRiB6ZXJvIG1hYyB3
aXRoIHJhbmRvbSBtYWMgaW4gbWx4NF9jb3JlDQplZjk2ZjdkNDZhZDggbmV0L21seDRfZW46IEhh
bmRsZSB1bmFzc2lnbmVkIFZGIE1BQyBhZGRyZXNzIGNvcnJlY3RseQ0KNmJiYjZkOTlmM2QyIG5l
dC9tbHg0X2VuOiBPcHRpbWl6ZSBSeCBmYXN0IHBhdGggZmlsdGVyIGNoZWNrcw0KNDUzYTYwODI3
NzM1IG1seDRfZW46IEdpdmluZyBpbnRlcmZhY2UgbmFtZSBpbiBkZWJ1ZyBtZXNzYWdlcw0KYzI3
YTAyY2Q5NGQ2IG1seDRfZW46IEFkZCBkcml2ZXIgZm9yIE1lbGxhbm94IENvbm5lY3RYIDEwR2JF
IE5JQw0KDQpJJ20gbm90IHN1cmUgd2hhdCB0aGUgIkZpeGVzOiIgcG9saWN5IGlzIGluIHRoZXNl
IGNhc2VzLg0KDQpUaGFua3MsDQpUYXJpcQ0K
