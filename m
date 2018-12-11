Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F334EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A9A20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O0Z+gYgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A9A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeLKBkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:40:40 -0500
Received: from mail-eopbgr50065.outbound.protection.outlook.com ([40.107.5.65]:39712
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727895AbeLKBkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmct3vyjYNcRoasNzR6RwYVF7xzJ41BTwOkFtItCU14=;
 b=O0Z+gYgd0I5DCoYCZ8e8y8KHDM/O7kjgqpkGcSaehuLsJJyh5YKcKPk5t7izGt6qZyEbJkpXbFuPPNnyi49l7aAQx7I3OUozUP7N0gOA97Fjmy+E4o0pxAcoGPpwWUEsCN7k0JgT3ULhPd/nFnUeZTiWt+uS5secAZYOorXEHEA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3915.eurprd04.prod.outlook.com (52.134.71.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 01:38:53 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 01:38:53 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/2] dt-bindings: iio: light: isl29018: update power
 supply name
Thread-Topic: [PATCH V3 1/2] dt-bindings: iio: light: isl29018: update power
 supply name
Thread-Index: AQHUkFeMq54w2saSI0m5D7dfdmdMWaV4nioAgAAlXHA=
Date:   Tue, 11 Dec 2018 01:38:53 +0000
Message-ID: <DB3PR0402MB3916E1651ABC07F6F788B265F5A60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1544425521-775-1-git-send-email-Anson.Huang@nxp.com>
 <20181210232358.GA11621@bogus>
In-Reply-To: <20181210232358.GA11621@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3915;6:cvSCxDhZzBgnGHwAj20w6J1piyRXirxL4q/ufluzuq++dG0/TlhNTvd/oB61AfSxGw7vduqSox0I/gquthG8Li2my4wMzWmBKanV3tgtUGzxyhAWadrxDxNS2zEhKwaB2tq04Mtufx4z2fJAYQ9QrJSDn5HYTXz9udUilbxOccclGHaXtBX92yA7ATDSYufF3pbBovLpiutgobWliiJuMTHVOKuG+8jd7OppcA9aNvoD+c2MK4WBQChU/UkSFy6iynMVJh4nz472n2cis119q4VEcjNdo8iGw3HOzR8csxcGfC48zXNHhvpaaJ0XmQZjpmxty4y1KHG5sNM61VY2l4JX5b7vjX/PPWl6nhVcQyjJUjYqq6xMxgUHVGZrb2MWrnER7z7g732PasJUnSONZXnBKAmAX/4eHcb9lSGeOSk/hC/qNSy5dGPgsMgxJHIu8mIcPkutDxuUvf1eNumfBA==;5:AmbX+pxje/jfxzYLs8YxPcR5Hzr4pHs9JI0q++T4nRu+Hz5HYr6meeC1g3e+TpzaxjrIj766+gj/B73G2CZefMsgxDSahkjC3GaBbTV5A0PZbK2tOWlT1DpQJF1aoxJtYAZe70td5XnxvODtPHh6jCzUAYIIy6c/zfTNnvEdiLM=;7:OyQ9gk9tgaz+bfKLF5alWTugKMxi9lTSOabsRZKWwUogi6K8P9X7PQz5Kz0kuCviKUKYtdc1vLruni8tT/s2tHvSeC0c4ylxjp9iL1SDdQkNkofn3neULdh3CYnCBqiMoZU1rnRjz77M3RTKCjma4A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 90454599-14d3-4eaf-efdd-08d65f0968f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3915;
x-ms-traffictypediagnostic: DB3PR0402MB3915:
x-microsoft-antispam-prvs: <DB3PR0402MB391546DD47DCFC706E0C6F4FF5A60@DB3PR0402MB3915.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3915;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3915;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(13464003)(54906003)(9686003)(11346002)(105586002)(229853002)(102836004)(33656002)(14444005)(66066001)(7736002)(305945005)(2906002)(106356001)(99286004)(446003)(68736007)(476003)(3846002)(6116002)(5660300001)(15650500001)(256004)(7696005)(74316002)(486006)(6436002)(6916009)(25786009)(44832011)(478600001)(86362001)(316002)(14454004)(6246003)(81156014)(97736004)(6506007)(8676002)(8936002)(71190400001)(26005)(81166006)(55016002)(76176011)(186003)(53936002)(71200400001)(53546011)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3915;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TTwrPWIIBi68VY6YXXUEW/+HXsqZjPKMQydVkLj42EN2x8wv074EWQK5jH2QpZq9uPfBOTusl3ZxB6yIWqpXN4hgkfk/BRLAj81tT4fAI5Kz249zOrTRoNJe6puACFGGQhMCWAZ0Lnti4ELuaz7p7/E9NCrQo/RM5hStHGOfQ+59WrezYD4Onttsn+A6MrUe5I2p64pwZrh7lyXmhPyYD7HdxyDbG3RvajioR6kq9cdAEAN5pYR4gRc/j8re4mydbodZt2O6eM0j4c0fIbuHslfq8jIaaXGxJUN7bOFvnZBB3dA5EnTRpUj+S0oJphjc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90454599-14d3-4eaf-efdd-08d65f0968f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 01:38:53.8809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIFttYWlsdG86cm9iaEBrZXJuZWwub3Jn
XQ0KPiBTZW50OiAyMDE4xOoxMtTCMTHI1SA3OjI0DQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24u
aHVhbmdAbnhwLmNvbT4NCj4gQ2M6IGppYzIzQGtlcm5lbC5vcmc7IGtuYWFjay5oQGdteC5kZTsg
bGFyc0BtZXRhZm9vLmRlOw0KPiBwbWVlcndAcG1lZXJ3Lm5ldDsgbWFyay5ydXRsYW5kQGFybS5j
b207IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDEvMl0gZHQtYmluZGluZ3M6
IGlpbzogbGlnaHQ6IGlzbDI5MDE4OiB1cGRhdGUgcG93ZXINCj4gc3VwcGx5IG5hbWUNCj4gDQo+
IE9uIE1vbiwgRGVjIDEwLCAyMDE4IGF0IDA3OjExOjE5QU0gKzAwMDAsIEFuc29uIEh1YW5nIHdy
b3RlOg0KPiA+IEFjY29yZGluZyB0byBkYXRhc2hlZXQsIHRoZSBpc2wyOTAxOCBoYXMgInZkZGQv
dmRkYSIgcG93ZXIgc3VwcGx5LCBhbmQNCj4gPiBpc2wyOTAyMy9pc2wyOTAzNSBPTkxZIGhhcyAi
dmRkIiBwb3dlciBzdXBwbHksIHVwZGF0ZSB0aGUgcG93ZXIgc3VwcGx5DQo+ID4gbmFtZSB3aXRo
ICJ2ZGQiIGFuZCAidmRkYSIgYWNjb3JkaW5nIHRvIGRhdGFzaGVldCB0byBjb3ZlciBhbGwgZGV2
aWNlcw0KPiA+IGFuZCBhdm9pZCBjb25mdXNpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBB
bnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9saWdodC9pc2wyOTAxOC50eHQgfCA0ICsrKy0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8v
bGlnaHQvaXNsMjkwMTgudHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaWlvL2xpZ2h0L2lzbDI5MDE4LnR4dA0KPiA+IGluZGV4IGI5YmJkZTMuLjM2ZjczN2QgMTAw
NjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9saWdo
dC9pc2wyOTAxOC50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaWlvL2xpZ2h0L2lzbDI5MDE4LnR4dA0KPiA+IEBAIC0xNSw3ICsxNSw5IEBAIE9wdGlvbmFs
IHByb3BlcnRpZXM6DQo+ID4gICAgUmVmZXIgdG8gaW50ZXJydXB0LWNvbnRyb2xsZXIvaW50ZXJy
dXB0cy50eHQgZm9yIGdlbmVyaWMgaW50ZXJydXB0IGNsaWVudA0KPiA+ICAgIG5vZGUgYmluZGlu
Z3MuDQo+ID4NCj4gPiAtICAtIHZjYy1zdXBwbHk6IHBoYW5kbGUgdG8gdGhlIHJlZ3VsYXRvciB0
aGF0IHByb3ZpZGVzIHBvd2VyIHRvIHRoZSBzZW5zb3IuDQo+ID4gKyAgLSB2ZGQtc3VwcGx5OiBw
aGFuZGxlIHRvIHRoZSByZWd1bGF0b3IgdGhhdCBwcm92aWRlcyB2ZGQgcG93ZXIgdG8gdGhlDQo+
IHNlbnNvci4NCj4gPiArDQo+ID4gKyAgLSB2ZGRhLXN1cHBseTogcGhhbmRsZSB0byB0aGUgcmVn
dWxhdG9yIHRoYXQgcHJvdmlkZXMgdmRkYSBwb3dlciB0byB0aGUNCj4gc2Vuc29yLg0KPiANCj4g
SXMgdGhpcyBpbiB1c2U/IFlvdSBjYW4ndCBqdXN0IGNoYW5nZSB0aGluZ3MgaWYgaXQgaXMuDQoN
CkkgZGlkIE5PVCBzZWUgYW55ICJ2Y2MiIGluIGZvbGRlciBkcml2ZXJzL2lpby9saWdodC8sIHNv
IEkgdGhpbmsgaXQgaXMgTk9UIHVzZWQgYXQgYWxsLA0Kc28gSSB0YWtlIHRoaXMgY2hhbmNlIHRv
IHVwZGF0ZSBpdCBhY2NvcmRpbmcgdG8gZGF0YXNoZWV0LiBUaGFua3MuDQoNCkFuc29uDQoNCg0K
PiANCj4gUm9iDQo=
