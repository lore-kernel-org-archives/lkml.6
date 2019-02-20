Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F22C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D8620880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nwzwTuSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfBTNpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:45:15 -0500
Received: from mail-eopbgr40044.outbound.protection.outlook.com ([40.107.4.44]:53248
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbfBTNpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOD5VjR6LGptJXHMiriHDibn8S7wClm29BQhTSGWwDI=;
 b=nwzwTuSrPYBL6fI8PnXjuaeZFfGrwuDnu1UrkxvrjGnPvS7I8HYNVjEhc4kVhxKcnMiFs3k+ZINKg9ZwwaQtfJ2B1GPXVJmz7qtFXn2Po4uncy3nzozTqn8NM3vJHviKZkz1OlsQL1pKSGB+u2D8JedY221PlT9MJSoMu4G/cZo=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB6102.eurprd04.prod.outlook.com (20.179.5.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 13:44:53 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 13:44:53 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>
CC:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Topic: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Index: AQHUyDGr6JcuNwk39kK74/kE/Vm176XnE3iAgAAGyxCAABmaAIAABhpAgADPbuCAAE95AIAAFTeQgAAWXoCAAAIvkIAAE7mAgAAZdrA=
Date:   Wed, 20 Feb 2019 13:44:53 +0000
Message-ID: <AM6PR04MB42154C73B66A9F7E99597274807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1550566601-11497-1-git-send-email-Anson.Huang@nxp.com>
         <20190219125211.2pg2bqxner4klcb5@pengutronix.de>
         <DB3PR0402MB3916AF3AA0283DB22DF61E2FF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
         <20190219144808.qqpaubjcsb4huoml@pengutronix.de>
         <DB3PR0402MB39160A56E168ED20410674D7F57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
         <AM6PR04MB42152D05E62753E760741160807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
         <20190220081650.cu3yzausx55jefb6@pengutronix.de>
         <AM6PR04MB4215014B734F71D409D617A5807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
         <20190220105249.u2hcvk6ut3cycvqs@pengutronix.de>
         <AM6PR04MB4215D9FE015E9251425B0FFC807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <a55e0643bb2acd522145c74ec0e8b74a16b718f8.camel@pengutronix.de>
In-Reply-To: <a55e0643bb2acd522145c74ec0e8b74a16b718f8.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44767822-1e52-49d4-c373-08d697399806
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6102;
x-ms-traffictypediagnostic: AM6PR04MB6102:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI2MTAyOzIzOmtoZTQ2bHRyVHErODhNc2FZNFpWbGcvekNI?=
 =?utf-8?B?R0pvQjFZNWF4K3dCcmFkZDBUcWNYOCtLaEhTODhzcC9KTFRDSDROd2pVYk1s?=
 =?utf-8?B?MUxoZU4rcVFpMnlNQ3o2L0RVQVdEem9hbnNBVStxTFhwNHFkVWkyU2UvcnpL?=
 =?utf-8?B?RGlyOHhxempDU2gzTEZpcTB3cHl4UXA2RDZka1I0RGFBSGJNVDhMNUhMRmRL?=
 =?utf-8?B?MTQrRktPZGxuK2xibVUzZWNmVGxxdlkrSEtPZHlmc0xVbDZVK1U0VU1vNHJh?=
 =?utf-8?B?RXhDQncvalpvVHNRYzA1NCs0eThaRmt4MVhTOWZQVGg4VnNhaEdiMkM5Wkpw?=
 =?utf-8?B?aU92VmNMOGRwQlpxQUtIUjdDdENMdHZNMjlkL1J0ZTB4aE93R1hMRHFSbkdo?=
 =?utf-8?B?YlNURmkwVDBFOTloQUpQUmw2eHBXQTdKTmRKakthQnMxSk4wWXNjU3ZyZWIr?=
 =?utf-8?B?eTBYMFQzeTQ2WXBmT3ROTHBHU3ZNc3pMankrTkh5NUNJeGJqZmNXN1puSmQ1?=
 =?utf-8?B?SjVLSnhPMFhSWGRjSVlnUkh3NnoyTFplbEtqbHA3SHJPdytoMTAwSG04emU0?=
 =?utf-8?B?Q2Q5NDJuYjc0Y25lUmtNZUVQaERHa0dLekNsTWVMdXNMbUgzc1dGZ1ozYXRG?=
 =?utf-8?B?TE5Tdzd5YTZUemsxUFNuU0RRTVR3cVNJZUJnZFdwazJoS1AzaTBIMEJNY0FE?=
 =?utf-8?B?WXZkRXR5NVUxOFcvMkdSQlFkbzdQd1IrbjVHVU5zTm9sSi9BSFZCdUhPMjRa?=
 =?utf-8?B?VEJCek9jWWdvdlRBVFpvRHlTQ2IyL1ZhZndHT25Zd0t4blVoUWJZZWxaNWZK?=
 =?utf-8?B?R1FGM1FESE45Q1pFVVpqZzlFd1hzWC9LSlhpY2lwd3VHRGtpKzF1VDEzQzJT?=
 =?utf-8?B?RGZudHlTZU5qa0JRdVkzWDVwY0ZQemYySzhOZHV3ZEk3UHhUM2JZck43SDk2?=
 =?utf-8?B?OUlzKzgvejNzRHNBeWxtekJNT0NMR2dSVG9nTXRuTlFNM0xGblFpMkpDNkpD?=
 =?utf-8?B?dllUeW5vRlU3WlNBMUlxWlo4Vmh5ekJXRlRkaEtrQzFId3FUWlUrNkQwTXpz?=
 =?utf-8?B?T3M1OVBTZGhhYkp5NldwN2Jya1BaNFdqQ3Z6azY3Z25ybHpjVldFS2dBOHVS?=
 =?utf-8?B?cGdNeXFWajNkKzZTa3dBYkZlNEtyeEVJdFp0M2VvenVBSFlXcXB0MWsxemha?=
 =?utf-8?B?dUpzb2Q0WnlNWnloaG5XSkkrTXpXU3I0Y3k5cWx4ckNEbWVSemV5YzVFem9n?=
 =?utf-8?B?U2tWdkQ1ZXduSURhMFY4S2hQY0RXcy9yOGNIK203Q3NnczRlK3laNUw5U3Y0?=
 =?utf-8?B?bU1UOE5WcU1ZS1g3NFVjbnF5azIyYlROMkhVWUxyNG1WMGU4bXRyVHh4L3JK?=
 =?utf-8?B?SzdvdklrRDRjQnNHdEpiWEg1Z3ZuTEZPSWY3elFBZ2MrYTZRTXR4OFkzVG03?=
 =?utf-8?B?N3ZKM0MwbW5YdUlSdi82RU5qeXp6NHRNWWN0U1VITnN6UHA3SmVLL2gxazhh?=
 =?utf-8?B?QnRtc3ZVcHNGbyttdWU3cFBwV01ySUwxNTdySGNvRlpJbmswWGFYUTI4ZXU2?=
 =?utf-8?B?WEdGOWx0UTYxSUFybU5CQmNRaGRCQzJCVDhDUEhZTDUraXFyQjJtbGdXeldQ?=
 =?utf-8?B?aTVVSmtJN2hnTXBSSkRtcTFGMWNjdnhUNE5nZncvNnVZbnVCcVl0Sm4wSEpj?=
 =?utf-8?B?TXVFYlEwUVJYNGdkVlN0Tmp3YkxpR2RLd0VDc2JPTDJKeFR1TjR3bUh6TnEw?=
 =?utf-8?B?WGxiY3dGMUZXMDA5OUs1M0VxQ05pelBJZHY1T1AyQ082ajVuZnZXalBlMmFu?=
 =?utf-8?B?c1ZweU16RGNGM3MyVlFIYnQ0RHlVWjJzR2xYYktHWERVOVRPU1luZDZ2WUd5?=
 =?utf-8?Q?uDWoF54DJU4=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB61022847E3FAE04BB027ACB1807D0@AM6PR04MB6102.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(39860400002)(376002)(189003)(52314003)(199004)(51914003)(11346002)(68736007)(229853002)(446003)(14444005)(256004)(476003)(25786009)(106356001)(81166006)(81156014)(8936002)(486006)(7736002)(74316002)(8676002)(93886005)(6246003)(478600001)(305945005)(44832011)(105586002)(4326008)(53936002)(14454004)(33656002)(97736004)(86362001)(102836004)(9686003)(7416002)(7696005)(26005)(76176011)(6436002)(66066001)(15650500001)(55016002)(2906002)(99286004)(3846002)(6116002)(71200400001)(71190400001)(316002)(5660300002)(54906003)(110136005)(186003)(6506007)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6102;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pjOUPnnkk/a55dHLl638zn5OpH28ykqxDNdxgV8WZet4lLefyv4/tHov6NHw82ZTstjbrvEQXmFK4ikDmeEuq5JaBECj8L3evDpk5o45nOnD5A8cs2vnfgjyXpqOzT4ZNaAJMWrWiBt3xownnqilDA0EyYGqizDSE9ZvXhzMATHrbCyQK8eOKAwNNRZjqzGYiX3ZSdwQH1TDvWeFxxlRE0cLEFgmvbaPt7nn0EGGVj2y45ikSGRYXQXrsOox3YZat1Zh1jCCCWWQ2wNI54ja+vC1FRzDF+9vMRhNJegm71XmHF3gs8aA8GXVagXGpFBQ/mnubQZYeUTmUd5Lj1gZka0JQdfAL3iSvg9hPUt7Ezhlq+UkyQpbKls0Fia6UqorJFUWtphO36cQFXwSP/Drlj/uLjk5AsUjVQc57jo62gs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44767822-1e52-49d4-c373-08d697399806
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 13:44:53.7953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdWNhcyBTdGFjaCBbbWFpbHRvOmwuc3RhY2hAcGVuZ3V0cm9uaXguZGVdDQo+IFNl
bnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjAsIDIwMTkgODoxMSBQTQ0KPiANCj4gQW0gTWl0dHdv
Y2gsIGRlbiAyMC4wMi4yMDE5LCAxMToyMSArMDAwMCBzY2hyaWViIEFpc2hlbmcgRG9uZzoNCj4g
PiBIaSBNYXJjbywNCj4gPg0KPiA+ID4gRnJvbTogTWFyY28gRmVsc2NoIFttYWlsdG86bS5mZWxz
Y2hAcGVuZ3V0cm9uaXguZGVdDQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDIwLCAy
MDE5IDY6NTMgUE0NCj4gPiA+DQo+ID4gPiBIaSBBaXNoZW5nLA0KPiA+ID4NCj4gPiA+IE9uIDE5
LTAyLTIwIDA5OjQ5LCBBaXNoZW5nIERvbmcgd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogTWFyY28g
RmVsc2NoIFttYWlsdG86bS5mZWxzY2hAcGVuZ3V0cm9uaXguZGVdDQo+ID4gPiA+ID4gU2VudDog
V2VkbmVzZGF5LCBGZWJydWFyeSAyMCwgMjAxOSA0OjE3IFBNIE9uIDE5LTAyLTIwIDAzOjM4LA0K
PiA+ID4gPiA+IEFpc2hlbmcgRG9uZyB3cm90ZToNCj4gPiA+ID4gPiA+IFsuLi5dDQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEkgZG9uJ3QgbGlrZSBkcm9waW5nIHNvbWUgSUQncyAoZS5n
Lg0KPiA+ID4gPiA+ID4gPiA+IElNWF9TQ19SX0RDXzBfQ0FQVFVSRTApIGJ5IG1hcmsgdGhlbSBh
cyB1bnVzZWQgb3IgZXZlbg0KPiA+ID4gPiA+ID4gPiA+IHdvcnNlIGdpdmUgdGhlbSBhIG90aGVy
IG1lYW5pbmcuIElNSE8gdGhlIHNjdS1hcGkgc2hvdWxkDQo+ID4gPiA+ID4gPiA+ID4gYmUgc3Rh
YmxlIHNpbmNlIGRheSAxIGFuZCB0aGUgSUQncyBzaG91bGQgb25seSBiZQ0KPiA+ID4gPiA+IGV4
dGVuZGVkLg0KPiA+ID4gPiA+ID4gPiA+IE1hcmtpbmcgSUQncyBhcyBkZXByZWNhdGVkIGlzIG11
Y2ggYmV0dGVyIHRoYW4gbW92aW5nIHRoZW0NCj4gYXJvdW5kLg0KPiA+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPiBJIGFncmVlIHRoZSBTQ1UgQVBJcyBzaG91bGQgYmUgc3RhYmxlIHNpbmNlIGRh
eSAxIGFuZCB0aGUgSUQNCj4gPiA+ID4gPiA+ID4gc2hvdWxkIE9OTFkgYmUgZXh0ZW5kZWQsIGJ1
dCB0aGF0IGlzIHRoZSBiZXN0IGNhc2VzLCB0aGUNCj4gPiA+ID4gPiA+ID4gcmVhbGl0eSBpcywg
dGhlcmUgYXJlIGRpZmZlcmVudCBTb0NzL1JldmlzaW9uLCBzb21lDQo+ID4gPiA+ID4gPiA+IHJl
dmlzaW9ucyBtYXkgcmVtb3ZlIHRoZSByZXNvdXJjZXMgSUQgZGVmaW5lZCBpbiBwcmUtY29kZWQN
Cj4gPiA+ID4gPiA+ID4gU0NVIGZpcm13YXJlLCBsaWtlIHRoZQ0KPiA+ID4gPiA+ID4gPiBJTVhf
U0NfUl9EQ18wX0NBUFRVUkUwIGV0Yy4sIHNvIFNDVSBBUElzIHJlbW92ZXMgdGhlbSBhZnRlcg0K
PiA+ID4gPiA+ID4gPiByZWFsIHNpbGljb24gYXJyaXZlZCwgbm93IGxhdGVzdCBTQ1UgZmlybXdh
cmUgbWFya3MgdGhlbSBhcw0KPiA+ID4gPiA+ID4gPiBVTlVTRUQsIHRoZXkgY291bGQgYmUgcmVw
bGFjZWQgYnkgc29tZSBvdGhlciBuZXcgcmVzb3VyY2VzDQo+ID4gPiA+ID4gPiA+IGluIGxhdGVy
IG5ldyBTb0MsIEkgYW0gTk9UIHN1cmUsIGJ1dCBpZiBpdCBoYXBwZW5zLCB0aGlzDQo+ID4gPiA+
ID4gPiA+IHJlc291cmNlIElEIHRhYmxlIHNob3VsZCBiZSB1cGRhdGVkIGFueXdheSwgbGVhdmlu
ZyB0aGUNCj4gPiA+ID4gPiA+ID4gb3V0LW9mLWRhdGUgcmVzb3VyY2UgSUQgdGFibGUgdGhlcmUg
d2lsbCBoYXZlDQo+ID4gPiA+ID4gaXNzdWVzLCBzaW5jZSBpdCBpcyBOT1Qgc3luYyB3aXRoIFND
VSBmaXJtd2FyZS4NCj4gPiA+ID4gPiA+ID4gU28gaG93IHRvIHJlc29sdmUgc3VjaCBpc3N1ZT8g
V2UgaG9wZSB0aGUgU0NVIGZpcm13YXJlDQo+ID4gPiA+ID4gPiA+IHNob3VsZCBiZSBzdGFibGUg
c2luY2UgZGF5IDEsIGJ1dCB0aGUgdHJ1dGggaXMgTk9ULCBjb3VsZCBiZQ0KPiA+ID4gPiA+ID4g
PiBzdGlsbCBzb21lIHVwZGF0ZXMgYnV0IE5PVCB2ZXJ5IG9mdGVuLiBBbmQgSSBiZWxpZXZlIHRo
ZQ0KPiA+ID4gPiA+ID4gPiB1cGRhdGVzIHdpbGwgTk9UIGJyZWFrIG9sZA0KPiA+ID4gPiA+IGtl
cm5lbCB2ZXJzaW9uLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSGkgQW5zb24sDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBQbGVhc2UgZG9uJ3QgbWl4IHRoZSBkdC1iaW5kaW5ncyBhbmQgdGhlIGtlcm5l
bCByZWxhdGVkIHN0dWZmLg0KPiA+ID4gPiA+IFVuZm9ydHVuYXRlbHkgdGhlIGJpbmRpbmdzIGFy
ZSB3aXRoaW4gdGhlIGtlcm5lbCByZXBvIHdoaWNoIGluDQo+ID4gPiA+ID4gZmFjdCBpcyBncmVh
dCBmb3IgdXMga2VybmVsIGRldmVsb3BlciBidXQgdGhlIGJpbmRpbmdzIGFyZSBhbHNvDQo+ID4g
PiA+ID4gdXNlZCBpbiBvdGhlciBwcm9qZWN0cyBzdWNoIGFzIGJhcmVib3ggb3Igb3RoZXIga2Vy
bmVscyAoZG9uJ3QNCj4gPiA+ID4gPiBrbm93IHRoZSBCU0QgZ3V5cykuIFNvIHlvdSBjYW4ndCBl
bnN1cmUgdGhhdCB5b3VyIGNoYW5nZSB3aWxsDQo+ID4gPiA+ID4gYnJlYWsgc29tZXRoaW5nLiBQ
bGVhc2UNCj4gPiA+IGtlZXAgdGhhdCBpbiBtaW5kLg0KPiA+ID4gPiA+IElNSE8gc29sdmluZyB0
aGF0IGlzc3VlIHNob3VsZCBiZSBkb25lIGJ5IHRoZSBzY3UgZmlybXdhcmUuIEkNCj4gPiA+ID4g
PiB0b3VnaHQgdGhlIHNjdSBpcyBhIGNvcnRleC1tNCB3aXRoIGEgYnVuY2ggb2YgZW1iZWRkZWQg
Zmxhc2ggYW5kDQo+ID4gPiA+ID4gcmFtIChJIGRvbid0IGtub3cgdGhhdCBtdWNoIGFib3V0IHRo
ZSBzY3Ugc2luY2UgaXQgaXMNCj4gY2xvc2VkL2JsYWNrLWJveGVkKS4NCj4gPiA+ID4gPiBXaHkg
ZG8geW91IGRvbid0IHVzZSBhIHRyYW5zbGF0aW9uIHRhYmxlIHdpdGhpbiB0aGUgc2N1PyBBcyBJ
DQo+ID4gPiA+ID4gc2FpZCBlYXJsaWVyIEkgZG9uJ3QgbGlrZSB0aGUgcmVkZWZpbml0aW9uIG9m
IElEJ3Mgc2luY2UgdGhleQ0KPiA+ID4gPiA+IGFyZSBub3cgcGFydCBvZiB0aGUNCj4gPiA+IGR0
LWJpbmRpbmdzLg0KPiA+ID4gPiA+IFRoZSBiaW5kaW5ncyBjYW4gc3RvcmUgdXAgdG8gMzJiaXQg
dmFsdWVzIHdoaWNoIGlzIGEgbGFyZ2UNCj4gPiA+ID4gPiBudW1iZXIgOykgSU1ITyB3YXN0aW5n
IHNvbWUgSUQncyBpbiBmYXZvdXIgb2Ygc3RhYmlsaXR5IGlzIGEgYmV0dGVyDQo+IHNvbHV0aW9u
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEFzIGZhciBhcyBJIGtub3csIHRob3NlIHJl
bW92ZSByZXNvdXJjZSBJRHMgYXJlIHByZS1kZWZpbmVkIGFuZA0KPiA+ID4gPiBoYXMgbmV2ZXIg
YmVlbiB1c2VkIGFuZCB3b24ndCBiZSB1c2VkIGFueW1vcmUgYnkgU0MgZmlybXdhcmUuDQo+ID4g
PiA+IChBbnNvbiBjYW4gZG91YmxlIGNoZWNrIGl0KSBTbyBJIHRoaW5rIGl0J3Mgc2FmZSB0byBy
ZW1vdmUgdGhlbSBvcg0KPiA+ID4gPiBtYXJrIHRoZW0gYXMNCj4gPiA+IGRlcHJlY2F0ZWQuDQo+
ID4gPg0KPiA+ID4gSSB0aGluayBtYXJraW5nIHRoZW0gYXMgZGVwcmVjYXRlZCBieSBhIGNvbW1l
bnRhciBpcyBiZXR0ZXIgdGhhbg0KPiA+ID4gcmVkZWZpbmluZyBiaXRzIHRvIGJlIHVudXNlZC4g
QXMgSSBzYWlkIHRoZSBiaW5kaW5ncyBub3Qgb25seSBsaW51eA0KPiA+ID4gcmVsYXRlZCB0aGV5
IGFyZSB1c2VkIGluIG90aGVyIHByb2plY3RzIHRvby4NCj4gPiA+DQo+ID4NCj4gPiBGb3Igb3Ro
ZXIgcHJvamVjdHMsIHRoZSByZXN1bHQgaXMgc2FtZSBiZWNhdXNlIFNDIGZpcm13YXJlIGRvZXMg
bm90DQo+ID4gc3VwcG9ydCB0aG9zZSBSZXNvdXJjZSBJRHMuDQo+ID4NCj4gPiA+ID4gUGVyc29u
YWxseSBJIG1heSBwcmVmZXIgdG8gcmVtb3ZlIHRoZW0gYXMgdGhleSBuZXZlciB3b3JrZWQgdG8N
Cj4gPiA+ID4gYXZvaWQgY29uZnVzaW5nLCBlc3BlY2lhbGx5IGF0IHRoaXMgZWFybHkgc3RhZ2Ug
Zm9yIG14OC4NCj4gPiA+DQo+ID4gPiBTbyB3aHkgdGhleSBhcmUgdGhlcmUgaWYgdGhleSBuZXZl
ciB3b3JrZWQ/IFdvdWxkbid0IGl0IGEgYmV0dGVyDQo+ID4gPiBhcHByb2FjaCB0byBzdGFydCB3
aXRoIGEgYmFzaWMgYW5kIHdvcmtpbmcgSUQgZmlsZSBhbmQgZXh0ZW5kIHRoaXMNCj4gPiA+IHJh
dGhlciB0aGFuIGFkZGluZyBpZCdzIGJlY2F1c2UgbWF5YmUgdGhlIHdpbGwgd29yay4uDQo+ID4N
Cj4gPiBJZGVhbGx5IHllcywgYnV0IG1heSBiZSBoYXJkIGluIHJlYWxpdHkuDQo+ID4NCj4gPiBT
QyBmaXJtd2FyZSBjb2RlIHVzdWFsbHkgaXMgZGV2ZWxvcGVkIHF1aXRlIGVhcmx5IGJlZm9yZSBz
aWxpY29uIGNvbWVzLg0KPiA+IEJ1dCB0aGUgcmVhbCBjaGlwIG1heSBjaGFuZ2VzLCBlLmcuIHJl
bW92ZWQgb3IgYWRkZWQgc29tZXRoaW5nLg0KPiA+DQo+ID4gQUZBSUsgdGhvc2UgcmVzb3VyY2Ug
SURzIHJlbW92ZWQgaGF2ZSBuZXZlciB3b3JrZWQgaW4gU0MgZmlybXdhcmUsIGFuZA0KPiA+IHRo
ZXkncmUgbGlrZWx5IHRvIGNvbWUgb3V0IG9mIHByZS1zaWxpY29uIGRlZmluaXRpb24uIEJ1dCBj
aGlwIGNoYW5nZXMNCj4gPiBsYXRlci4NCj4gPg0KPiA+ID4gU29ycnkgYnV0IHRoaXMgc2VlbXMg
d3JvbmcgdG8gbWUgdG9vLg0KPiA+ID4gSSBrbm93IHRoZSBhcHByb2FjaCBmcm9tIGRyaXZlciBk
ZXZlbG9wbWVudCwgYWRkaW5nIGEgZHJpdmVyDQo+ID4gPiBzcGVjaWZpYyAqX3JlZy5oIGZpbGUg
YW5kIGxhdGVyIGZpZ3VyaW5nIG91dCB0aGF0IHRob3NlIGJpdHMgd29uJ3QNCj4gPiA+IHdvcmsg
YXMgYXNwZWN0ZWQuIEFzIEkgc2FpZCB0aGlzIHdpbGwgYmUgZHJpdmVyIGFuZCBvbmx5IGxpbnV4
DQo+ID4gPiByZWxhdGVkIHNvIHdlIGNhbiBjaGFuZ2UgdGhlbSBhcyBtYW55IHRpbWVzIGFzIHdl
IHdhbnQuIEJ1dCBpbiB5b3VyDQo+ID4gPiBjYXNlIHdlIGFyZSB0YWxraW5nIGFib3V0IGR0LWJp
bmRpbmdzIGFuZCB0aGlzIGFwcHJvYWNoIHdvbid0IHdvcmsuDQo+ID4NCj4gPiBJIHdvdWxkIGFn
cmVlIHdpdGggeW91IGlmIHRob3NlIHJlc291cmNlIElEcyBoYXZlIHdvcmtlZCBiZWZvcmUuDQo+
ID4gQnV0IHRoZXkgbmV2ZXIgd29ya2VkLg0KPiA+IFNob3VsZCB3ZSBrZWVwIGEgdGhpbmcgbmV2
ZXIgd29ya2VkIGluIGRldmljZSB0cmVlIGp1c3QgYmVjYXVzZSBJdA0KPiA+IG1ha2VzIHVzIGxv
b2sgbGlrZSBrZWVwaW5nIGNvbXBhdGliaWxpdHk/DQo+ID4NCj4gPiBJZiB0aGF0LCBJJ2QgcmF0
aGVyIHJlbW92aW5nIHRoZW0gdG8gYXZvaWQgY29uZnVzaW5nIGluIHRoZSBmdXR1cmUuIExpZmUg
aXMgbG9uZywNCj4gcmlnaHQ/DQo+ID4gSSBkb24ndCB3YW50IHBlb3BsZSB0byBib3RoZXIgd2l0
aCB0aG9zZSB1bm1lYW5pbmcgdGhpbmdzIGFueW1vcmUgd2hlbg0KPiA+IHRoZXkgbG9vayBhdCBp
dC4NCj4gDQo+IFJlbW92aW5nIHRoaW5ncyBpcyB0b3RhbGx5IGZpbmUgaWYgdGhleSBoYXZlIG5l
dmVyIHdvcmtlZC4gUmUtdXNpbmcgdGhlIG5vdw0KPiAiZnJlZSIgSURzIGlzIHdoYXQgaXMgcHJv
YmxlbWF0aWMuIE9ubHkgZXZlciB1c2UgcHJldmlvdXNseSB1bnVzZWQgSURzIHdoZW4NCj4gaW50
cm9kdWNpbmcgbmV3IHN0dWZmIGludG8gdGhlIFNDVSBmaXJtd2FyZS4gVGhpcyBpcyBzb21ldGhp
bmcgeW91IG5lZWQgdG8NCj4gY29tbXVuaWNhdGUgcXVpdGUgY2xlYXJseSB3aXRoIHRoZSBTQ1Ug
ZmlybXdhcmUgZGV2ZWxvcGVycy4NCj4gDQoNClllcywgdGhhdCdzIHJpZ2h0Lg0KSSB3aWxsIGZv
cndhcmQgdGhpcyByZXF1ZXN0IHRvIHRoZW0uDQpUaGFua3MgZm9yIHRoZSBpbmZvLg0KDQpSZWdh
cmRzDQpEb25nIEFpc2hlbmcNCg0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KDQo=
