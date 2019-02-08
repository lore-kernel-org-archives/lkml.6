Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCA4C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665C920855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="cDviAj0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfBHQ7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:59:49 -0500
Received: from mail-eopbgr820114.outbound.protection.outlook.com ([40.107.82.114]:6377
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbfBHQ7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-os-amperecomputing-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+vfOKU4Md8jp0468dSnPtxMqDexUt/6o+EQDcp+AVg=;
 b=cDviAj0P5I8+Xh0Dg//oiZeTSrkk9jhCMAgFln8meUcn9EhrGSde6LRxECHXTWfJphhzPrVAAmu0nLOA7QZHqe7dCpukYJ1j8Vfq+m3nF7LnnRp7JomlwDxpshMbitAija4PmukSMMC3CRsRjacFzM3LvXvlqSiujZrDsg0o1Ik=
Received: from DM6PR01MB4090.prod.exchangelabs.com (20.176.104.151) by
 DM6PR01MB4905.prod.exchangelabs.com (20.176.119.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 16:59:45 +0000
Received: from DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::897b:6b25:5517:6444]) by DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::897b:6b25:5517:6444%3]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 16:59:45 +0000
From:   z-Hoan Tran - OS <hoan@os.amperecomputing.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
CC:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: drop Hoan Tran, e-mail is bouncing
Thread-Topic: [PATCH] MAINTAINERS: drop Hoan Tran, e-mail is bouncing
Thread-Index: AQHUv7tm1sOjz5NP8UmkDnpn0f8qQ6XWH+iA
Date:   Fri, 8 Feb 2019 16:59:45 +0000
Message-ID: <d0d4a6cb-a899-803e-23c7-6ed6a7609072@os.amperecomputing.com>
References: <20190208115411.7675-1-thomas.petazzoni@bootlin.com>
 <CACRpkdbd8zEXVW_R-Qui89ot4JAGJB1HXZm65OWsbf=zfVn7bg@mail.gmail.com>
In-Reply-To: <CACRpkdbd8zEXVW_R-Qui89ot4JAGJB1HXZm65OWsbf=zfVn7bg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:903:129::12) To DM6PR01MB4090.prod.exchangelabs.com
 (2603:10b6:5:2a::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hoan@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.28.13.142]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR01MB4905;6:DYMd/pejV/BHbv7fK9xpvYzdfwdTgT8ww7ZdhbP07OaUWg1NN5M3kagbOhWYMcpCB3m2utlqP6m3SHvaFytFrKn6o96lBN7mTqqfangPHpByAjJJ82B5BFBhC4LdC7lRG9bdeCJGtjTcWeVNfYu/Yj6r5bjVEumk8801oG61LUsyRbeD4Sc7sDklfrhfs+O8SdfDKlKt6JZqcM7hZyxa64p2HQgzq/QLy44PuGcUOl1gyeZh4+hRNPuYR7NKI1KGlpi2EDPhWWfq7zA1qxge0cVP5hCWN3UgWcKQ9l9+RnEByKivBKBC00P0J1bF5BBbfr8JZ7kRbBRuBDPv1GdPsZKhkp74PEDS8ThH2wnHYUNl+3C/cDTpnEqhM3UVLYRPSqxGhfAkTjgshv00OhGAcRF8uci9ep8fUCRmlrmi+MVzpIpRrImLzaC1J4igNtvfFE+I9PYWpKgy97LVL+b3ug==;5:kzM2G5p4Bc66isH1D01dVeDVqoD6zMbvnQw+5DGck1nLf1ioFd3lStdZSb/uMTDnJ7RQcWjptVsC3RRRS7+3pn+HQn07KnwZwt5YqaEBhBHxI/orqfElE4fd9LcxAgb8htIJ31DF40NuVAkwVOxgSXxYOCGLywRPVCXGteBx7eDCj/qfqTdNyIAMXbhfG3/9uG1hOi+PEThnfVfuq0msUQ==;7:8nPMv7EYCpK6YG2cfdm5F+uBitXODkQUOgk6BO62alem/Xw38BanqBAVYRvvh7AFD8VJH2bBofb+1zLh2S+5aPuYgCOz0hBWzaMviy5X+ezJkjD+vlo7JjwLeHnTGfZejAi4bc4/KYL4cXIkoKrl1Q==
x-ms-office365-filtering-correlation-id: b7843a37-23a3-4f45-5f6b-08d68de6d3a5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:DM6PR01MB4905;
x-ms-traffictypediagnostic: DM6PR01MB4905:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR01MB490567D70AE63245F70CBE7EF1690@DM6PR01MB4905.prod.exchangelabs.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39840400004)(189003)(199004)(81156014)(305945005)(316002)(256004)(14444005)(6436002)(105586002)(8936002)(25786009)(53936002)(6306002)(8676002)(81166006)(229853002)(54906003)(7736002)(966005)(52116002)(99286004)(14454004)(110136005)(6246003)(6512007)(71200400001)(71190400001)(76176011)(478600001)(476003)(66066001)(53546011)(86362001)(31686004)(102836004)(26005)(486006)(4326008)(68736007)(6506007)(386003)(31696002)(446003)(4744005)(3846002)(2616005)(106356001)(186003)(11346002)(2906002)(6486002)(6116002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR01MB4905;H:DM6PR01MB4090.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QhHJNTy5x4lHlmHTD6pO/wu2gyOY5rSRdd5GcCDFycth0Rpm2M/P598wvhJytNWmCvovjUU36LZ6SLlHjVDBbqj3vCxOcKAv3LhrWH4/80NyaVPNWMLzS1UUI1MiC4FLW+/4R2mF/QSddVvnuaoHcMvhqJCqAKr2vG97Kkyr5J7DTRMgKqxrXitW8MvO7UdRycvP/rL2qHGWXzVyEBkTh5d+M+8WgIChQktowB5di8qL2WUZK+y0lNv42+fX6WvoAPzbEflvBbnL/QIH0EB5ShpCVuxKKla+YFhiex1m+t0GCDlPxpr5xO1pehxwtZMl0ZjBCuX74EGD/wycnoFmc996UcApUJXnrMeZhLk//wBBmMBojvQNGh+MmtEPhlJgOEPDIZoqDmiHEER9thm+tr72fy3YcWaVZCxTxlsQXmM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDCCED4BDFD45047AC609DD7FF12064F@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7843a37-23a3-4f45-5f6b-08d68de6d3a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 16:59:44.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4905
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi84LzE5IDY6MzQgQU0sIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+IE9uIEZyaSwgRmViIDgs
IDIwMTkgYXQgMTI6NTQgUE0gVGhvbWFzIFBldGF6em9uaQ0KPiA8dGhvbWFzLnBldGF6em9uaUBi
b290bGluLmNvbT4gd3JvdGU6DQo+DQo+PiBIb2FuIFRyYW4ncyBlLW1haWwgaXMgYm91bmNpbmc6
DQo+Pg0KPj4gPGhvdHJhbkBhcG0uY29tPjogaG9zdCBBU1BNWC5MLkdPT0dMRS5DT01bNjQuMjMz
LjE2Ny4yNl0gc2FpZDogNTUwLTUuMi4xIFRoZQ0KPj4gICAgICBlbWFpbCBhY2NvdW50IHRoYXQg
eW91IHRyaWVkIHRvIHJlYWNoIGlzIGRpc2FibGVkLiBMZWFybiBtb3JlIGF0IDU1MCA1LjIuMQ0K
Pj4gICAgICBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9tYWlsLz9wPURpc2FibGVkVXNlciBx
MTk0c2kxNzgwNDAyd21lLjE0NyAtDQo+PiAgICAgIGdzbXRwIChpbiByZXBseSB0byBSQ1BUIFRP
IGNvbW1hbmQpDQo+Pg0KPj4gU28gbGV0J3MgcmVtb3ZlIHRoaXMgZS1tYWlsIGFkZHJlc3MgZnJv
bSB0aGUgTUFJTlRBSU5FUlMgZmlsZSwgYW5kDQo+PiB1cGRhdGUgdGhlIHN0YXR1cyBvZiB0aGUg
ZHJpdmVyIGhlIHdhcyBtYWludGFpbmluZy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMg
UGV0YXp6b25pIDx0aG9tYXMucGV0YXp6b25pQGJvb3RsaW4uY29tPg0KPiBIb2FuIHNob3VsZCB3
ZSBzaW1wbHkgY2hhbmdlIGl0IHRvOg0KPiBIb2FuIFRyYW4gPEhvYW5Ab3MuYW1wZXJlY29tcHV0
aW5nLmNvbT4gPw0KPg0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0KDQpIaSBMaW51cywNCg0K
DQpTb3JyeSBmb3IgdGhlIGluY29udmVuaWVuY2UuDQoNCldlJ3JlIHBvc3RpbmcgYSBwYXRjaCB0
byBjaGFuZ2UgdG8gdGhlIG5ldyBlbWFpbC4NCg0KWzFdIE1BSU5UQUlORVJTOiBVcGRhdGUgQW1w
ZXJlIGVtYWlsIGFkZHJlc3MNCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8x
MDc4NzU1Ny8NCg0KDQpSZWdhcmRzDQoNCkhvYW4NCg0K
