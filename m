Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16A0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6E02084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="JeX+GC2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6E02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbeGRVRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:17:07 -0400
Received: from mail-eopbgr10119.outbound.protection.outlook.com ([40.107.1.119]:12096
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729262AbeGRVRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9clIluK9rTKxWGh80Rmzs/ptjjZ+zXU2nnliWM8Gxiw=;
 b=JeX+GC2I0XyjK+I/wXr2yw0O5M1id4MfKtii8q6fyCeegscqet3Nxd/rIDzfHhCbkyA6jWOV4ZtPwmRLQs1JpSbKw6jPJDyaTKNEoFL6VzBURgPf5+NHSICyWtwRy5qwH3OOubKtUlzuu/aXXIQYJEFwPvPSfmluWu7vJDt9A2E=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2413.eurprd05.prod.outlook.com (10.168.135.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.20; Wed, 18 Jul 2018 20:37:27 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.016; Wed, 18 Jul 2018
 20:37:27 +0000
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
Subject: Re: [PATCH 1/3] ARM: tegra: apalis-tk1: Fix SPDX license identifier
 format
Thread-Topic: [PATCH 1/3] ARM: tegra: apalis-tk1: Fix SPDX license identifier
 format
Thread-Index: AQHUHtBmAeDWkbrdBkqi91HGS9NPuKSVcKSA
Date:   Wed, 18 Jul 2018 20:37:27 +0000
Message-ID: <1531946245.26473.2.camel@toradex.com>
References: <20180718194824.3704-1-krzk@kernel.org>
In-Reply-To: <20180718194824.3704-1-krzk@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2413;7:j4dVfQEg/u/+pdpnvwbvjVsourIZjKkw3XOEGz/Ij03H/GEBJQgOd5DsXEHVSE42Yoom0D0nUFOWiQANIhYO8GfbINJaTAnR0sh5y0bdBAVgS0R3cYlzH1GkAOOxeeLX8cCyVvwiu1A7Yn2nqSp4nuNBhhlvbn92q59kSVsjvdlg2TJQUsw2JGSnVgm//SYyLFCtL0mpUj6dAn06CITvYqyY3JHQ9l1usupuYHBCH+KINWH7dxmL+Rk/2u5yoPZm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 260bfb16-49e4-49f2-faab-08d5ecee4684
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2413;
x-ms-traffictypediagnostic: VI1PR0501MB2413:
x-microsoft-antispam-prvs: <VI1PR0501MB24135AEE07228750AA115B62FB530@VI1PR0501MB2413.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2413;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2413;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(136003)(39840400004)(376002)(189003)(199004)(256004)(305945005)(53936002)(6486002)(2900100001)(25786009)(39060400002)(6116002)(110136005)(86362001)(229853002)(99286004)(2201001)(575784001)(5250100002)(3846002)(66066001)(316002)(2501003)(6512007)(7736002)(446003)(478600001)(4326008)(76176011)(68736007)(6506007)(6306002)(186003)(44832011)(26005)(6436002)(8936002)(102836004)(5660300001)(486006)(81156014)(81166006)(36756003)(966005)(2616005)(11346002)(476003)(106356001)(105586002)(103116003)(97736004)(8676002)(14454004)(6246003)(7416002)(2906002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2413;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AndxLvNtp65n6h2vKOk7Sw7sZJc4jYLc87gcswKVTI30w9nW/z1ygP8rYNs2jqLurUsH4LltVeb798SGxkqyyYVCw8XeKYWQi/6+fueKO7ayDP6G5ryWdN6/67G2RL3H/RZody2P7baqez++2mLfk/PoErarbcLz5usRkt4oypIfSvQK/V9hnQrdwvd0RnMqDCb3PiXIEcMa/QkUND8PSpdMHs8yUanpHvrgHJCsq6szD8RIsvSGRUZ/6o+dGdDBCNs1GK9hNxVjEs4cbdGtyr4vdHpKdajOZina1lGYkJMepa52aIfbSI1w5pHA4SDlkaYSdQDgIyGpsqleD21eUTDBxSLb7on6kkogSzVfDvE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8BE378C082095478660DD1C9143EA8B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260bfb16-49e4-49f2-faab-08d5ecee4684
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 20:37:27.0773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA3LTE4IGF0IDIxOjQ4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBGaXggaW5jb3JyZWN0IGZvcm1hdCB1c2VkIGZvciBPUiBjbGF1c2UgaW4gU1BEWCBs
aWNlbnNlIGlkZW50aWZpZXIuDQoNCkNhbiB5b3UgcGxlYXNlIGVsYWJvcmF0ZSBob3cgeW91IGdv
dCB0byB0aGF0IGNvbmNsdXNpb24gYXMgdGhlcmUgYXJlDQp2YXJpb3VzIG90aGVyIGRldmljZSB0
cmVlcyBoYXZpbmcgaXQgc3BlY2lmaWVkIHRoZSBleGFjdCBzYW1lIHdheS4gUGx1cw0KSSB3YXMg
YWN0dWFsbHkgZXZlbiBpbiBkaXNjdXNzaW9uIHdpdGggUGhpbGlwcGUgb24gdGhhdCBwYXRjaCBz
ZXQgYmFjaw0Kd2hlbiBJIGludHJvZHVjZWQgdGhvc2UuDQoNCj4gU2lnbmVkLW9mZi1ieTogS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL3RlZ3JhMTI0LWFwYWxpcy12MS4yLWV2YWwuZHRzIHwgMiArLQ0KPiAgYXJjaC9hcm0v
Ym9vdC9kdHMvdGVncmExMjQtYXBhbGlzLXYxLjIuZHRzaSAgICAgfCAyICstDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy90ZWdyYTEyNC1hcGFsaXMtdjEuMi1ldmFsLmR0cw0KPiBi
L2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTI0LWFwYWxpcy12MS4yLWV2YWwuZHRzDQo+IGluZGV4
IDhhOGQ1ZmEwZWNkMS4uZTJjMGQ4ZWZiMzU4IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290
L2R0cy90ZWdyYTEyNC1hcGFsaXMtdjEuMi1ldmFsLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290
L2R0cy90ZWdyYTEyNC1hcGFsaXMtdjEuMi1ldmFsLmR0cw0KPiBAQCAtMSw0ICsxLDQgQEANCj4g
LS8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBNSVQpDQo+ICsvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBPUiBNSVQNCj4gIC8qDQo+ICAgKiBDb3B5cmln
aHQgMjAxNi0yMDE4IFRvcmFkZXggQUcNCj4gICAqLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvdGVncmExMjQtYXBhbGlzLXYxLjIuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRz
L3RlZ3JhMTI0LWFwYWxpcy12MS4yLmR0c2kNCj4gaW5kZXggNTczYWFhNTBmZmYxLi41ZWY4NGI2
YjMzNTYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTI0LWFwYWxpcy12
MS4yLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmExMjQtYXBhbGlzLXYxLjIu
ZHRzaQ0KPiBAQCAtMSw0ICsxLDQgQEANCj4gLS8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMCBPUiBNSVQpDQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBP
UiBNSVQNCj4gIC8qDQo+ICAgKiBDb3B5cmlnaHQgMjAxNi0yMDE4IFRvcmFkZXggQUcNCj4gICAq
Lw0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DNjUxQzY3Ny1EMTU3LTQxQTMt
QjIwNi1DQjAyQjk4NkFEMTlAeg0KaXN3aWxlci5jb20v
