Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA34C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F11E208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JO2xah/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F11E208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbeHWKYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:24:09 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:55153
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbeHWKYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq1gkjuf7DkZ5yh/pjLrUT3Ej4YA1Mj6vhAbeVF6Tao=;
 b=JO2xah/Es+AS+D3zLoxC5fOjDBkWXYggyqMWIkMBEhSIO1XzN4rsOXbyzbFrFp+pcdv3dayCNTpud/nwXhwfA1L2zPMV5FkaLTtLH0cwLBOPHf9XTLSajjM6Na3b7tjPL2T4cXRSxe2AqCnLKr6JN8J+16eZofgZ77QxWJyjs0s=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.71.159) by
 DB3PR0402MB3692.eurprd04.prod.outlook.com (52.134.70.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Thu, 23 Aug 2018 06:55:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::c0c1:51f1:411f:f13c]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::c0c1:51f1:411f:f13c%3]) with mapi id 15.20.1059.023; Thu, 23 Aug 2018
 06:55:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx6ull: correct machine model name
Thread-Topic: [PATCH] ARM: dts: imx6ull: correct machine model name
Thread-Index: AQHUOqt7Hsif6g0EuEqCRZ4HdtBZgqTM5oIAgAAATvA=
Date:   Thu, 23 Aug 2018 06:55:11 +0000
Message-ID: <DB3PR0402MB3916A1EF40BBFE0B52E8F059F5370@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1535005849-14046-1-git-send-email-Anson.Huang@nxp.com>
 <69b53468-ce73-9eeb-e11a-b6fa012a7ea6@i2se.com>
In-Reply-To: <69b53468-ce73-9eeb-e11a-b6fa012a7ea6@i2se.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3692;6:+JG7Xsuico1DfdmAawI34/RUQUvGRc3W22FvwTeRsdqEjHe44FvYOPiAWArRvgmszw1d+3SR8cCSHp8bLA09Yxcvhzj2/6rDrw7LughmPqO5VjCQl1yZ5HMMHDgWG/4bDi5NwyGGQUxqD9/fGAt6ferqFJkw6L+Aut8ZdFZhC605khacvKdET3+VrXYUHciQbJxxYLlp7vUILw/TPEq+K6Zk3BeSPuf9cgOF1DPx3+NK9SZtFbHL2oWLIn2zmYMI/L4ZF2wrDR41Pm/+gm8uclHJpbXV6YFg5KAmSiKZWECmNepH0/K6WiKb/LPTYaNwYQ6vYuqNtC/nbTVpmNwqRzTK20ZUiy/cMarmBsb64YgmBbcHxhRlvvzmaWZMMNqZX42fxbce2hB6bP9Qr0U1/Tf38nr3ROrH6SQwGAL3wrECDmH2MvKHCZ8+zFRhVpHF6jgEHzZFVOtXPX8dOQtwRg==;5:tZem8FPJQJ4/BVemhg1SgrN1CdyISJREGvlceeKqLlcg1CNuUGxyCkrNcXz5rKVMudciisTW6NDg4uX95K8+TARbMx6nUffOh//qC+CdXPx9U3AVbBUggCdLnlWnaKn71/VVY+R2VsO/tpbeaM+WpYM54BGWHOJqo49QN9ipK14=;7:uvTEKWnWQuIhWQtIXIZ2xcFPxvNm70OpsdrMxIObrIEdAdkexsvu0KJ3BZMS1EbdnkiN6p4J4jLC3cYdbq9VmZK8qqPagyr8LDn/qET4cm0UJdF3blDKxQTKLJWTvoXPpTkEeyVLEOoY2LmYCRXSTD22xvpof/t1Wno+dZECzBJmPwp/NM0wegNp42aAFp4rq0UePLZbQPJL1NY88v5QaF+zxUQPBg6c5n18a94sl5SdZtj06Ze2c6Q+u1KHYt5E
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: df0ab4f5-1afa-4f08-a9f8-08d608c55efe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3692;
x-ms-traffictypediagnostic: DB3PR0402MB3692:
x-microsoft-antispam-prvs: <DB3PR0402MB36926CA2CDAB0CE94D2C8EF8F5370@DB3PR0402MB3692.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:DB3PR0402MB3692;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3692;
x-forefront-prvs: 0773BB46AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(13464003)(199004)(189003)(14454004)(102836004)(6436002)(55016002)(53936002)(2900100001)(9686003)(68736007)(229853002)(26005)(106356001)(76176011)(44832011)(5660300001)(74316002)(53546011)(305945005)(7736002)(186003)(2501003)(5250100002)(6506007)(7696005)(33656002)(446003)(2906002)(8936002)(11346002)(14444005)(6246003)(478600001)(256004)(66066001)(3846002)(6116002)(110136005)(81156014)(81166006)(25786009)(4326008)(476003)(486006)(86362001)(316002)(2201001)(97736004)(8676002)(99286004)(105586002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3692;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K1Uw1J2AL517rLWyu1fPvn7km8Sm7ApXJKzWYcSSVV6UZGN9rvyAjXMq7qt5AA4mLq4yKkL6AmuWQwwSBcqnGjNMFv2MMZp3RcghWBS3+sD8LfaILYhTL8twLZdzdPdKSe1XSMyEfnjm31+P8KgpU7qsn9RIX4iyO7oFhsfWWC4VyTUK4QP1PRCfC6UYv9FjtdgStyv7Z99Kns2iUKrdqostIU6Oipefe+W8eOBefNwW7O6T7lgHQwPMVnsZdIO5m5zoznfiMwxySD0PuDqVpOjE+hORGTr3cWlN8//1rwZDUu/pUBOW5mbHaM8WwV7FrLeji8wO8sEim73QG/6roQJrWG0ZGrSTaNUETljfSeY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0ab4f5-1afa-4f08-a9f8-08d608c55efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2018 06:55:11.3140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZWZhbg0KDQpBbnNvbiBIdWFuZw0KQmVzdCBSZWdhcmRzIQ0KDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlZmFuIFdhaHJlbiA8c3RlZmFuLndhaHJlbkBp
MnNlLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMywgMjAxOCAyOjUzIFBNDQo+IFRv
OiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7
DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgRmFiaW8g
RXN0ZXZhbQ0KPiA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOyBt
YXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDZ1bGw6IGNvcnJlY3QgbWFjaGluZSBtb2RlbCBu
YW1lDQo+IA0KPiBIaSBBbnNvbiwNCj4gDQo+IA0KPiBBbSAyMy4wOC4yMDE4IHVtIDA4OjMwIHNj
aHJpZWIgQW5zb24gSHVhbmc6DQo+ID4gaS5NWDZVTEwgaXMgYSBsaXRlIHZlcnNpb24gb2YgaS5N
WDZVTCwgaXRzIGZ1bGwgbmFtZSBpcyBpLk1YNg0KPiA+IFVsdHJhTGl0ZUxpdGUsIE5PVCBVbGx0
cmFMaXRlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtMTR4MTQt
ZXZrLmR0cyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVs
bC0xNHgxNC1ldmsuZHRzDQo+ID4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLTE0eDE0LWV2
ay5kdHMNCj4gPiBpbmRleCAzMGVmNjAzLi4wYmE2NDU0IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDZ1bGwtMTR4MTQtZXZrLmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDZ1bGwtMTR4MTQtZXZrLmR0cw0KPiA+IEBAIC00NSw3ICs0NSw3IEBADQo+ID4g
ICNpbmNsdWRlICJpbXg2dWwtMTR4MTQtZXZrLmR0c2kiDQo+ID4NCj4gPiAgLyB7DQo+ID4gLQlt
b2RlbCA9ICJGcmVlc2NhbGUgaS5NWDYgVWxsdHJhTGl0ZSAxNHgxNCBFVksgQm9hcmQiOw0KPiA+
ICsJbW9kZWwgPSAiRnJlZXNjYWxlIGkuTVg2IFVsdHJhTGl0ZUxpdGUgMTR4MTQgRVZLIEJvYXJk
IjsNCj4gPiAgCWNvbXBhdGlibGUgPSAiZnNsLGlteDZ1bGwtMTR4MTQtZXZrIiwgImZzbCxpbXg2
dWxsIjsgIH07DQo+ID4NCj4gDQo+IGxvb2tzIGdvb2QsIGJ1dCB0aGlzIGNvbXBhdGlibGUgc2hv
dWxkIGJlIGRvY3VtZW50ZWQgaW4NCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9mc2wudHh0IChzaG91bGQgYmUgYSBzZXBhcmF0ZSBwYXRjaCkuDQoNClRoYW5rcyBmb3Ig
cmVtaW5kZXIsIEkgd2lsbCB1cGRhdGUgdGhlIGRvY3VtZW50YXRpb24gYXMgd2VsbCBpbiBWMiBw
YXRjaC4gQW5kIGxvb2tzDQpsaWtlIHdlIG1pc3NlZCBtYW55IGkuTVg2IHBsYXRmb3JtcyB0aGVy
ZSwgSSB3aWxsIHVwZGF0ZSB0aGVtIGluIHNlcGFyYXRlIHBhdGNoIGFzIHdlbGwuDQoNCkFuc29u
Lg0KDQo+IA0KPiBSZWdhcmRzDQo+IFN0ZWZhbg0KDQo=
