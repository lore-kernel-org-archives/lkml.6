Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BBDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7EE218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="JeBMw1N7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfBRC5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:57:33 -0500
Received: from mail-eopbgr1320102.outbound.protection.outlook.com ([40.107.132.102]:56598
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728093AbfBRC5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzk1HiILVdGYWS/egPQLhDietIQwwQJbSqJ3e26u0jI=;
 b=JeBMw1N7w8qa0wvyHHjIJoh2UwU7tJ1w+ndaahCG5HVekLpfhn8MRs5EzBunAAyFSnl0NhyWqNYIz1CyY0xXbHfXxkJ8Xlh1zQU3I+ehfuupkbxoJ8BY76m1YwILiJe4g1gSrQ4Le+FADMVJyUD36qp6x1HHhNnjI5TsO3bqJj0=
Received: from TY2PR01MB4812.jpnprd01.prod.outlook.com (20.179.170.147) by
 TY2PR01MB2473.jpnprd01.prod.outlook.com (20.177.97.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 02:57:27 +0000
Received: from TY2PR01MB4812.jpnprd01.prod.outlook.com
 ([fe80::44b:a054:4954:f819]) by TY2PR01MB4812.jpnprd01.prod.outlook.com
 ([fe80::44b:a054:4954:f819%2]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 02:57:27 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] USB: renesas_usbhs: fix spelling mistake "doens't" ->
 "doesn't"
Thread-Topic: [PATCH] USB: renesas_usbhs: fix spelling mistake "doens't" ->
 "doesn't"
Thread-Index: AQHUxxJXLLPVMXZXh0GU2RjqBSg1+aXk3QEQ
Date:   Mon, 18 Feb 2019 02:57:26 +0000
Message-ID: <TY2PR01MB4812BB4DEA0983E1A1E940B6D8630@TY2PR01MB4812.jpnprd01.prod.outlook.com>
References: <20190217224418.17163-1-colin.king@canonical.com>
In-Reply-To: <20190217224418.17163-1-colin.king@canonical.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67b75cda-9975-4c6d-a0a2-08d6954cd0c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB2473;
x-ms-traffictypediagnostic: TY2PR01MB2473:
x-microsoft-exchange-diagnostics: 1;TY2PR01MB2473;20:QbSQLW30zG/tYJ3+l5ZechRbZRu5e4YYhQHXyClzjpWDmpJcxalFc/+fakBz0s+uhrOLemR9w4u5uVKKKdGn+YBFaM1GJvDh69jL1nVFY+we4p8RInZLyPrbspD1m0oBgwIEroUSFD72IZpC5t6fiX5x8pWzomp7iJiFliqlH88=
x-microsoft-antispam-prvs: <TY2PR01MB24734EE311F7CAFCF8692410D8630@TY2PR01MB2473.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(396003)(39860400002)(376002)(199004)(189003)(14454004)(478600001)(5660300002)(3846002)(81156014)(2906002)(6116002)(99286004)(55016002)(14444005)(256004)(53936002)(81166006)(6436002)(486006)(305945005)(71200400001)(6246003)(476003)(11346002)(71190400001)(4326008)(186003)(9686003)(68736007)(74316002)(26005)(7736002)(97736004)(106356001)(54906003)(446003)(105586002)(76176011)(8936002)(25786009)(6506007)(66066001)(229853002)(33656002)(102836004)(110136005)(86362001)(316002)(8676002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB2473;H:TY2PR01MB4812.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ArQSgegT4YI7cuy1RlkPPm10vEizH/209bHLPrMkslgv5+aKsjcXaDIWn+UhtuhsZTK1h7RsptWPcWIo2HOlxoyE3/0mXcVgW6+smDQp/1yB4xSYoxkSvBEkG1y9E3HO+N6az5DAovy/Du389wthtqQ05Sg4fFe5h9UjHwenYfLGilmQo7WzrZ6kol/kzE9zuu5lR4MZIln4ul0NGfQt/qFQXgSsBUoOrCmDeA7nip+YlVHPfAMPOds+SbrAU4PkR4UyLIxzZWNesy2SiT7hz1yO8ok2s/+xlt5gp6rBws82AQt3g9P8z8Csn24GqPDUV9P0ZtBfph2I2XFUrPo3v5YB+vo7n1OyP88oiaoRDv8M2KRF+JUU3ye8OQK6jtyqN1ohzqGUNNrFuTLODQVXSLin8VbaVscjpU/HHEhAsOU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b75cda-9975-4c6d-a0a2-08d6954cd0c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 02:57:27.0610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2473
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gRnJvbTogQ29saW4gS2luZywgU2VudDogTW9uZGF5LCBGZWJydWFyeSAxOCwgMjAx
OSA3OjQ0IEFNDQo+IA0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmlj
YWwuY29tPg0KPiANCj4gVGhlcmUgaXMgYSBzcGVsbGluZyBtaXN0YWtlIGluIGEgZGV2X2VyciBt
ZXNzYWdlLiBGaXggaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29s
aW4ua2luZ0BjYW5vbmljYWwuY29tPg0KDQpUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCENCg0KQWNr
ZWQtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNv
bT4NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiAtLS0NCj4gIGRyaXZl
cnMvdXNiL3JlbmVzYXNfdXNiaHMvbW9kX2hvc3QuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL3JlbmVzYXNfdXNiaHMvbW9kX2hvc3QuYyBiL2RyaXZlcnMvdXNiL3JlbmVzYXNfdXNi
aHMvbW9kX2hvc3QuYw0KPiBpbmRleCA0ZTU5YzY0OWRiODEuLmRkZDNiZTQ4Zjk0OCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvcmVuZXNhc191c2Jocy9tb2RfaG9zdC5jDQo+ICsrKyBiL2Ry
aXZlcnMvdXNiL3JlbmVzYXNfdXNiaHMvbW9kX2hvc3QuYw0KPiBAQCAtMzQwLDcgKzM0MCw3IEBA
IHN0YXRpYyB2b2lkIHVzYmhzaF9waXBlX2RldGFjaChzdHJ1Y3QgdXNiaHNoX2hwcml2ICpocHJp
diwNCj4gIAlwaXBlID0gdXNiaHNoX3VlcF90b19waXBlKHVlcCk7DQo+IA0KPiAgCWlmICh1bmxp
a2VseSghcGlwZSkpIHsNCj4gLQkJZGV2X2VycihkZXYsICJ1ZXAgZG9lbnMndCBoYXZlIHBpcGVc
biIpOw0KPiArCQlkZXZfZXJyKGRldiwgInVlcCBkb2Vzbid0IGhhdmUgcGlwZVxuIik7DQo+ICAJ
fSBlbHNlIGlmICgxID09IHVlcC0+Y291bnRlci0tKSB7IC8qIGxhc3QgdXNlciAqLw0KPiAgCQlz
dHJ1Y3QgdXNiX2hvc3RfZW5kcG9pbnQgKmVwID0gdXNiaHNoX3VlcF90b19lcCh1ZXApOw0KPiAg
CQlzdHJ1Y3QgdXNiaHNoX2RldmljZSAqdWRldiA9IHVzYmhzaF91ZXBfdG9fdWRldih1ZXApOw0K
PiAtLQ0KPiAyLjIwLjENCg0K
