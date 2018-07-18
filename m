Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6D6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BC82075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="DL+6U2kf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BC82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbeGRVhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:37:13 -0400
Received: from mail-he1eur01on0101.outbound.protection.outlook.com ([104.47.0.101]:54115
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726999AbeGRVhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts3kwM9JlCjFygL1sRQQX+d6JtbXPOyjyqyySdMuL5I=;
 b=DL+6U2kfmBWbKntbOIegjZrxX9Gjk82abMaNb14llvDtYQ3k2vxKAznHdKfS43Ub+1+0e4CUQ9J1apK49K2m5oMNpt6RmGFfWDHpkdmzjOzeCnIKWssAtyZBN8ypvf+SHijd3fuNp6kMOrovkVF7fOg+oc3cuTo6YualhjwDoxA=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Wed, 18 Jul 2018 20:57:26 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.016; Wed, 18 Jul 2018
 20:57:26 +0000
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
Thread-Index: AQHUHtBmAeDWkbrdBkqi91HGS9NPuKSVdjkA
Date:   Wed, 18 Jul 2018 20:57:25 +0000
Message-ID: <1531947444.26473.11.camel@toradex.com>
References: <20180718194824.3704-1-krzk@kernel.org>
In-Reply-To: <20180718194824.3704-1-krzk@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2590;6:TIJ+YIxQzpWmd2TYokic/Z5lVTJnxnAUkTilw2ZjcelSKZCpQvRsCbXy8OZNBkXoiauC6fGVYitEpefPcdYRNjxf9SlmaqtJHfRzhcwac2uFsDYLu/MRFGqKUOX3Hh7cqnSbn3hXLqG4JyHtIe8mFbcukawZWlZTwV9ShzXYB+mvLGN8n3SdiPTW06jCfyCWJkJX4y4skyOGdjqTbjKdpU6I3vbyHeHstgmqN4sRzyrQNg6e0ElG1sbU5gIZ4Im6arvRBmob0Z9oZLrY7sn4PUE4xIZn97SJQIxeACZ41/t9nEZ3bAZ+p9DavCyjogRQJ2yrG+N+LsT3jk6QMsYn98SvPXVJr2SootERwy37P2ctFfQ0vCbpmIVCBPyICplAsbCtgrqZLxkqB/DazeTwyDq44Hj1EF/5+KZCmyosUw3KWYavtsNZoVkhU6ycouNfPa5BWT8nxRvwc08x4E1fDw==;5:eDlcM6R6b6EWhFktjVQ2rg1LMVKX62TnPotppXMEija1LJe2DmVkOBdwcNC6gGUMFPkr/wZO1wDasabvbuX0lhSSqF9XNWfb5TJhY+oW+Dq22YijwBq9Kmk5Zq76ZTzk9lQRDCahfOQQDoXmQrQiFdh7kjacwoMqAt4xYK3qrrY=;7:fWuNyeDKUMsr1TPTaP8hacnwC7nh9w98KNqtaav38+L0N/f6y6Ww7ugai9z1GWK1ys2TWhR84mwghv0QPbvQCVMCkuJ5bL+2lF5X5xNQ3swNomsQftoM3bw8ki3fg7pffqzj6H/kd2029y5oDY619uqVuAQp0fGNpt61WBG/KRTETqgc4PHsjGU/wSOMWuWYP3J3dBU/taQzScr8hMQgBqUYXibXX0hPA7fzvrTyi1uh39VIiYpxUVUWIXCcZBNw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1b942497-815b-41f3-c653-08d5ecf1111b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2590;
x-ms-traffictypediagnostic: VI1PR0501MB2590:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-microsoft-antispam-prvs: <VI1PR0501MB25902DBDA7B915AAEA156DBFFB530@VI1PR0501MB2590.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2590;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2590;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(396003)(366004)(136003)(346002)(189003)(199004)(6512007)(186003)(103116003)(44832011)(446003)(486006)(476003)(105586002)(106356001)(2616005)(6306002)(26005)(6116002)(3846002)(66066001)(53936002)(256004)(6506007)(102836004)(76176011)(2900100001)(6246003)(6436002)(6486002)(7416002)(7736002)(25786009)(2906002)(39060400002)(4326008)(8676002)(5660300001)(966005)(97736004)(14454004)(68736007)(305945005)(99286004)(11346002)(575784001)(81156014)(81166006)(86362001)(8936002)(36756003)(5250100002)(229853002)(478600001)(316002)(2501003)(110136005)(2201001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2590;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FjoEKzLs7b4HPGmORMSUYvfhclL9rOpreSi0RZhfpX/PtKDCuTSJxLUZbl/0/2NZyGL+lcPJOD6xjykH9kqV1QolQp7PlfkihLDQTvDaEvo9lcKL2JeW3ePKd7ErCTW4tZL+TyMF5cMiXXjKzjp1SEeT/NPNbyv1XQpfDd7lAd7A7AtG9jLCyJ24cqwmG1w1SqDqrVhoKdD5ye7erQI/XMTzNKRys6QlWYpntgmTtE6RBT/Byr3AqUyrwPCirihP9PLzMu3OS0/3uuOgt0wPUWJ1YluXYqd097gosW6WhgHuvW3qlNxeGafPm5VojSwAP1OsSe8JtSHtQPrPgIGNvgn1p3nehJHTWU42v+KSomw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <897915F2E0293B4BB1C12924997EC959@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b942497-815b-41f3-c653-08d5ecf1111b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 20:57:25.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2590
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA3LTE4IGF0IDIxOjQ4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBGaXggaW5jb3JyZWN0IGZvcm1hdCB1c2VkIGZvciBPUiBjbGF1c2UgaW4gU1BEWCBs
aWNlbnNlIGlkZW50aWZpZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEx
MjQtYXBhbGlzLXYxLjItZXZhbC5kdHMgfCAyICstDQo+ICBhcmNoL2FybS9ib290L2R0cy90ZWdy
YTEyNC1hcGFsaXMtdjEuMi5kdHNpICAgICB8IDIgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2Jvb3QvZHRzL3RlZ3JhMTI0LWFwYWxpcy12MS4yLWV2YWwuZHRzDQo+IGIvYXJjaC9hcm0vYm9v
dC9kdHMvdGVncmExMjQtYXBhbGlzLXYxLjItZXZhbC5kdHMNCj4gaW5kZXggOGE4ZDVmYTBlY2Qx
Li5lMmMwZDhlZmIzNTggMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTI0
LWFwYWxpcy12MS4yLWV2YWwuZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTI0
LWFwYWxpcy12MS4yLWV2YWwuZHRzDQo+IEBAIC0xLDQgKzEsNCBAQA0KPiAtLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIE1JVCkNCg0KQXQgbGVhc3QgdGhlIFNQRFggd2lr
aSBzdWdnZXN0cyBvdXIgZXhhY3QgdXNlZCBub3RhdGlvbiB3aXRoIGJyYWNrZXRzDQooT0ssIGxv
d2VyIGNhc2Ugb3IgYnV0IEkgZ3Vlc3MgdGhhdCBub3cgcmVhbGx5IGRvZXMgbm90IG1hdHRlciAo
Oy1wKS4NCg0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgT1IgTUlUDQo+
ICAvKg0KPiAgICogQ29weXJpZ2h0IDIwMTYtMjAxOCBUb3JhZGV4IEFHDQo+ICAgKi8NCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTI0LWFwYWxpcy12MS4yLmR0c2kNCj4g
Yi9hcmNoL2FybS9ib290L2R0cy90ZWdyYTEyNC1hcGFsaXMtdjEuMi5kdHNpDQo+IGluZGV4IDU3
M2FhYTUwZmZmMS4uNWVmODRiNmIzMzU2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0
cy90ZWdyYTEyNC1hcGFsaXMtdjEuMi5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3Rl
Z3JhMTI0LWFwYWxpcy12MS4yLmR0c2kNCj4gQEAgLTEsNCArMSw0IEBADQo+IC0vLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgTUlUKQ0KPiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAgT1IgTUlUDQo+ICAvKg0KPiAgICogQ29weXJpZ2h0IDIwMTYtMjAx
OCBUb3JhZGV4IEFHDQo+ICAgKi8NCg0KWzFdIGh0dHBzOi8vd2lraS5zcGR4Lm9yZy92aWV3L1NQ
RFhfRkFR
