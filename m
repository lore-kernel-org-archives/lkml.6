Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB28ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E63D2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="TsFYbz/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E63D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeGRVZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:25:54 -0400
Received: from mail-eopbgr10123.outbound.protection.outlook.com ([40.107.1.123]:63821
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbeGRVZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOOr9V23aTedGP2CQNPO7gT2DumuMQE74rxBjX2Mz8Q=;
 b=TsFYbz/RvYtvk7y+rIl3GXpkmfmlmyuMShpx7+tsjhOv3qO4JNFJOni4/wV6QQV/Km2WvIy8mQXGUuOobmo2Vj03kqAkDz4OtfqYN+AzZPc/MT5sRY4Tf73GQW5HSQLdKoNukGY4JKB3XUQcROJfToGlay4zXSPE1goSKi5v1W4=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2320.eurprd05.prod.outlook.com (10.169.135.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 20:46:11 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.016; Wed, 18 Jul 2018
 20:46:11 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
CC:     "pombredanne@nexb.com" <pombredanne@nexb.com>
Subject: Re: [PATCH 3/3] ARM: tegra: tegra20: Fix mixed tabs-spaces
 indentation
Thread-Topic: [PATCH 3/3] ARM: tegra: tegra20: Fix mixed tabs-spaces
 indentation
Thread-Index: AQHUHtBnxCNvJiGPkEuKd5qxDv5xD6SVcxWA
Date:   Wed, 18 Jul 2018 20:46:11 +0000
Message-ID: <1531946769.26473.9.camel@toradex.com>
References: <20180718194824.3704-1-krzk@kernel.org>
         <20180718194824.3704-3-krzk@kernel.org>
In-Reply-To: <20180718194824.3704-3-krzk@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2320;7:ibtc+ke1vqWD9mvBKtGE4AqtIFoeAqRuTpvtDP0ceyV+idvcCocx8qrfbQnCXVeOgJh5qZn9vCnx3W7XrAGvlNsUNGs7tyT/UZDK9NbLhVkab7lwjghDz5YVVLKeaneEZeK382ifjQw4ufDBtMD/oRlk8UiZB+srFleQ9ACHmhRk/uigqWifHx13sG5fT5koPdr3l3WAOTDLjTux3FdiU1suGanrs1ev2oMd+WkLIwN7hzvInaykO54+VQOajZgS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c7eefad2-7f72-49ee-2fa5-08d5ecef7ede
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2320;
x-ms-traffictypediagnostic: VI1PR0501MB2320:
x-microsoft-antispam-prvs: <VI1PR0501MB232017FFBA493464BAEFF6FBFB530@VI1PR0501MB2320.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2320;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2320;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(346002)(376002)(39840400004)(189003)(199004)(6512007)(6506007)(102836004)(25786009)(110136005)(99286004)(186003)(26005)(66066001)(316002)(6486002)(6436002)(106356001)(105586002)(446003)(36756003)(76176011)(229853002)(7736002)(14454004)(44832011)(486006)(7416002)(11346002)(68736007)(14444005)(256004)(103116003)(39060400002)(5660300001)(5250100002)(6246003)(4326008)(2501003)(2900100001)(2906002)(81166006)(3846002)(2201001)(6116002)(8676002)(81156014)(8936002)(97736004)(86362001)(2616005)(476003)(478600001)(53936002)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2320;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W7cuAki9MN80szSNxJbMWGXrWcVh+ipfEU4TUmMcWthn61Y5EySf/T4Ifr0U69aUtx48ts3HRYqRK2tWMgVWctDaJLfvpkkIxvM/9xYvNVsnGOkpch+1ivitYRufhSGv9nkRWirXzoo2DGOCwm6HAs3m24izcx4nGrthQBABVCmD//mhuhgYLsNB9yOZHOpngWm+LUEnDYeMw4kHLmZu9wrFrYKH/DUY0EDRzdD8kpMtc55cbYmZG7fOzGepeoB2HSOyV0ZK+ctnPcZcvVLJA+1l8jRi/wpk/GvmTtrZgzBAqyHCHisKdPuuQnNf+8OP43U3DxcU2J5E56+tsAmIoE1+exzulZ8NVFlHjzAVz3s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0770B62D278EDF43851D05F11169D269@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7eefad2-7f72-49ee-2fa5-08d5ecef7ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 20:46:11.1131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA3LTE4IGF0IDIxOjQ4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBGaXggaW5kZW50YXRpb24gYW5kIGFsaWdubWVudCB3aGVuIHNwYWNlcyB3ZXJlIHVz
ZWQgaW5zdGVhZCBvZiB0YWJzLg0KPiBUaGlzIGZpeGVzIGNoZWNrcGF0Y2ggZXJyb3JzIGxpa2U6
DQo+IA0KPiAgICAgRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCB1c2UgdGFicyB3aGVyZSBwb3Nz
aWJsZQ0KPiAgICAgIzMwNjogRklMRTogYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEyMC1wYXowMC5k
dHM6MzA2Og0KPiAgICAgK15JXkkgICAgICAgICA8JnRlZ3JhX2NhciBURUdSQTIwX0NMS19QTExf
UF9PVVQzPjskDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnpr
QGtlcm5lbC5vcmc+DQoNCkFja2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxl
ckB0b3JhZGV4LmNvbT4NCg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMjAtY29s
aWJyaS5kdHNpIHwgMiArLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEyMC1wYXowMC5kdHMg
ICAgfCA2ICsrKy0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEyMC1j
b2xpYnJpLmR0c2kNCj4gYi9hcmNoL2FybS9ib290L2R0cy90ZWdyYTIwLWNvbGlicmkuZHRzaQ0K
PiBpbmRleCBlN2I5YWIwOTkwOGEuLmZhMWFmMmRjMjc2YyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvdGVncmEyMC1jb2xpYnJpLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvdGVncmEyMC1jb2xpYnJpLmR0c2kNCj4gQEAgLTU0MSw3ICs1NDEsNyBAQA0KPiAgDQo+ICAJ
c291bmQgew0KPiAgCQljb21wYXRpYmxlID0gIm52aWRpYSx0ZWdyYS1hdWRpby13bTk3MTItDQo+
IGNvbGlicmlfdDIwIiwNCj4gLQkJCSAgICAgICAgICJudmlkaWEsdGVncmEtYXVkaW8td205NzEy
IjsNCj4gKwkJCSAgICAgIm52aWRpYSx0ZWdyYS1hdWRpby13bTk3MTIiOw0KPiAgCQludmlkaWEs
bW9kZWwgPSAiQ29saWJyaSBUMjAgQUM5NyBBdWRpbyI7DQo+ICANCj4gIAkJbnZpZGlhLGF1ZGlv
LXJvdXRpbmcgPQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEyMC1wYXow
MC5kdHMNCj4gYi9hcmNoL2FybS9ib290L2R0cy90ZWdyYTIwLXBhejAwLmR0cw0KPiBpbmRleCBl
ZjI0NTI5MTkyNGYuLjdkOGFlZjZlYmQzYSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9k
dHMvdGVncmEyMC1wYXowMC5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEyMC1w
YXowMC5kdHMNCj4gQEAgLTMwMyw3ICszMDMsNyBAQA0KPiAgCQlyZXF1ZXN0LWdwaW9zID0gPCZn
cGlvIFRFR1JBX0dQSU8oViwgMikNCj4gR1BJT19BQ1RJVkVfSElHSD47DQo+ICAJCXNsYXZlLWFk
ZHIgPSA8MTM4PjsNCj4gIAkJY2xvY2tzID0gPCZ0ZWdyYV9jYXIgVEVHUkEyMF9DTEtfSTJDMz4s
DQo+IC0JCSAgICAgICAgIDwmdGVncmFfY2FyIFRFR1JBMjBfQ0xLX1BMTF9QX09VVDM+Ow0KPiAr
CQkJIDwmdGVncmFfY2FyIFRFR1JBMjBfQ0xLX1BMTF9QX09VVDM+Ow0KPiAgCQljbG9jay1uYW1l
cyA9ICJkaXYtY2xrIiwgImZhc3QtY2xrIjsNCj4gIAkJcmVzZXRzID0gPCZ0ZWdyYV9jYXIgNjc+
Ow0KPiAgCQlyZXNldC1uYW1lcyA9ICJpMmMiOw0KPiBAQCAtNTk5LDggKzU5OSw4IEBADQo+ICAJ
CQlHUElPX0FDVElWRV9ISUdIPjsNCj4gIA0KPiAgCQljbG9ja3MgPSA8JnRlZ3JhX2NhciBURUdS
QTIwX0NMS19QTExfQT4sDQo+IC0JCSAgICAgICAgIDwmdGVncmFfY2FyIFRFR1JBMjBfQ0xLX1BM
TF9BX09VVDA+LA0KPiAtCQkgICAgICAgICA8JnRlZ3JhX2NhciBURUdSQTIwX0NMS19DREVWMT47
DQo+ICsJCQkgPCZ0ZWdyYV9jYXIgVEVHUkEyMF9DTEtfUExMX0FfT1VUMD4sDQo+ICsJCQkgPCZ0
ZWdyYV9jYXIgVEVHUkEyMF9DTEtfQ0RFVjE+Ow0KPiAgCQljbG9jay1uYW1lcyA9ICJwbGxfYSIs
ICJwbGxfYV9vdXQwIiwgIm1jbGsiOw0KPiAgCX07DQo+ICB9Ow0KDQpCVFc6IEkgYW0gYW55d2F5
IGluIHRoZSBwcm9jZXNzIG9mIHNlbmRpbmcgb3V0IGEgbWFqb3IgcmV2YW1wIG9mIGFsbCBvdXIg
ZGV2aWNlIHRyZWVzIHRhcmdldGluZyB0aGUgVGVncmFzIGFuZCBsaWtld2lzZSBtYWRlIHN1cmUg
dGhleSBkbyBwYXNzIGNoZWNrcGF0Y2ggKDstcCku
