Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501DCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1796020651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AgpmqYnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393123AbfAPNYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:24:55 -0500
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:46501
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732880AbfAPNYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK32LNF2QQX5PnMpHol5IcP8snf0+pXpiBwtLMCeZ5E=;
 b=AgpmqYnMqwOddDX1zLdSSB4epq2vBqvFmTuunkvIZsRjfRdTsyiK9pPpGdTMX5PuM5cgyYq6VpWCL1ZbxpfRdUwNIdn63P/nBrN5BS8tt1MdXdaUyATCChVGjlkQ2l6N0NXlmNj+LYFPAkGK6bm5z6vMU6ZDpxaFjldWtULaTUw=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2943.eurprd04.prod.outlook.com (10.175.24.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 16 Jan 2019 13:24:49 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57%3]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 13:24:49 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx: Fix MU4_INT number
Thread-Topic: [PATCH] arm64: dts: imx: Fix MU4_INT number
Thread-Index: AQHUrPR8+s4T0qQiBEy8rhYNUN5cRKWx4EYAgAADhQA=
Date:   Wed, 16 Jan 2019 13:24:49 +0000
Message-ID: <11058ce79d91a49e47be47bd369ddc111875fa23.camel@nxp.com>
References: <20190115170501.10952-1-daniel.baluta@nxp.com>
         <CAOMZO5D_kakB82dEcXrU4EZARLj90US8Zf+sGgaKkZvUG3t=PA@mail.gmail.com>
In-Reply-To: <CAOMZO5D_kakB82dEcXrU4EZARLj90US8Zf+sGgaKkZvUG3t=PA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2943;6:gCagNyJPzS6ciyLYv2W6p7GCPTnZ6iZzkw3S70zem0+RMxKHKxMXH/uVWL4I8e0e0YA+J1PjCA+zrqiiCypjfd+HHadXEY8I4Bu30I7dyQrIqpVVcVjCIJTpsTR3TVzMX3H7JmLUgQ73vJddYjqclwmSAARRH82Jp08atvsV6WQju5ycwA5CBfAa7xL/Zv6Yo0Hb4lAph6d1HjxNZbxsUfzhWKatSbdC/D14SZIKrEWJF9XAAjTp6IIwfggd+W8vc7MlY/DACmU+oZa4vATyZvTLNc7eST0XEV83qubwH+jM/94hWnbMLM0OWVSx7Bg0AUt+ONvXvCTnaVWJNUdtxYZqCKVKVzambIdHdrBbiNvEWw/Ijd7Vcw0sJcAiyKa2cEBOzbhM2Tl9beeMTjdpzg4ec1X4UYximYbQXgfdTAw5B1Rtq5u1PJn1oUG2bHK4SRz5aMu6QvrMaP83WTNkwQ==;5:zJRf3SeKfOnF1J350kz4uoMvWRNZDVBq7iDsy3jWQTb0xoFRRLFTaFTQ1zRO3Zzc8VvS9nMshAtSs/n26uBCiqklu3aMBgvFtxE9VuPWRRF9UOPjJRIy50c39FNjLXOoIglb2/iqRRmxT4kV8dxPCPnYQw/kdEm3hYXUxFPIc7ovFzveKQMMRy8365GJwRebK/662X8Ktv1QKGHOv9TVBQ==;7:dl4l6nctxLRRhQbMCml7IWxmdPpINXuRt1wjiV/g9IjHI/pAuiK42nhqAKeFBBt92WEjuCKdubFQ1FA6Mjla/S0vQ9+NN7f9nm9G5vzGXPHsP327t/5m11OP9hO+p0Wg3A01+7WwP+Wdp5KkOtaHSQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3d3db9ae-a7ff-4549-00f6-08d67bb5fda4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2943;
x-ms-traffictypediagnostic: VI1PR0402MB2943:
x-microsoft-antispam-prvs: <VI1PR0402MB2943D3BCFA4CE4C43A148584F9820@VI1PR0402MB2943.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(6506007)(6116002)(3846002)(25786009)(476003)(6436002)(6486002)(186003)(76176011)(44832011)(4326008)(229853002)(66066001)(86362001)(105586002)(106356001)(2351001)(1411001)(8676002)(486006)(54906003)(39060400002)(26005)(11346002)(81166006)(81156014)(2906002)(316002)(1730700003)(5640700003)(97736004)(8936002)(446003)(118296001)(1361003)(2616005)(53546011)(7736002)(102836004)(305945005)(36756003)(2501003)(14454004)(68736007)(6512007)(256004)(71190400001)(71200400001)(99286004)(478600001)(6246003)(5660300001)(53936002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2943;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p5r2GrO2BG73MQ2cRzokyhxbKNL6aHd3oqOxoF5Fxss+KRtUuQzdYYM3Hd9JxuQjOLzOCAXd8vrJ2ZWcn01UJItEcAb/t9K8BLxqVbCRjcRQ9wNBVvLoCqVddNv1EMPg29ssMlrxxkhG8+c+yr1na/H9dx6Nh/tuyYnFgEHbxaO5soBW9SRet7GQIl81vdB4fvU14gd4Scucj+qvg/u9yZb+vhJUPvk1QjVFsXwthb01mMwnPukrva6oxmCjqlJtOSOUtYdhLPzueAgtoLaJ88K39GFNiTFjAGorrLBsOBFTHxUfYO92wW0sbjG9gfl4SdzoDJXclcdH9yMQ+XM/aKzhnUWoUZJ2oyERR+VrEyDCY9TVNCmT61tiG/gkAI3fOQe2HUJjbDrhQi21HAmpsI3on1JRHgoyJuYZ5LPwDqE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D477C7A82A01A469730D7380997E81C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3db9ae-a7ff-4549-00f6-08d67bb5fda4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 13:24:49.2673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAxLTE2IGF0IDExOjEyIC0wMjAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBIaSBEYW5pZWwsDQo+IA0KPiBPbiBUdWUsIEphbiAxNSwgMjAxOSBhdCAzOjA1IFBNIERhbmll
bCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gTVU0
X0lOVCBjb3JyZWN0IG51bWJlciBpcyAxODAsIHdoaWxlIDE3OSBpcyBmb3IgTVUzX0lOVC4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5j
b20+DQo+IA0KPiBUd28gbml0cGlja3M6DQo+IA0KPiAxLiBJbiB0aGUgU3ViamVjdCBpdCB3b3Vs
ZCBiZSBiZXR0ZXIgdG8gc3BlY2lmeSB0aGUgU29DIG5hbWU6DQo+IGFybTY0OiBkdHM6IGlteDhx
eHA6IEZpeCBNVTRfSU5UIG51bWJlcg0KPiANCj4gMi4gSXQgd291bGQgYmUgbmljZSB0byBhZGQg
YSBGaXhlcyB0YWcNCj4gDQo+IFJldmlld2VkLWJ5OiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBn
bWFpbC5jb20+DQoNClRoYW5rcyBGYWJpbyBmb3IgcmV2aWV3LiBGaXhlZCBpbiB2Mi4NCg0KDQo=
