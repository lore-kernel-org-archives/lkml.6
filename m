Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D42C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEE520864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEE520864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392639AbeKVSTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:19:45 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:48836 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeKVSTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:19:45 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 5CD6067A658;
        Thu, 22 Nov 2018 08:41:28 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 22 Nov
 2018 08:41:27 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Thu, 22 Nov 2018 08:41:27 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     PETER CHEN <peter.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx: Add dummy PHYs for HSIC-only USB
 controllers
Thread-Topic: [PATCH] ARM: dts: imx: Add dummy PHYs for HSIC-only USB
 controllers
Thread-Index: AQHUcOyByFkgdPWrfkqdIzJ4rN8a5KVbbAyAgAAO5IA=
Date:   Thu, 22 Nov 2018 07:41:27 +0000
Message-ID: <f29e4392-f466-df5f-83f6-52e04f27204c@kontron.de>
References: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
 <20181031073112.GL10386@tiger>
 <VI1PR04MB5327E5CE977E59E03B1B6C4C8BDB0@VI1PR04MB5327.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5327E5CE977E59E03B1B6C4C8BDB0@VI1PR04MB5327.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EF0B2843010CE4091BA5D211B8091D4@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 5CD6067A658.A0030
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: devicetree@vger.kernel.org, fabio.estevam@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, peter.chen@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMTEuMTggMDc6NDgsIFBFVEVSIENIRU4gd3JvdGU6DQo+ICAgDQo+Pg0KPj4gT24gVGh1
LCBPY3QgMTgsIDIwMTggYXQgMDk6NDU6MDRBTSArMDIwMCwgRnJpZWRlciBTY2hyZW1wZiB3cm90
ZToNCj4+PiBTb21lIFNPQ3MgaW4gdGhlIGkuTVg2IGZhbWlseSBoYXZlIGEgVVNCIGhvc3QgY29u
dHJvbGxlciB0aGF0IGlzIG9ubHkNCj4+PiBjYXBhYmxlIG9mIHRoZSBIU0lDIGludGVyZmFjZSBh
bmQgaGFzIG5vIG9uLWJvYXJkIFBIWS4NCj4+Pg0KPj4+IFRvIGJlIGFibGUgdG8gdXNlIHRoZXNl
IGNvbnRyb2xsZXJzLCB3ZSBuZWVkIHRvIGFkZCAidXNiLW5vcC14Y2VpdiINCj4+PiBkdW1teSBQ
SFlzLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5z
Y2hyZW1wZkBrb250cm9uLmRlPg0KPj4NCj4+IEBQZXRlciwgbG9va3MgZ29vZCB0byB5b3U/DQo+
Pg0KPj4gU2hhd24NCj4+DQo+Pj4gLS0tDQo+Pj4gICBhcmNoL2FybS9ib290L2R0cy9pbXg2cWRs
LmR0c2kgfCAxNCArKysrKysrKysrKysrKw0KPj4+IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbC5k
dHNpICB8ICA3ICsrKysrKysNCj4+PiBhcmNoL2FybS9ib290L2R0cy9pbXg2c3guZHRzaSAgfCAg
NiArKysrKysNCj4+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+
Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRzaQ0KPj4+IGIvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpIGluZGV4IDYxZDJkMjYuLmQzNDA0ZDEgMTAwNjQ0
DQo+Pj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpDQo+Pj4gKysrIGIvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpDQo+Pj4gQEAgLTEzOSw2ICsxMzksMTYgQEANCj4+
PiAgIAkJaW50ZXJydXB0cyA9IDwwIDk0IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4+ICAgCX07
DQo+Pj4NCj4+PiArCXVzYnBoeW5vcDE6IHVzYnBoeW5vcDEgew0KPj4+ICsJCWNvbXBhdGlibGUg
PSAidXNiLW5vcC14Y2VpdiI7DQo+Pj4gKwkJI3BoeS1jZWxscyA9IDwwPjsNCj4+PiArCX07DQo+
Pj4gKw0KPiANCj4gV2h5ICNwaHktY2VsbHMgcHJvcGVydHkgaXMgbmVlZGVkPyBPdGhlcnMgYXJl
IG9rIGZvciBtZS4NCg0KIEZyb20gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Vz
Yi91c2Itbm9wLXhjZWl2LnR4dDoNCg0KUmVxdWlyZWQgcHJvcGVydGllczoNCi0gY29tcGF0aWJs
ZTogc2hvdWxkIGJlIHVzYi1ub3AteGNlaXYNCi0gI3BoeS1jZWxsczogTXVzdCBiZSAwDQoNCj4g
DQo+IFBldGVyDQo+IA0KPj4+ICsJdXNicGh5bm9wMjogdXNicGh5bm9wMiB7DQo+Pj4gKwkJY29t
cGF0aWJsZSA9ICJ1c2Itbm9wLXhjZWl2IjsNCj4+PiArCQkjcGh5LWNlbGxzID0gPDA+Ow0KPj4+
ICsJfTsNCj4+PiArDQo+Pj4gICAJc29jIHsNCj4+PiAgIAkJI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+Pj4gICAJCSNzaXplLWNlbGxzID0gPDE+Ow0KPj4+IEBAIC05ODEsNiArOTkxLDggQEANCj4+
PiAgIAkJCQlyZWcgPSA8MHgwMjE4NDQwMCAweDIwMD47DQo+Pj4gICAJCQkJaW50ZXJydXB0cyA9
IDwwIDQxIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4+ICAgCQkJCWNsb2NrcyA9IDwmY2xrcyBJ
TVg2UURMX0NMS19VU0JPSDM+Ow0KPj4+ICsJCQkJZnNsLHVzYnBoeSA9IDwmdXNicGh5bm9wMT47
DQo+Pj4gKwkJCQlwaHlfdHlwZSA9ICJoc2ljIjsNCj4+PiAgIAkJCQlmc2wsdXNibWlzYyA9IDwm
dXNibWlzYyAyPjsNCj4+PiAgIAkJCQlkcl9tb2RlID0gImhvc3QiOw0KPj4+ICAgCQkJCWFoYi1i
dXJzdC1jb25maWcgPSA8MHgwPjsNCj4+PiBAQCAtOTk0LDYgKzEwMDYsOCBAQA0KPj4+ICAgCQkJ
CXJlZyA9IDwweDAyMTg0NjAwIDB4MjAwPjsNCj4+PiAgIAkJCQlpbnRlcnJ1cHRzID0gPDAgNDIg
SVJRX1RZUEVfTEVWRUxfSElHSD47DQo+Pj4gICAJCQkJY2xvY2tzID0gPCZjbGtzIElNWDZRRExf
Q0xLX1VTQk9IMz47DQo+Pj4gKwkJCQlmc2wsdXNicGh5ID0gPCZ1c2JwaHlub3AyPjsNCj4+PiAr
CQkJCXBoeV90eXBlID0gImhzaWMiOw0KPj4+ICAgCQkJCWZzbCx1c2JtaXNjID0gPCZ1c2JtaXNj
IDM+Ow0KPj4+ICAgCQkJCWRyX21vZGUgPSAiaG9zdCI7DQo+Pj4gICAJCQkJYWhiLWJ1cnN0LWNv
bmZpZyA9IDwweDA+Ow0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2c2wu
ZHRzaQ0KPj4+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsLmR0c2kgaW5kZXggN2E0ZjVkYS4u
ODFlZGNkYyAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2c2wuZHRzaQ0K
Pj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbC5kdHNpDQo+Pj4gQEAgLTExMCw2ICsx
MTAsMTEgQEANCj4+PiAgIAkJaW50ZXJydXB0cyA9IDwwIDk0IElSUV9UWVBFX0xFVkVMX0hJR0g+
Ow0KPj4+ICAgCX07DQo+Pj4NCj4+PiArCXVzYnBoeW5vcDE6IHVzYnBoeW5vcDEgew0KPj4+ICsJ
CWNvbXBhdGlibGUgPSAidXNiLW5vcC14Y2VpdiI7DQo+Pj4gKwkJI3BoeS1jZWxscyA9IDwwPjsN
Cj4+PiArCX07DQo+Pj4gKw0KPj4+ICAgCXNvYyB7DQo+Pj4gICAJCSNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KPj4+ICAgCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4+PiBAQCAtODE1LDYgKzgyMCw4IEBA
DQo+Pj4gICAJCQkJcmVnID0gPDB4MDIxODQ0MDAgMHgyMDA+Ow0KPj4+ICAgCQkJCWludGVycnVw
dHMgPSA8MCA0MCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4+PiAgIAkJCQljbG9ja3MgPSA8JmNs
a3MgSU1YNlNMX0NMS19VU0JPSDM+Ow0KPj4+ICsJCQkJZnNsLHVzYnBoeSA9IDwmdXNicGh5bm9w
MT47DQo+Pj4gKwkJCQlwaHlfdHlwZSA9ICJoc2ljIjsNCj4+PiAgIAkJCQlmc2wsdXNibWlzYyA9
IDwmdXNibWlzYyAyPjsNCj4+PiAgIAkJCQlkcl9tb2RlID0gImhvc3QiOw0KPj4+ICAgCQkJCWFo
Yi1idXJzdC1jb25maWcgPSA8MHgwPjsNCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvaW14NnN4LmR0c2kNCj4+PiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzeC5kdHNpIGluZGV4
IDg0NGNhYTMuLjA3ZWQ0MTcgMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14
NnN4LmR0c2kNCj4+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2c3guZHRzaQ0KPj4+IEBA
IC0xNTksNiArMTU5LDExIEBADQo+Pj4gICAJCWludGVycnVwdHMgPSA8R0lDX1NQSSA5NCBJUlFf
VFlQRV9MRVZFTF9ISUdIPjsNCj4+PiAgIAl9Ow0KPj4+DQo+Pj4gKwl1c2JwaHlub3AxOiB1c2Jw
aHlub3AxIHsNCj4+PiArCQljb21wYXRpYmxlID0gInVzYi1ub3AteGNlaXYiOw0KPj4+ICsJCSNw
aHktY2VsbHMgPSA8MD47DQo+Pj4gKwl9Ow0KPj4+ICsNCj4+PiAgIAlzb2Mgew0KPj4+ICAgCQkj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+PiAgIAkJI3NpemUtY2VsbHMgPSA8MT47DQo+Pj4gQEAg
LTg3Nyw2ICs4ODIsNyBAQA0KPj4+ICAgCQkJCXJlZyA9IDwweDAyMTg0NDAwIDB4MjAwPjsNCj4+
PiAgIAkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNDAgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+
Pj4gICAJCQkJY2xvY2tzID0gPCZjbGtzIElNWDZTWF9DTEtfVVNCT0gzPjsNCj4+PiArCQkJCWZz
bCx1c2JwaHkgPSA8JnVzYnBoeW5vcDE+Ow0KPj4+ICAgCQkJCWZzbCx1c2JtaXNjID0gPCZ1c2Jt
aXNjIDI+Ow0KPj4+ICAgCQkJCXBoeV90eXBlID0gImhzaWMiOw0KPj4+ICAgCQkJCWZzbCxhbmF0
b3AgPSA8JmFuYXRvcD47DQo+Pj4gLS0NCj4+PiAyLjcuNA0KPj4+
