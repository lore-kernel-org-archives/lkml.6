Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0DCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E77020665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="g7yvkVZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfAILsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:48:04 -0500
Received: from mail-eopbgr20134.outbound.protection.outlook.com ([40.107.2.134]:32794
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730089AbfAILsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvTmQIDKeG0iztItlngj23+cFQU/t1FLqltoDPz1a+M=;
 b=g7yvkVZQImyl4tvZvEtZHqmk9SRseu3qVuDGszDAa4LrFOX8fjr05f2NS5J8gwRdtNbCaLLIMqvgOMJ2k8tZ1mns9IdmbUeY+23rK8WQ9o/UH4AHr5zyMnx9ZRFA/2OfodPlt/CIG1QUv0fOHR91pw/2sDMrfD3er2sU2ULFgNI=
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com (10.168.74.23) by
 DB6PR0501MB2501.eurprd05.prod.outlook.com (10.168.73.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 9 Jan 2019 11:47:58 +0000
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::c8ef:ad62:4125:3aba]) by DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::c8ef:ad62:4125:3aba%6]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 11:47:58 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "dev@pschenker.ch" <dev@pschenker.ch>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "coquelin.stm32@gmail.com" <coquelin.stm32@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 7/8] ARM: dts: Add stmpe-adc DT node to Toradex iMX6
 modules
Thread-Topic: [PATCH v5 7/8] ARM: dts: Add stmpe-adc DT node to Toradex iMX6
 modules
Thread-Index: AQHUmTOk7bttGkc2KE+gD5CniwRdcqWm7+sA
Date:   Wed, 9 Jan 2019 11:47:58 +0000
Message-ID: <80de6dff82363982d1e6ab6d99e9304986466d7d.camel@toradex.com>
References: <20181221134638.20600-1-dev@pschenker.ch>
         <20181221134638.20600-8-dev@pschenker.ch>
In-Reply-To: <20181221134638.20600-8-dev@pschenker.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [212.41.222.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0501MB2501;6:eGlP98hBscMuD5TC9J1NSHMrgugZyWxJTuxzVQyLcZ4r0QjFxAbiRgrRNrgTWTtDQmPii06A7v/Yho0CPT+xb6tNgDupdjeFApYtfDIhyeQDGGvPcnhYkx6gIfYYIuZX+/D9mQlryqS4g9HY6vANZSHIaHFqKgTrILooCmd3lx0W2TmiIILAKtG2b/wkvde1FxI+5jQ4sWwUaSgPXNvbRUOMxNxi9HRt+G7JcblA4iaChZ8dABulJDXjTW8BgZKGqsje+HkldWKSOtgDaIjW59/SrESKY1RpAGEWP9iLlNv3OtxSIbWEADvwVNC2OHp4ISfsrxZiZJRFNK2frwIMEvjzAWnXbze8PUZL8c0WuPGAt4IQga5DJ/udZOKVNCJK2e4FOubH1wKd785DfOiE+o3UyfaajVkOuWj86xktRBxtLaygVYIAVSo1AnnucvV8agvTq8RFO+LFGOMW+h3DwQ==;5:pJoKR6aTmwled9o46G0xS8vhuoWm4K+/RBrror8yjB/wUbcUTyhgetnEF1YONTsF8YFfOWit1go0pGd3MEEoH9xAcOzK6FnT83eAnfnLJa/eLfPItP0FwJPTqauUM0N/xRI2egcvN7br+K6vN4/aIRlzHDILoN+t5Jep3AdyVJaQAh6uPrChWbPA/jbilA2dRhtJP0K0y+/zo0/lr3bg8g==;7:lpGFXpL0Xqcux3Q7DoRNm+tc9IJnc8qUMxhiaEcn2YbbLN7ThvGJAvdzL0jGuIE0F3IdOVjiGnxJ+Lelf+LeldQFk8ckSYxrxkxqlaUCnV5SpqwLoD2wPIWWbYbbZjExYB2ZUdlXwHcjkxjGBhHnxg==
x-ms-office365-filtering-correlation-id: 83b195c9-72fa-43f1-5b51-08d676284cf0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2501;
x-ms-traffictypediagnostic: DB6PR0501MB2501:
x-microsoft-antispam-prvs: <DB6PR0501MB2501019A71E842012DE6EFB5FB8B0@DB6PR0501MB2501.eurprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0501MB2501;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2501;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(39840400004)(366004)(346002)(189003)(199004)(6512007)(6506007)(14444005)(256004)(186003)(229853002)(26005)(105586002)(102836004)(486006)(7736002)(6246003)(2201001)(4326008)(305945005)(39060400002)(36756003)(53936002)(14454004)(25786009)(66066001)(478600001)(3846002)(76176011)(6116002)(44832011)(68736007)(106356001)(2906002)(5660300001)(2501003)(7416002)(6486002)(446003)(97736004)(11346002)(4001150100001)(2616005)(8936002)(476003)(86362001)(575784001)(316002)(54906003)(110136005)(81166006)(71200400001)(8676002)(81156014)(71190400001)(118296001)(99286004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0501MB2501;H:DB6PR0501MB2583.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +PxvIxbv+bhlIqP2YL4nlvsNMi9Kp+Ku/xEFuvwKExJbn0j4qAa/M2IMqO5acm1qut7j0AtyEG1goaqPlGGEHlplt1qMDIO0GQFLjb8TMnwuCy6tf1J0ArejTVCb2Ka/pHBzAcHdhzuHilP95VAwSZtGRwe/GFVJcGqOGvQ2vjhc2r57fzJKIauKEu9R8g+In8M/hV7egYL3y6InjOjkd+KZNs6rw6cIGyriMxR2Q7BEdybZZR4rCvypI+65K9OEc2ZPqkasD4QRTzPndkP0x/EIVeEBUfzcDJOMzCgPacJBhwMtxLVWYkGh5RaVvwtp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E166BF52D44B44EAA4D7FA738A39986@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b195c9-72fa-43f1-5b51-08d676284cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 11:47:58.0333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEyLTIxIGF0IDE0OjQ2ICswMTAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gRnJvbTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXgu
Y29tPg0KPiANCj4gQWRkIHRoZSBzdG1wZS1hZGMgRFQgbm9kZSBhcyBmb3VuZCBvbiBUb3JhZGV4
IGlNWDYgbW9kdWxlcw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBo
aWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KDQpBY2tlZC1ieTogTWFyY2VsIFppc3dpbGVy
IDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQoNCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGlu
IHY1OiBOb25lDQo+IENoYW5nZXMgaW4gdjQ6DQo+ICAtIE1vdmVkIFQzMCBkZXZpY2V0cmVlIHNl
dHRpbmdzIHRvIHNlcGFyYXRlIGNvbW1pdA0KPiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gIC0gTm9u
ZQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gIC0gUHV0IGNvbW1vbiBBREMgc2V0dGluZ3MgaW4g
bWZkDQo+IA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1hcGFsaXMuZHRzaSAgfCAyMiAr
KysrKysrKysrKysrKy0tLS0tLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGli
cmkuZHRzaSB8IDIzICsrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDI5IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtYXBhbGlzLmR0c2kNCj4gYi9hcmNoL2FybS9ib290L2R0
cy9pbXg2cWRsLWFwYWxpcy5kdHNpDQo+IGluZGV4IDNkYzk5ZGQ4ZGRlMS4uOGRiNDc2ZDg5Nzhk
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWFwYWxpcy5kdHNpDQo+
ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtYXBhbGlzLmR0c2kNCj4gQEAgLTMzMSwx
MSArMzMxLDE4IEBADQo+ICAJCWlkID0gPDA+Ow0KPiAgCQlibG9ja3MgPSA8MHg1PjsNCj4gIAkJ
aXJxLXRyaWdnZXIgPSA8MHgxPjsNCj4gKwkJLyogMy4yNSBNSHogQURDIGNsb2NrIHNwZWVkICov
DQo+ICsJCXN0LGFkYy1mcmVxID0gPDE+Ow0KPiArCQkvKiAxMi1iaXQgQURDICovDQo+ICsJCXN0
LG1vZC0xMmIgPSA8MT47DQo+ICsJCS8qIGludGVybmFsIEFEQyByZWZlcmVuY2UgKi8NCj4gKwkJ
c3QscmVmLXNlbCA9IDwwPjsNCj4gKwkJLyogQURDIGNvbnZlcnN0aW9uIHRpbWU6IDgwIGNsb2Nr
cyAqLw0KPiArCQlzdCxzYW1wbGUtdGltZSA9IDw0PjsNCj4gKwkJLyogZm9yYmlkIHRvIHVzZSBB
REMgY2hhbm5lbHMgMy0wICh0b3VjaCkgKi8NCj4gIA0KPiAgCQlzdG1wZV90b3VjaHNjcmVlbiB7
DQo+ICAJCQljb21wYXRpYmxlID0gInN0LHN0bXBlLXRzIjsNCj4gLQkJCS8qIDMuMjUgTUh6IEFE
QyBjbG9jayBzcGVlZCAqLw0KPiAtCQkJc3QsYWRjLWZyZXEgPSA8MT47DQo+ICAJCQkvKiA4IHNh
bXBsZSBhdmVyYWdlIGNvbnRyb2wgKi8NCj4gIAkJCXN0LGF2ZS1jdHJsID0gPDM+Ow0KPiAgCQkJ
LyogNyBsZW5ndGggZnJhY3Rpb25hbCBwYXJ0IGluIHogKi8NCj4gQEAgLTM0NSwxNyArMzUyLDE2
IEBADQo+ICAJCQkgKiBjdXJyZW50IGxpbWl0IHZhbHVlDQo+ICAJCQkgKi8NCj4gIAkJCXN0LGkt
ZHJpdmUgPSA8MT47DQo+IC0JCQkvKiAxMi1iaXQgQURDICovDQo+IC0JCQlzdCxtb2QtMTJiID0g
PDE+Ow0KPiAtCQkJLyogaW50ZXJuYWwgQURDIHJlZmVyZW5jZSAqLw0KPiAtCQkJc3QscmVmLXNl
bCA9IDwwPjsNCj4gLQkJCS8qIEFEQyBjb252ZXJzdGlvbiB0aW1lOiA4MCBjbG9ja3MgKi8NCj4g
LQkJCXN0LHNhbXBsZS10aW1lID0gPDQ+Ow0KPiAgCQkJLyogMSBtcyBwYW5lbCBkcml2ZXIgc2V0
dGxpbmcgdGltZSAqLw0KPiAgCQkJc3Qsc2V0dGxpbmcgPSA8Mz47DQo+ICAJCQkvKiA1IG1zIHRv
dWNoIGRldGVjdCBpbnRlcnJ1cHQgZGVsYXkgKi8NCj4gIAkJCXN0LHRvdWNoLWRldC1kZWxheSA9
IDw1PjsNCj4gIAkJfTsNCj4gKw0KPiArCQlzdG1wZV9hZGMgew0KPiArCQkJY29tcGF0aWJsZSA9
ICJzdCxzdG1wZS1hZGMiOw0KPiArCQkJc3Qsbm9yZXF1ZXN0LW1hc2sgPSA8MHgwRj47DQo+ICsJ
CX07DQo+ICAJfTsNCj4gIH07DQo+ICANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZxZGwtY29saWJyaS5kdHNpDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1jb2xp
YnJpLmR0c2kNCj4gaW5kZXggODdlMTVlN2NiMzJiLi4yZTMwM2Q3OWM3ZjggMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNpDQo+ICsrKyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNpDQo+IEBAIC0yNjIsMTEgKzI2MiwxOCBA
QA0KPiAgCQlpZCA9IDwwPjsNCj4gIAkJYmxvY2tzID0gPDB4NT47DQo+ICAJCWlycS10cmlnZ2Vy
ID0gPDB4MT47DQo+ICsJCS8qIDMuMjUgTUh6IEFEQyBjbG9jayBzcGVlZCAqLw0KPiArCQlzdCxh
ZGMtZnJlcSA9IDwxPjsNCj4gKwkJLyogMTItYml0IEFEQyAqLw0KPiArCQlzdCxtb2QtMTJiID0g
PDE+Ow0KPiArCQkvKiBpbnRlcm5hbCBBREMgcmVmZXJlbmNlICovDQo+ICsJCXN0LHJlZi1zZWwg
PSA8MD47DQo+ICsJCS8qIEFEQyBjb252ZXJzdGlvbiB0aW1lOiA4MCBjbG9ja3MgKi8NCj4gKwkJ
c3Qsc2FtcGxlLXRpbWUgPSA8ND47DQo+ICsJCS8qIGZvcmJpZCB0byB1c2UgQURDIGNoYW5uZWxz
IDMtMCAodG91Y2gpICovDQo+ICANCj4gIAkJc3RtcGVfdG91Y2hzY3JlZW4gew0KPiAgCQkJY29t
cGF0aWJsZSA9ICJzdCxzdG1wZS10cyI7DQo+IC0JCQkvKiAzLjI1IE1IeiBBREMgY2xvY2sgc3Bl
ZWQgKi8NCj4gLQkJCXN0LGFkYy1mcmVxID0gPDE+Ow0KPiAgCQkJLyogOCBzYW1wbGUgYXZlcmFn
ZSBjb250cm9sICovDQo+ICAJCQlzdCxhdmUtY3RybCA9IDwzPjsNCj4gIAkJCS8qIDcgbGVuZ3Ro
IGZyYWN0aW9uYWwgcGFydCBpbiB6ICovDQo+IEBAIC0yNzYsMTcgKzI4MywxNyBAQA0KPiAgCQkJ
ICogY3VycmVudCBsaW1pdCB2YWx1ZQ0KPiAgCQkJICovDQo+ICAJCQlzdCxpLWRyaXZlID0gPDE+
Ow0KPiAtCQkJLyogMTItYml0IEFEQyAqLw0KPiAtCQkJc3QsbW9kLTEyYiA9IDwxPjsNCj4gLQkJ
CS8qIGludGVybmFsIEFEQyByZWZlcmVuY2UgKi8NCj4gLQkJCXN0LHJlZi1zZWwgPSA8MD47DQo+
IC0JCQkvKiBBREMgY29udmVyc3Rpb24gdGltZTogODAgY2xvY2tzICovDQo+IC0JCQlzdCxzYW1w
bGUtdGltZSA9IDw0PjsNCj4gIAkJCS8qIDEgbXMgcGFuZWwgZHJpdmVyIHNldHRsaW5nIHRpbWUg
Ki8NCj4gIAkJCXN0LHNldHRsaW5nID0gPDM+Ow0KPiAgCQkJLyogNSBtcyB0b3VjaCBkZXRlY3Qg
aW50ZXJydXB0IGRlbGF5ICovDQo+ICAJCQlzdCx0b3VjaC1kZXQtZGVsYXkgPSA8NT47DQo+ICAJ
CX07DQo+ICsNCj4gKwkJc3RtcGVfYWRjIHsNCj4gKwkJCWNvbXBhdGlibGUgPSAic3Qsc3RtcGUt
YWRjIjsNCj4gKwkJCS8qIDMuMjUgTUh6IEFEQyBjbG9jayBzcGVlZCAqLw0KPiArCQkJc3Qsbm9y
ZXF1ZXN0LW1hc2sgPSA8MHgwRj47DQo+ICsJCX07DQo+ICAJfTsNCj4gIH07DQo=
